Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263713AbUEGUCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUEGUCu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263167AbUEGUC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:02:29 -0400
Received: from over.ny.us.ibm.com ([32.97.182.111]:38857 "EHLO
	over.ny.us.ibm.com") by vger.kernel.org with ESMTP id S263713AbUEGUAo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 16:00:44 -0400
Date: Fri, 7 May 2004 08:04:15 -0500
From: "Jose R. Santos" <jrsantos@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Jose R. Santos" <jrsantos@austin.ibm.com>, linux-kernel@vger.kernel.org,
       anton@samba.org, dheger@us.ibm.com, slpratt@us.ibm.com
Subject: Re: [PATCH] dentry and inode cache hash algorithm performance changes.
Message-ID: <20040507130415.GA1537@rx8.ibm.com>
References: <20040430191539.GC14271@rx8.ibm.com> <20040430131832.45be6956.akpm@osdl.org> <20040430205701.GG14271@rx8.ibm.com> <20040430213324.GK14271@rx8.ibm.com> <20040430150256.25735762.akpm@osdl.org> <20040504131223.GA28009@austin.ibm.com> <20040504115510.696184dc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040504115510.696184dc.akpm@osdl.org> (from akpm@osdl.org on Tue, May 04, 2004 at 13:55:10 -0500)
X-Mailer: Balsa 2.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/04 13:55:10, Andrew Morton wrote:
> > Andrew - Is there any workload you want me to run to show that this hash
> > function is going to be equal or better that the one already provided
> > in Linux?
> 
> Not really - it sounds like you've covered it pretty well.  Did you try SDET?
> 
> It could be that reducing the hash table size will turn pretty much any
> workload into a test of the hash quality.

Sorry for the late reply...

Steve Pratt seem to have a SDET setup already and he did me the favor of 
running SDET with a reduce dentry entry hash table size.  I belive that
his table suggest that less than 3% change is acceptable variability, but
overall he got a 5% better number using the new hash algorith.

-JRS

=========================================================================
A) x4408way1.sdet.2.6.5100000-8p.04-05-05_12.08.44 vs 
B) x4408way1.sdet.2.6.5+hash-100000-8p.04-05-05_11.48.02


<6>Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
<4>Inode-cache hash table entries: 1048576 (order: 10, 4194304 bytes) 

Results:Throughput 

                                          tolerance = 0.00 + 3.00% of A
                      A            B
   Threads      Ops/sec      Ops/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1    4341.9300    4401.9500     1.38        60.02       130.26 
         2    8242.2000    8165.1200    -0.94       -77.08       247.27 
         4   15274.4900   15257.1000    -0.11       -17.39       458.23 
         8   21326.9200   21320.7000    -0.03        -6.22       639.81 
        16   23056.2100   24282.8000     5.32      1226.59       691.69  * 
        32   23397.2500   24684.6100     5.50      1287.36       701.92  * 
        64   23372.7600   23632.6500     1.11       259.89       701.18 
       128   17009.3900   16651.9600    -2.10      -357.43       510.28 
=========================================================================
