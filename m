Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262590AbREZXGg>; Sat, 26 May 2001 19:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262558AbREZXFH>; Sat, 26 May 2001 19:05:07 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:52685 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S261892AbREZXED>;
	Sat, 26 May 2001 19:04:03 -0400
Message-ID: <3B102822.625E01DF@mandrakesoft.com>
Date: Sat, 26 May 2001 18:03:14 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Ingo T. Storm" <it@lapavoni.de>
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Re: 2.4.5 does not link on Ruffian (alpha)
In-Reply-To: <3B0BFE90.CE148B7@kjist.ac.kr> <20010523210923.A730@athlon.random> <022e01c0e5fc$39ac0cf0$2e2ca8c0@buxtown.de>
Content-Type: multipart/mixed;
 boundary="------------AE1652C99B0AD6FA6DF99493"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------AE1652C99B0AD6FA6DF99493
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"Ingo T. Storm" wrote:
> I just tried to compile 2.4.5 on a Ruffian. With CPU selection "generic" it
> fails when linking the kernel (see below). With CPU=Ruffian, it compiles and
> links fine. Haven't tried booting yet, 'cause the machine is some 20 miles
> away from here.

> ld  -r -o kernel.o entry.o traps.o process.o osf_sys.o irq.o irq_alpha.o
> signal.
> o setup.o ptrace.o time.o semaphore.o alpha_ksyms.o irq_i8259.o irq_srm.o
> es1888
> .o smc37c669.o smc37c93x.o ns87312.o pci.o pci_iommu.o core_apecs.o
> core_cia.o c
> ore_irongate.o core_lca.o core_mcpcia.o core_polaris.o core_t2.o
> core_tsunami.o
> core_titan.o sys_alcor.o sys_cabriolet.o sys_dp264.o sys_eb64p.o sys_eiger.o
> sys
> _jensen.o sys_miata.o sys_mikasa.o sys_nautilus.o sys_titan.o sys_noritake.o
> sys
> _rawhide.o sys_ruffian.o sys_rx164.o sys_sable.o sys_sio.o sys_sx164.o
> sys_takar
> a.o sys_wildfire.o core_wildfire.o irq_pyxis.o
> sys_dp264.o: In function `tsunami_inb':
> sys_dp264.c(.text+0x440): multiple definition of `tsunami_inb'
> core_tsunami.o(.text+0x500):core_tsunami.c: first defined here

I used the attached patch to fix the problem.

(note the tty.h changes are unrelated...  they are preparing for when
sched.h no longer includes tty.h, fixing a nasty include loop)

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
--------------AE1652C99B0AD6FA6DF99493
Content-Type: text/plain; charset=us-ascii;
 name="alpha.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alpha.patch"

Index: arch/alpha/kernel/process.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/arch/alpha/kernel/process.c,v
retrieving revision 1.1.1.14
diff -u -r1.1.1.14 process.c
--- arch/alpha/kernel/process.c	2001/05/25 01:09:03	1.1.1.14
+++ arch/alpha/kernel/process.c	2001/05/26 22:00:59
@@ -28,6 +28,7 @@
 #include <linux/mman.h>
 #include <linux/elfcore.h>
 #include <linux/reboot.h>
+#include <linux/tty.h>
 #include <linux/console.h>
 
 #include <asm/reg.h>
Index: arch/alpha/kernel/sys_dp264.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/arch/alpha/kernel/sys_dp264.c,v
retrieving revision 1.1.1.10
diff -u -r1.1.1.10 sys_dp264.c
--- arch/alpha/kernel/sys_dp264.c	2001/05/26 04:03:59	1.1.1.10
+++ arch/alpha/kernel/sys_dp264.c	2001/05/26 22:01:00
@@ -16,7 +16,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 
-#define __EXTERN_INLINE inline
+#define __EXTERN_INLINE extern inline
 #include <asm/io.h>
 #include <asm/core_tsunami.h>
 #undef  __EXTERN_INLINE
Index: arch/alpha/kernel/sys_sio.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/arch/alpha/kernel/sys_sio.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 sys_sio.c
--- arch/alpha/kernel/sys_sio.c	2000/10/30 19:47:55	1.1.1.2
+++ arch/alpha/kernel/sys_sio.c	2001/05/26 22:01:00
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/tty.h>
 
 #include <asm/compiler.h>
 #include <asm/ptrace.h>

--------------AE1652C99B0AD6FA6DF99493--

