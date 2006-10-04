Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161215AbWJDPWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161215AbWJDPWN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 11:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161232AbWJDPWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 11:22:13 -0400
Received: from warsl404pip8.highway.telekom.at ([195.3.96.102]:60456 "EHLO
	email.aon.at") by vger.kernel.org with ESMTP id S1161215AbWJDPWL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 11:22:11 -0400
Date: Wed, 04 Oct 2006 17:28:20 +0200
To: linux-kernel@vger.kernel.org
Subject: Renicing mencoder to something lower than 0 causes (whole) system to stuck (cx88 chipset)
From: "Wiesner Thomas" <thomas@bau-konform.at>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <op.tgwk9imz88izfi@barton2>
User-Agent: Opera Mail/9.02 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've already reported this to kraxel@bytesex.org which should be the  
maintainer's email
address (according Documentation/video4linux/...). I mailed this about 3  
weeks ago and got
no response at all, but I think that this issue might be interesting so I  
post it here again:



I've got an strange problem with mencoder from mplayer 1.0pre8 here  
(selfcompiled, linux kernel 2.6.17.1).

Running just mencoder to record from my TV card (cx88 chipset) works fine.
The card is a Hauppauge WinTV PCI-FM.

But when I renice it to a negative priority (-1 is enough to trigger it),  
the whole system (even all the linux text terminals with no X running)  
gets unresponsive and stucks every second or so for about a 0.5 seconds  
and mencoder drops more frames than before than without
renicing.
mencoder uses about 80% CPU but the problem occurs on "only" 60% CPU usage  
too. I tested an "endless loop program" if this is a general renicing  
problem, but it isn't, I would need
to renice an endless loop to something below about -10 to cause a stucking  
mencoder creates
at only -1.

Googling around didn't lead to any useful results, I've asked in #mplayer  
and #kernel
but no one knew an answer.
Someone in #mplayerdev suggested it's likely a kernel bug causing me to  
write this report.

If I renice mencoder to a positive value it works better than than to a  
negative and doesn't
cause the system to stuck. (This leads me to not touching the priority at  
all but there must
be a problem somwhere because everything stucks terribly. Of course,  
renicing to a positive
value makes no sense because I would drop frames if the system load goes  
up due to other processes. What I want to point out, that if I renice it  
to +1 it works _better_ than
renicing it to -1, because it starts to drop frames immediately if I  
renice it to something lower
than 0 even if the system load is only about 60%.)

------------------------------------------------------------------------------
System information:

Mencoder output:
MEncoder 1.0pre8-3.3.5 (C) 2000-2006 MPlayer Team
CPU: AMD Athlon(tm) XP 3200+ (Family: 6, Model: 10, Stepping: 0)
CPUflags: Type: 6 MMX: 1 MMX2: 1 3DNow: 1 3DNow2: 1 SSE: 1 SSE2: 0
Compiled for x86 CPU with extensions: MMX MMX2 3DNow 3DNowEx SSE

(Compiled with xvid and lame support)

uname -a output:
Linux barton 2.6.17.1v4l #2 Mon Aug 21 20:47:56 CEST 2006 i686 GNU/Linux

lspci -v output (TV card section):
0000:01:0a.0 Multimedia video controller: Conexant Winfast TV2000 XP (rev  
05)
         Subsystem: Hauppauge computer works Inc.: Unknown device 3401
         Flags: bus master, medium devsel, latency 32, IRQ 20
         Memory at e7000000 (32-bit, non-prefetchable) [size=16M]
         Capabilities: [44] Vital Product Data
         Capabilities: [4c] Power Management version 2

Lame version 3.96.1 (compiled from source)
xvidcore version: 1.1.0 (compiled from source)
ffmpeg version: cvs20060823 with debian patch  
(ffmpeg_0.cvs20060823-3.diff) (compiled from source)

/proc/cpuinfo:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) XP 3200+
stepping        : 0
cpu MHz         : 2194.412
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca  
cmov
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow up ts
bogomips        : 4393.35


------------------------------------------------------------------------------

Thank you for reading, fell free to ask for further information if needed.

(Please CC me, as I am not in the list.)

     Wiesner Thomas

