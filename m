Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129385AbQKRSww>; Sat, 18 Nov 2000 13:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130462AbQKRSwn>; Sat, 18 Nov 2000 13:52:43 -0500
Received: from web3401.mail.yahoo.com ([204.71.203.55]:37129 "HELO
	web3407.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129385AbQKRSwg>; Sat, 18 Nov 2000 13:52:36 -0500
Message-ID: <20001118182230.14470.qmail@web3407.mail.yahoo.com>
Date: Sat, 18 Nov 2000 19:22:30 +0100 (CET)
From: Markus Schoder <markus_schoder@yahoo.de>
Subject: Re: Freeze on FPU exception with Athlon
To: Linus Torvalds <torvalds@transmeta.com>,
        Brian Gerst <bgerst@didntduck.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Linus Torvalds <torvalds@transmeta.com> wrote: > 

> If I'm right, the proper test-program should be
> something like
> 

Your test program is indeed sufficient to trigger the
freeze.  Unfortunately the patch does not make a
difference :(

My test program caused the exception (and the freeze)
unintendedly in the return statement since the
division was optimized away as Brian pointed out.

Some more data points:

SysRq is definitely not working after the freeze :(
Judging from the processor temperature after rebooting
the processor is very busy.

I know of another guy with the exact same CPU (Athlon
Thunderbird 900MHz) and mainboard (ABIT KT7-RAID) who
has the same problem.

I use gcc 2.95.2 to compile the kernel.

I couldn't so far find out where the problem was
introduced since the older 2.4.0-test kernels do not
support the HPT370.  I will recable the drive to the
primary controller and try again.

I will also try to compile a non AMD specific kernel
and see if that makes a difference.  If just this 40GB
drive would fsck faster :)

Note that cpuinfo shows model 4 whereas e.g. Brian had
model 2 if that means anything.

/proc/cpuinfo:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 900.000063
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
features        : fpu vme de pse tsc msr pae mce cx8
sep mtrr pge mca cmov pat pse36 mmx fxsr syscall
mmxext 3dnowext 3dnow
bogomips        : 1795.69


--
Markus


__________________________________________________________________
Do You Yahoo!?
Gesendet von Yahoo! Mail - http://mail.yahoo.de
Gratis zum Millionär! - http://10millionenspiel.yahoo.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
