Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751563AbWAIWcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbWAIWcu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbWAIWcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:32:50 -0500
Received: from 80-219-179-15.dclient.hispeed.ch ([80.219.179.15]:17801 "EHLO
	mx.eriadon.com") by vger.kernel.org with ESMTP id S1751557AbWAIWct
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:32:49 -0500
From: Edmondo Tommasina <edmondo@eriadon.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Athlon 64 X2 cpuinfo oddities
Date: Mon, 9 Jan 2006 23:32:32 +0100
User-Agent: KMail/1.9
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       LKML List <linux-kernel@vger.kernel.org>,
       "Discuss x86-64" <discuss@x86-64.org>
References: <9a8748490601091218m1ff0607h79207cfafe630864@mail.gmail.com> <200601092210.04186.rjw@sisk.pl>
In-Reply-To: <200601092210.04186.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601092332.32681.edmondo@eriadon.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09-January-2006 22:10, Rafael J. Wysocki wrote:
> Hi,
> 
> On Monday, 9 January 2006 21:18, Jesper Juhl wrote:
> > I recently bought a Dual Core AMD Athlon 64 X2 4400+ CPU and dropped a
> > 2.6.15 kernel on the box and it runs very nice, but /proc/cpuinfo
> > shows a few things that seem slightly odd to me (haven't tried earlier
> > kernels on this so I don't know if cpuinfo looked different
> > previously).
> > It may be that it's absolutely correct and not odd at all, but I
> > thought I'd just ask :)
> > 
> > Here's what  cat /proc/cpuinfo  shows :
> > 
> > juhl@dragon:~$ cat /proc/cpuinfo
> > processor       : 0
> > vendor_id       : AuthenticAMD
> > cpu family      : 15
> > model           : 35
> > model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
> > stepping        : 2
> > cpu MHz         : 2200.260
> > cache size      : 1024 KB
> > physical id     : 0
> > siblings        : 1
> > core id         : 0
> > cpu cores       : 1
> > fdiv_bug        : no
> > hlt_bug         : no
> > f00f_bug        : no
> > coma_bug        : no
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 1
> > wp              : yes
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> > mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
> > fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
> > bogomips        : 4403.36
> > 
> > processor       : 1
> > vendor_id       : AuthenticAMD
> > cpu family      : 15
> > model           : 35
> > model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
> > stepping        : 2
> > cpu MHz         : 2200.260
> > cache size      : 1024 KB
> > physical id     : 127
> > siblings        : 1
> > core id         : 1
> > cpu cores       : 1
> > fdiv_bug        : no
> > hlt_bug         : no
> > f00f_bug        : no
> > coma_bug        : no
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 1
> > wp              : yes
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> > mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
> > fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
> > bogomips        : 4399.53
> > 
> > 
> > So, what's odd with that?
> > 
> > Well, first of all you'll notice that the second core shows a
> > "physical id" of 127 while the first core shows an id of 0.  Shouldn't
> > the second core be id 1, just like the "core id" fields are 0 & 1?
> 
> FWIW, I'm running 2.6.15 on Athlon X2 4200 and the second core's
> physical id is 0 (ie. same as of the frist one), the number of siblings
> for each core is 2, and the "cpu cores" value is 2 as well (yours is 1,
> apparently ;-)).

Same here. cpu cores is 2.

Random try: Do you have CONFIG_NR_CPUS=2 in your config?


edmondo@balrog ~ $ uname -a
Linux balrog 2.6.15 #1 SMP Tue Jan 3 19:44:52 CET 2006 x86_64
AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ AuthenticAMD GNU/Linux
edmondo@balrog ~ $ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
stepping        : 2
cpu MHz         : 1005.170
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
 mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
 fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips        : 2012.38
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
stepping        : 2
cpu MHz         : 1005.170
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
 mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
 fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips        : 2012.38
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp


ciao
edmondo
