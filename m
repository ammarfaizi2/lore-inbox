Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262585AbTCRURo>; Tue, 18 Mar 2003 15:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262578AbTCRURn>; Tue, 18 Mar 2003 15:17:43 -0500
Received: from mailrelay1.lanl.gov ([128.165.4.101]:18344 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S262585AbTCRURj>; Tue, 18 Mar 2003 15:17:39 -0500
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4
	due to wrmsr (performance)
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Brian Gerst <bgerst@didntduck.org>, Kevin Pedretti <ktpedre@sandia.gov>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303181113590.13708-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0303181113590.13708-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 18 Mar 2003 13:24:07 -0700
Message-Id: <1048019047.4302.29.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-18 at 12:21, Linus Torvalds wrote:
> 
> On Tue, 18 Mar 2003, Brian Gerst wrote:
> > 
> > Here's a few more data points:
> 
> Ok, this shows the behaviour I was trying to explain:
> 
> > vendor_id       : AuthenticAMD
> > cpu family      : 5
> > model           : 8
> > model name      : AMD-K6(tm) 3D processor
> > stepping        : 12
> > cpu MHz         : 451.037
> > empty overhead=105 cycles
> > load overhead=-2 cycles
> > I$ load overhead=30 cycles
> > I$ load overhead=90 cycles
> > I$ store overhead=95 cycles
> 
> ie loading from the same cacheline shows bad behaviour, most likely due to 
> cache line exclusion. Does anybody have an original Pentium to see if I 
> remember that one right?

Does this help?

[steven@trendb steven]$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 2
model name      : Pentium 75 - 200
stepping        : 12
cpu MHz         : 166.196198
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8
bogomips        : 331.78

[steven@trendb steven]$ uptime
 12:17pm  up 272 days,  6:35,  2 users,  load average: 0.02, 0.01, 0.00

[steven@trendb steven]$ ./linus1
empty overhead=76 cycles
load overhead=10 cycles
I$ load overhead=34 cycles
I$ load overhead=23 cycles
I$ store overhead=25 cycles


