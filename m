Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbTK3JgH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 04:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263412AbTK3JgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 04:36:07 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:52869 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263389AbTK3JgC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 04:36:02 -0500
Message-ID: <3FC9B9FD.3000404@cyberone.com.au>
Date: Sun, 30 Nov 2003 20:35:57 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Andi Kleen <ak@colin2.muc.de>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@muc.de>, Con Kolivas <kernel@kolivas.org>,
       Andrew Morton <akpm@osdl.org>, jbarnes@sgi.com, efocht@hpce.nec.com,
       John Hawkes <hawkes@sgi.com>, wookie@osdl.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: [RFC] Further SMP / NUMA scheduler improvements
References: <20031117021511.GA5682@averell> <3FB83790.3060003@cyberone.com.au> <20031117141548.GB1770@colin2.muc.de> <Pine.LNX.4.56.0311171638140.29083@earth> <20031118173607.GA88556@colin2.muc.de> <Pine.LNX.4.56.0311181846360.23128@earth> <20031118235710.GA10075@colin2.muc.de> <3FBAF84B.3050203@cyberone.com.au> <501330000.1069443756@flay> <3FBF099F.8070403@cyberone.com.au>
In-Reply-To: <3FBF099F.8070403@cyberone.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.kerneltrap.org/~npiggin/w25/

Been sorting some bugs out. Its pretty stable. Although CONFIG_SMT
is still apparently broken. It will probably stay that way due to not
having an SMP P4 to test with and being a bit busy with other things.

I have done some tweaking of the "domains", and found some pretty
impressive performance improvements. The 16-way NUMAQ at OSDL is
running out of steam now (ie. I've got quite a bit of low hanging
fruit), and I've only got a couple more days with it anyway. So I'd
like other architectures especially to try it if interested.

I could assist in building architecture specific scheduling descriptions
if anyone would like to try it on a non traditional SMP / NUMA, however
I think something might be broken with SMT handling. Probably active
migration. I can't be bothered fixing it unless I can find an SMP P4 HT
to test with :P

(dbench is most significantly improved)

System is dev16-000 at OSDL. total/idle ticks are profiler ticks.
16GB ram, 4x4 nodes NUMAQ
model name      : Pentium III (Katmai)
cpu MHz         : 495.274
cache size      : 512 KB
 
dbench                  8       16      32      64      128
bk19                    470.84  433.47  360.04  351.96  359.86
w22                     477.35  439.82  387.77  378.65  367.07
w25                     473.10  587.74  503.35  532.83  524.61
total/idle ticks
bk19                    3598603/124601
w22                     3425876/227225
w25                     2408853/232176
 
tbench                  8       16      24      32
bk19                    46.17   58.74   60.78   59.79
w22                     47.39   58.72   57.73   57.86
w25                     53.59   58.60   65.80   63.35
total/idle ticks
bk19                    7603448/1115754
w22                     7808203/1897589
w25                     7150680/2038258
                                                                                

kernbench (make -j, 5 runs)     real    user    sys
bk19                            82.231  997.021 152.044
w22                             81.384  973.653 140.246
w25                             80.650  970.900 131.833
total/idle ticks
bk19                            2218739/1442831
w22                             2110820/1398357
w25                             2062930/1393573
                                                                                

                                                                                

hackbench (3 runs)      1       100
bk19                    0.591   37.578
w22                     0.386   31.954
w25                     0.365   33.289
total/idle ticks
bk19                    1948913/319060
w22                     1655610/360777
w25                     1721178/496178
                                                                                

reaim 256               parent time  child stime  child utime  jpm
bk19                    247.33       373.57       3568.12      6396.64
w22                     250.37       332.70       3614.94      6318.97
w25                     258.67       311.85       3684.09      6116.21


