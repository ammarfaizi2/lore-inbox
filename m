Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266186AbSKTORv>; Wed, 20 Nov 2002 09:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266191AbSKTORv>; Wed, 20 Nov 2002 09:17:51 -0500
Received: from pop018pub.verizon.net ([206.46.170.212]:43172 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP
	id <S266186AbSKTORg>; Wed, 20 Nov 2002 09:17:36 -0500
Message-ID: <3DDB9B23.9030001@lemur.sytes.net>
Date: Wed, 20 Nov 2002 09:24:35 -0500
From: Mathias Kretschmer <mathias@lemur.sytes.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en, zh-tw
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Recognize Tualatin cache size in 2.4.x
References: <3DDAE846.6080503@lemur.sytes.net> <20021120131502.GA1768@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at pop018.verizon.net from [151.198.132.245] at Wed, 20 Nov 2002 08:24:35 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Tue, Nov 19, 2002 at 08:41:26PM -0500, Mathias Kretschmer wrote:
>  > I just patched my 2.4.20rc2 kernel. Now, it reports
>  > 512K cache for my 2 Tualatin 1.26 GHz CPUs.
>  > 
>  > 'time make -j4 bzImage' went down from 3:30 to 3:04.
>  > Not too bad.
> 
> That is quite an impressive gain.  The patch I sent Marcelo which
> also fixes up a problem with some tualatins and adds P4 trace cache
> support is at..
> 
> ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.4/2.4.20/descriptors.diff
> 
> As you have tualatins can you try with the above patch and make sure
> theres no regressions there ?

Hi Dave,

Here are the results. I've upgraded to gcc-3.2.1 yesterday evening.
Hence, we can not compare to the results from yesterday.
The ones below are new:

2.4.20rc2+small-patch (ran it three times with very similar results):
265.05user 16.66system 2:43.09elapsed 172%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (621129major+1391627minor)pagefaults 0swaps

2.4.20rc2-descriptors.diff (also run three times):
302.60user 16.95system 2:43.39elapsed 195%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (621129major+1390848minor)pagefaults 0swaps

Pretty much the same result - within the tolerance.
%CPU is up quite a bit.

Also, my optimization options are '-Os -march=pentium3'.

The machine was idle but still in multi-user mode. If
you need more precise results, I could do that over the weekend.

Cheers,

Mathias

---

 > cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Pentium(R) III CPU family      1266MHz
stepping        : 1
cpu MHz         : 1280.932
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse
bogomips        : 2555.90

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Pentium(R) III CPU family      1266MHz
stepping        : 1
cpu MHz         : 1280.932
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse
bogomips        : 2555.90

