Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132028AbRBFAGL>; Mon, 5 Feb 2001 19:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132060AbRBFAGC>; Mon, 5 Feb 2001 19:06:02 -0500
Received: from mail-dns2-nj.dialogic.com ([146.152.228.11]:48648 "EHLO
	mail-dns2-nj.dialogic.com") by vger.kernel.org with ESMTP
	id <S136050AbRBFAFq>; Mon, 5 Feb 2001 19:05:46 -0500
Message-ID: <EFC879D09684D211B9C20060972035B1D4686C@exchange2ca.sv.dialogic.com>
From: "Miller, Brendan" <Brendan.Miller@Dialogic.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: smp_num_cpus redefined?  (compiling 2.2.18 for non-SMP?)
Date: Mon, 5 Feb 2001 19:06:58 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a problem that would have started out as "I can't compile my device
driver with 2.2.18".  I was compiling my device driver for non-SMP while my
kernel (and thus /usr/src/linux) was SMP.  So I looked at compiling the
kernel for non-SMP so that my /usr/src/linux would be non-SMP and my device
driver would match.  Well, now just compiling 2.2.18 for non-SMP, I get

[root@multnomah linux]# make
cc -D__KERNEL__ -I/usr/src/linux-2.2.18/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -
fno-strict-aliasing -pipe -fno-strength-reduce -m486 -malign-loops=2
-malign-jumps=2 -malign-functio
ns=2 -DCPU=686 -DUTS_MACHINE='"i386"' -c -o init/version.o init/version.c
make -C  kernel
make[1]: Entering directory `/usr/src/linux-2.2.18/kernel'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.2.18/kernel'
cc -D__KERNEL__ -I/usr/src/linux-2.2.18/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -
fno-strict-aliasing -pipe -fno-strength-reduce -m486 -malign-loops=2
-malign-jumps=2 -malign-functio
ns=2 -DCPU=686   -DEXPORT_SYMTAB -c ksyms.c
In file included from /usr/src/linux-2.2.18/include/linux/modversions.h:16,
                 from /usr/src/linux-2.2.18/include/linux/module.h:19,
                 from ksyms.c:14:
/usr/src/linux-2.2.18/include/linux/modules/i386_ksyms.ver:64: warning:
`cpu_data' redefined
/usr/src/linux-2.2.18/include/asm/processor.h:98: warning: this is the
location of the previous defi
nition
/usr/src/linux-2.2.18/include/linux/modules/i386_ksyms.ver:74: warning:
`smp_num_cpus' redefined
/usr/src/linux-2.2.18/include/linux/smp.h:77: warning: this is the location
of the previous definiti
on
/usr/src/linux-2.2.18/include/linux/modules/i386_ksyms.ver:78: warning:
`cpu_online_map' redefined
/usr/src/linux-2.2.18/include/linux/smp.h:84: warning: this is the location
of the previous definiti
on
/usr/src/linux-2.2.18/include/linux/modules/i386_ksyms.ver:100: warning:
`smp_call_function' redefin
ed
/usr/src/linux-2.2.18/include/linux/smp.h:83: warning: this is the location
of the previous definiti
on
In file included from /usr/src/linux-2.2.18/include/linux/interrupt.h:51,
                 from ksyms.c:21:
/usr/src/linux-2.2.18/include/asm/hardirq.h:23: warning: `synchronize_irq'
redefined
/usr/src/linux-2.2.18/include/linux/modules/i386_ksyms.ver:80: warning: this
is the location of the
previous definition
In file included from /usr/src/linux-2.2.18/include/linux/interrupt.h:52,
                 from ksyms.c:21:
/usr/src/linux-2.2.18/include/asm/softirq.h:75: warning: `synchronize_bh'
redefined
/usr/src/linux-2.2.18/include/linux/modules/i386_ksyms.ver:82: warning: this
is the location of the
previous definition
/usr/src/linux-2.2.18/include/linux/kernel_stat.h: In function `kstat_irqs':
In file included from ksyms.c:17:
/usr/src/linux-2.2.18/include/linux/kernel_stat.h:47: `smp_num_cpus'
undeclared (first use in this f
unction)
/usr/src/linux-2.2.18/include/linux/kernel_stat.h:47: (Each undeclared
identifier is reported only o
nce
/usr/src/linux-2.2.18/include/linux/kernel_stat.h:47: for each function it
appears in.)
make[2]: *** [ksyms.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.2.18/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.2.18/kernel'
make: *** [_dir_kernel] Error 2

I get these same warnings when I compile my driver against either SMP or
non-SMP 2.2.18 source.  FWIW, everything is fine with 2.2.14.  But I need
2.2.18 for the NFS fixups.  I've searched for this "smp_num_cpus" redefined,
and it seems that others have had the same problem, but no solutions have
been posted.

Did I describe the problem adequately?  Is there a solution?

Please cc: me as I'm not on the list.

Brendan Miller
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
