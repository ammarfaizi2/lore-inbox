Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310387AbSCPOn4>; Sat, 16 Mar 2002 09:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310391AbSCPOnq>; Sat, 16 Mar 2002 09:43:46 -0500
Received: from [63.204.6.12] ([63.204.6.12]:21444 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S310387AbSCPOne>;
	Sat, 16 Mar 2002 09:43:34 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15507.22980.217699.244120@somanetworks.com>
Date: Sat, 16 Mar 2002 09:42:12 -0500
From: "Georg Nikodym" <georgn@somanetworks.com>
To: linux-kernel@vger.kernel.org
Subject: MCE hangs on 2.4.19-pre3-rmap12g
X-Mailer: VM 7.00 under 21.5  (beta4) "bamboo" XEmacs Lucid
Reply-To: georgn@somanetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In 2.4.19-pre3, Marcelo added CONFIG_X86_MCE (Machine Check
Exception).  I'm running from Rik's bk available -rmap12g tree.

I've tried enabling this option on both a T20 (IBM) and an i8k (Dell).
(I became interested in the option when one of them started having
flakiness which I briefly thought might be heat related).

Both laptops hang very early in the boot process after emitting the
message:

    Intel machine check architecture supported

Kind of a drag since the keyboard isn't alive yet, so power cycling is
your only option at this point.

I'm not particularly concerned except that the help for this option
ends with the sentences:

    Similarly, if MCE is built in and creates a problem on some new
    non-standard machine, you can boot with "nomce" to disable it.

I think that "creates a problem" understates the observed "prevents
your machine from booting".

    MCE support simply ignores non-MCE processors like the 386 and
    486, so nearly everyone can say Y here.

This reads like an encouragement when there should really be a
warning.

Here's the cpuinfo if each machine.  Perhaps one of the x86
cognoscenti can tell me that I'm a dolt, that the flags: like clearly
indicates that CONFIG_X86_MCE can never work.

Thinkpad T20:

(lou) 1001$ cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 746.766
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1490.94

Dell Inspiron 8000:

(keller) 1001$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 996.692
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1985.74
