Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130204AbRAFUB2>; Sat, 6 Jan 2001 15:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131188AbRAFUBJ>; Sat, 6 Jan 2001 15:01:09 -0500
Received: from hermes.cs.kuleuven.ac.be ([134.58.40.3]:3016 "EHLO
	hermes.cs.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S130204AbRAFUBH>; Sat, 6 Jan 2001 15:01:07 -0500
Date: Sat, 6 Jan 2001 20:45:10 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Christian T. Steigies" <cts@debian.org>
cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: asm/ vs linux/delay.h (was: Re: 2.4.0)
In-Reply-To: <20010106161836.A1596@skeeve.ddts.net>
Message-ID: <Pine.LNX.4.10.10101062036250.532-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2001, Christian T. Steigies wrote:

[ Compiling on m68k ]

> How about this one, 2.4.0 (release) with your new patch. make works fine,
> make modules fails with this:
> In file included from emd.c:20:
> /build/kernel-image/2.4.0/linux/include/asm/delay.h: In function `__const_udelay':
> /build/kernel-image/2.4.0/linux/include/asm/delay.h:33: `loops_per_jiffy' undeclared (first use in this function)
> /build/kernel-image/2.4.0/linux/include/asm/delay.h:33: (Each undeclared identifier is reported only once
> /build/kernel-image/2.4.0/linux/include/asm/delay.h:33: for each function it appears in.)
> make[2]: *** [emd.o] Error 1
> make[2]: Leaving directory `/build/kernel-image/2.4.0/linux/fs/umsdos'
> make[1]: *** [_modsubdir_umsdos] Error 2
> make[1]: Leaving directory `/build/kernel-image/2.4.0/linux/fs'
> make: *** [_mod_fs] Error 2

Drivers should include <linux/delay.h>, not <asm/delay.h>.

Please try the patch below. I only tried to compile fs/umsdos/emd.c for m68k.
I didn't dare to touch the following arch-specific files:

    arch/i386/lib/delay.c
    arch/i386/kernel/i8259.c
    arch/i386/kernel/irq.c
    arch/i386/kernel/time.c
    arch/i386/kernel/i386_ksyms.c
    arch/i386/kernel/visws_apic.c
    arch/sparc/kernel/process.c
    arch/sparc/kernel/traps.c
    arch/sparc/kernel/smp.c
    arch/sparc/kernel/sun4d_smp.c
    arch/sparc/kernel/sparc_ksyms.c
    arch/sparc/kernel/sun4m_smp.c
    arch/mips/jazz/reset.c
    arch/sparc64/kernel/sparc64_ksyms.c
    arch/sparc64/kernel/traps.c
    arch/arm/mach-sa1100/hw.c
    arch/sh/kernel/irq.c
    arch/sh/kernel/sh_ksyms.c
    arch/sh/kernel/time.c
    arch/ia64/hp/hpsim_console.c
    arch/ia64/hp/hpsim_setup.c
    arch/ia64/kernel/irq.c
    arch/ia64/kernel/irq_ia64.c
    arch/ia64/kernel/process.c
    arch/ia64/kernel/smp.c
    arch/ia64/kernel/time.c
    arch/ia64/kernel/unwind.c
    arch/ia64/kernel/smpboot.c
    arch/ia64/kernel/iosapic.c
    arch/ia64/mm/tlb.c
    arch/s390/kernel/irq.c
    arch/s390/kernel/s390io.c
    arch/s390/kernel/time.c

diff -urN linux-2.4.0/drivers/acpi/os.c delay-2.4.0/drivers/acpi/os.c
--- linux-2.4.0/drivers/acpi/os.c	Sun Dec 31 16:19:37 2000
+++ delay-2.4.0/drivers/acpi/os.c	Sat Jan  6 20:41:26 2001
@@ -24,8 +24,8 @@
 #include <linux/mm.h>
 #include <linux/pci.h>
 #include <linux/acpi.h>
+#include <linux/delay.h>
 #include <asm/io.h>
-#include <asm/delay.h>
 #include "acpi.h"
 #include "driver.h"
 
diff -urN linux-2.4.0/drivers/ide/osb4.c delay-2.4.0/drivers/ide/osb4.c
--- linux-2.4.0/drivers/ide/osb4.c	Sat Jan  6 17:15:20 2001
+++ delay-2.4.0/drivers/ide/osb4.c	Sat Jan  6 20:41:20 2001
@@ -46,8 +46,8 @@
 #include <linux/hdreg.h>
 #include <linux/ide.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 
-#include <asm/delay.h>
 #include <asm/io.h>
 
 #include "ide_modes.h"
diff -urN linux-2.4.0/drivers/net/winbond-840.c delay-2.4.0/drivers/net/winbond-840.c
--- linux-2.4.0/drivers/net/winbond-840.c	Sun Dec 31 16:19:47 2000
+++ delay-2.4.0/drivers/net/winbond-840.c	Sat Jan  6 20:40:37 2001
@@ -127,10 +127,10 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <asm/processor.h>		/* Processor type for cache alignment. */
 #include <asm/bitops.h>
 #include <asm/io.h>
-#include <asm/delay.h>
 
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("Winbond W89c840 Ethernet driver");
diff -urN linux-2.4.0/drivers/sbus/audio/audio.c delay-2.4.0/drivers/sbus/audio/audio.c
--- linux-2.4.0/drivers/sbus/audio/audio.c	Tue Dec 26 15:41:05 2000
+++ delay-2.4.0/drivers/sbus/audio/audio.c	Sat Jan  6 20:41:03 2001
@@ -34,7 +34,7 @@
 #include <linux/soundcard.h>
 #include <linux/version.h>
 #include <linux/devfs_fs_kernel.h>
-#include <asm/delay.h>
+#include <linux/delay.h>
 #include <asm/pgtable.h>
 
 #include <asm/audioio.h>
diff -urN linux-2.4.0/drivers/sbus/audio/dbri.c delay-2.4.0/drivers/sbus/audio/dbri.c
--- linux-2.4.0/drivers/sbus/audio/dbri.c	Tue Dec 26 15:41:05 2000
+++ delay-2.4.0/drivers/sbus/audio/dbri.c	Sat Jan  6 20:41:09 2001
@@ -49,12 +49,12 @@
 #include <linux/interrupt.h>
 #include <linux/malloc.h>
 #include <linux/version.h>
+#include <linux/delay.h>
 #include <asm/openprom.h>
 #include <asm/oplib.h>
 #include <asm/system.h>
 #include <asm/irq.h>
 #include <asm/io.h>
-#include <asm/delay.h>
 #include <asm/sbus.h>
 #include <asm/pgtable.h>
 
diff -urN linux-2.4.0/drivers/sbus/char/vfc_dev.c delay-2.4.0/drivers/sbus/char/vfc_dev.c
--- linux-2.4.0/drivers/sbus/char/vfc_dev.c	Tue Dec 26 15:41:05 2000
+++ delay-2.4.0/drivers/sbus/char/vfc_dev.c	Sat Jan  6 20:40:56 2001
@@ -22,13 +22,13 @@
 #include <linux/sched.h>
 #include <linux/fs.h>
 #include <linux/smp_lock.h>
+#include <linux/delay.h>
 
 #include <asm/openprom.h>
 #include <asm/oplib.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/sbus.h>
-#include <asm/delay.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
diff -urN linux-2.4.0/drivers/sbus/dvma.c delay-2.4.0/drivers/sbus/dvma.c
--- linux-2.4.0/drivers/sbus/dvma.c	Tue Dec 26 15:06:11 2000
+++ delay-2.4.0/drivers/sbus/dvma.c	Sat Jan  6 20:40:50 2001
@@ -8,9 +8,9 @@
 #include <linux/kernel.h>
 #include <linux/malloc.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 
 #include <asm/oplib.h>
-#include <asm/delay.h>
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <asm/sbus.h>
diff -urN linux-2.4.0/drivers/sound/via82cxxx_audio.c delay-2.4.0/drivers/sound/via82cxxx_audio.c
--- linux-2.4.0/drivers/sound/via82cxxx_audio.c	Sun Dec 31 16:19:50 2000
+++ delay-2.4.0/drivers/sound/via82cxxx_audio.c	Sat Jan  6 20:40:42 2001
@@ -34,8 +34,8 @@
 #include <linux/smp_lock.h>
 #include <linux/ioport.h>
 #include <linux/wrapper.h>
+#include <linux/delay.h>
 #include <asm/io.h>
-#include <asm/delay.h>
 #include <asm/uaccess.h>
 #include <asm/hardirq.h>
 #include <asm/semaphore.h>
diff -urN linux-2.4.0/drivers/video/fbcon-sti.c delay-2.4.0/drivers/video/fbcon-sti.c
--- linux-2.4.0/drivers/video/fbcon-sti.c	Tue Dec 26 15:43:37 2000
+++ delay-2.4.0/drivers/video/fbcon-sti.c	Sat Jan  6 20:41:14 2001
@@ -16,7 +16,7 @@
 #include <linux/console.h>
 #include <linux/string.h>
 #include <linux/fb.h>
-#include <asm/delay.h>
+#include <linux/delay.h>
 #include <asm/types.h>
 
 #include <video/fbcon.h>
diff -urN linux-2.4.0/fs/umsdos/emd.c delay-2.4.0/fs/umsdos/emd.c
--- linux-2.4.0/fs/umsdos/emd.c	Tue Dec 26 15:42:23 2000
+++ delay-2.4.0/fs/umsdos/emd.c	Sat Jan  6 20:40:12 2001
@@ -16,8 +16,7 @@
 #include <linux/umsdos_fs.h>
 #include <linux/dcache.h>
 #include <linux/pagemap.h>
-
-#include <asm/delay.h>
+#include <linux/delay.h>
 
 static void copy_entry(struct umsdos_dirent *p, struct umsdos_dirent *q)
 {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
