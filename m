Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264096AbRGNRME>; Sat, 14 Jul 2001 13:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263748AbRGNRLs>; Sat, 14 Jul 2001 13:11:48 -0400
Received: from weta.f00f.org ([203.167.249.89]:33411 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S264244AbRGNRLc>;
	Sat, 14 Jul 2001 13:11:32 -0400
Date: Sun, 15 Jul 2001 05:11:34 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@caldera.de>,
        Gunther Mayer <Gunther.Mayer@t-online.de>, paul@paulbristow.net,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: (patch-2.4.6) Fix oops with Iomega Clik! (ide-floppy)
Message-ID: <20010715051134.A7056@weta.f00f.org>
In-Reply-To: <E15LSoA-0001Sj-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15LSoA-0001Sj-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2001 at 06:02:22PM +0100, Alan Cox wrote:

    > Anyhow, say we leave linux/malloc.h for external module authors, but
    > make the other changes?
    
    At most for 2.4 but a #warning  in it
    
    > I'll re-run the script I wrote duing 2.5.x when we do remove malloc.h
    > to catch anything left over.
    
    Yep

OK, how is this for -ac then?




  --cw

-- 

diff -Nur linux-2.4.7-pre6/arch/arm/kernel/irq-arch.c linux-2.4.7-pre6+mallocRIP/arch/arm/kernel/irq-arch.c
--- linux-2.4.7-pre6/arch/arm/kernel/irq-arch.c	Mon Apr 30 14:18:35 2001
+++ linux-2.4.7-pre6+mallocRIP/arch/arm/kernel/irq-arch.c	Sun Jul 15 05:06:10 2001
@@ -17,7 +17,7 @@
 #include <linux/sched.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/random.h>
 #include <linux/smp.h>
 #include <linux/init.h>
diff -Nur linux-2.4.7-pre6/arch/arm/mach-integrator/dma.c linux-2.4.7-pre6+mallocRIP/arch/arm/mach-integrator/dma.c
--- linux-2.4.7-pre6/arch/arm/mach-integrator/dma.c	Mon Apr  2 18:15:08 2001
+++ linux-2.4.7-pre6+mallocRIP/arch/arm/mach-integrator/dma.c	Sun Jul 15 05:06:10 2001
@@ -19,7 +19,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/sched.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/mman.h>
 #include <linux/init.h>
 
diff -Nur linux-2.4.7-pre6/arch/arm/mach-integrator/pci_v3.c linux-2.4.7-pre6+mallocRIP/arch/arm/mach-integrator/pci_v3.c
--- linux-2.4.7-pre6/arch/arm/mach-integrator/pci_v3.c	Mon Apr  2 18:15:08 2001
+++ linux-2.4.7-pre6+mallocRIP/arch/arm/mach-integrator/pci_v3.c	Sun Jul 15 05:06:10 2001
@@ -24,7 +24,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/ptrace.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
diff -Nur linux-2.4.7-pre6/arch/arm/mach-sa1100/dma-sa1100.c linux-2.4.7-pre6+mallocRIP/arch/arm/mach-sa1100/dma-sa1100.c
--- linux-2.4.7-pre6/arch/arm/mach-sa1100/dma-sa1100.c	Mon Apr 30 14:18:35 2001
+++ linux-2.4.7-pre6+mallocRIP/arch/arm/mach-sa1100/dma-sa1100.c	Sun Jul 15 05:06:10 2001
@@ -16,7 +16,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/errno.h>
 
 #include <asm/system.h>
diff -Nur linux-2.4.7-pre6/arch/cris/drivers/parport.c linux-2.4.7-pre6+mallocRIP/arch/cris/drivers/parport.c
--- linux-2.4.7-pre6/arch/cris/drivers/parport.c	Thu Jul 12 03:13:01 2001
+++ linux-2.4.7-pre6+mallocRIP/arch/cris/drivers/parport.c	Sun Jul 15 05:06:10 2001
@@ -23,7 +23,7 @@
 #include <linux/major.h>
 #include <linux/sched.h>
 
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/interrupt.h>
 
 #include <asm/setup.h>
diff -Nur linux-2.4.7-pre6/arch/mips/ite-boards/generic/irq.c linux-2.4.7-pre6+mallocRIP/arch/mips/ite-boards/generic/irq.c
--- linux-2.4.7-pre6/arch/mips/ite-boards/generic/irq.c	Mon Apr 30 14:18:38 2001
+++ linux-2.4.7-pre6+mallocRIP/arch/mips/ite-boards/generic/irq.c	Sun Jul 15 05:06:10 2001
@@ -44,7 +44,7 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/timex.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/random.h>
 #include <linux/serial_reg.h>
 
diff -Nur linux-2.4.7-pre6/arch/ppc/kernel/gemini_pci.c linux-2.4.7-pre6+mallocRIP/arch/ppc/kernel/gemini_pci.c
--- linux-2.4.7-pre6/arch/ppc/kernel/gemini_pci.c	Sun Jun 17 15:54:03 2001
+++ linux-2.4.7-pre6+mallocRIP/arch/ppc/kernel/gemini_pci.c	Sun Jul 15 05:06:10 2001
@@ -4,7 +4,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 
 #include <asm/machdep.h>
 #include <asm/gemini.h>
diff -Nur linux-2.4.7-pre6/arch/s390/kernel/debug.c linux-2.4.7-pre6+mallocRIP/arch/s390/kernel/debug.c
--- linux-2.4.7-pre6/arch/s390/kernel/debug.c	Mon Apr 30 14:18:39 2001
+++ linux-2.4.7-pre6+mallocRIP/arch/s390/kernel/debug.c	Sun Jul 15 05:06:10 2001
@@ -14,7 +14,7 @@
 #include <linux/stddef.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/ctype.h>
 #include <linux/version.h>
 #include <asm/uaccess.h>
diff -Nur linux-2.4.7-pre6/arch/s390/kernel/irq.c linux-2.4.7-pre6+mallocRIP/arch/s390/kernel/irq.c
--- linux-2.4.7-pre6/arch/s390/kernel/irq.c	Thu Jul 12 03:13:01 2001
+++ linux-2.4.7-pre6+mallocRIP/arch/s390/kernel/irq.c	Sun Jul 15 05:06:10 2001
@@ -21,7 +21,7 @@
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/timex.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/random.h>
 #include <linux/smp.h>
diff -Nur linux-2.4.7-pre6/arch/s390/kernel/s390_ext.c linux-2.4.7-pre6+mallocRIP/arch/s390/kernel/s390_ext.c
--- linux-2.4.7-pre6/arch/s390/kernel/s390_ext.c	Mon Apr 30 14:18:39 2001
+++ linux-2.4.7-pre6+mallocRIP/arch/s390/kernel/s390_ext.c	Sun Jul 15 05:06:10 2001
@@ -9,7 +9,7 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <asm/lowcore.h>
 #include <asm/s390_ext.h>
 
diff -Nur linux-2.4.7-pre6/arch/s390x/kernel/debug.c linux-2.4.7-pre6+mallocRIP/arch/s390x/kernel/debug.c
--- linux-2.4.7-pre6/arch/s390x/kernel/debug.c	Mon Apr 30 14:18:39 2001
+++ linux-2.4.7-pre6+mallocRIP/arch/s390x/kernel/debug.c	Sun Jul 15 05:06:10 2001
@@ -14,7 +14,7 @@
 #include <linux/stddef.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/ctype.h>
 #include <linux/version.h>
 #include <asm/uaccess.h>
diff -Nur linux-2.4.7-pre6/arch/s390x/kernel/irq.c linux-2.4.7-pre6+mallocRIP/arch/s390x/kernel/irq.c
--- linux-2.4.7-pre6/arch/s390x/kernel/irq.c	Thu Jul 12 03:13:01 2001
+++ linux-2.4.7-pre6+mallocRIP/arch/s390x/kernel/irq.c	Sun Jul 15 05:06:10 2001
@@ -21,7 +21,7 @@
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/timex.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/random.h>
 #include <linux/smp.h>
diff -Nur linux-2.4.7-pre6/arch/s390x/kernel/linux32.c linux-2.4.7-pre6+mallocRIP/arch/s390x/kernel/linux32.c
--- linux-2.4.7-pre6/arch/s390x/kernel/linux32.c	Thu Jul 12 03:13:01 2001
+++ linux-2.4.7-pre6+mallocRIP/arch/s390x/kernel/linux32.c	Sun Jul 15 05:06:10 2001
@@ -32,7 +32,7 @@
 #include <linux/sem.h>
 #include <linux/msg.h>
 #include <linux/shm.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/uio.h>
 #include <linux/nfs_fs.h>
 #include <linux/smb_fs.h>
diff -Nur linux-2.4.7-pre6/arch/s390x/kernel/s390_ext.c linux-2.4.7-pre6+mallocRIP/arch/s390x/kernel/s390_ext.c
--- linux-2.4.7-pre6/arch/s390x/kernel/s390_ext.c	Mon Apr 30 14:18:39 2001
+++ linux-2.4.7-pre6+mallocRIP/arch/s390x/kernel/s390_ext.c	Sun Jul 15 05:06:10 2001
@@ -9,7 +9,7 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <asm/lowcore.h>
 #include <asm/s390_ext.h>
 
diff -Nur linux-2.4.7-pre6/drivers/acorn/char/mouse_ps2.c linux-2.4.7-pre6+mallocRIP/drivers/acorn/char/mouse_ps2.c
--- linux-2.4.7-pre6/drivers/acorn/char/mouse_ps2.c	Wed Jul  4 22:58:47 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/acorn/char/mouse_ps2.c	Sun Jul 15 05:06:15 2001
@@ -8,7 +8,7 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/mm.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/ptrace.h>
 #include <linux/signal.h>
 #include <linux/timer.h>
diff -Nur linux-2.4.7-pre6/drivers/block/paride/bpck6.c linux-2.4.7-pre6+mallocRIP/drivers/block/paride/bpck6.c
--- linux-2.4.7-pre6/drivers/block/paride/bpck6.c	Mon Apr 30 14:18:41 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/block/paride/bpck6.c	Sun Jul 15 05:06:15 2001
@@ -28,7 +28,7 @@
 #define EXPORT_SYMTAB 
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/types.h>
 #include <asm/io.h>
 
diff -Nur linux-2.4.7-pre6/drivers/bluetooth/hci_uart.c linux-2.4.7-pre6+mallocRIP/drivers/bluetooth/hci_uart.c
--- linux-2.4.7-pre6/drivers/bluetooth/hci_uart.c	Wed Jul  4 22:58:47 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/bluetooth/hci_uart.c	Sun Jul 15 05:06:15 2001
@@ -42,7 +42,7 @@
 #include <linux/ptrace.h>
 #include <linux/poll.h>
 
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/tty.h>
 #include <linux/errno.h>
 #include <linux/string.h>
diff -Nur linux-2.4.7-pre6/drivers/bluetooth/hci_usb.c linux-2.4.7-pre6+mallocRIP/drivers/bluetooth/hci_usb.c
--- linux-2.4.7-pre6/drivers/bluetooth/hci_usb.c	Wed Jul  4 22:58:47 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/bluetooth/hci_usb.c	Sun Jul 15 05:06:15 2001
@@ -45,7 +45,7 @@
 #include <linux/ptrace.h>
 #include <linux/poll.h>
 
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/tty.h>
 #include <linux/errno.h>
 #include <linux/string.h>
diff -Nur linux-2.4.7-pre6/drivers/char/ec3104_keyb.c linux-2.4.7-pre6+mallocRIP/drivers/char/ec3104_keyb.c
--- linux-2.4.7-pre6/drivers/char/ec3104_keyb.c	Mon Apr 30 14:18:41 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/char/ec3104_keyb.c	Sun Jul 15 05:06:14 2001
@@ -40,7 +40,7 @@
 #include <linux/random.h>
 #include <linux/poll.h>
 #include <linux/miscdevice.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/kbd_kern.h>
 #include <linux/smp_lock.h>
 
diff -Nur linux-2.4.7-pre6/drivers/char/machzwd.c linux-2.4.7-pre6+mallocRIP/drivers/char/machzwd.c
--- linux-2.4.7-pre6/drivers/char/machzwd.c	Thu Jul 12 03:13:01 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/char/machzwd.c	Sun Jul 15 05:06:14 2001
@@ -36,7 +36,7 @@
 #include <linux/sched.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/ioport.h>
 #include <linux/fcntl.h>
 #include <linux/smp_lock.h>
diff -Nur linux-2.4.7-pre6/drivers/char/qtronix.c linux-2.4.7-pre6+mallocRIP/drivers/char/qtronix.c
--- linux-2.4.7-pre6/drivers/char/qtronix.c	Mon Apr 30 14:18:41 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/char/qtronix.c	Sun Jul 15 05:06:14 2001
@@ -71,7 +71,7 @@
 #include <linux/random.h>
 #include <linux/poll.h>
 #include <linux/miscdevice.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/kbd_kern.h>
 #include <linux/smp_lock.h>
 #include <asm/io.h>
diff -Nur linux-2.4.7-pre6/drivers/isdn/hisax/sedlbauer_cs.c linux-2.4.7-pre6+mallocRIP/drivers/isdn/hisax/sedlbauer_cs.c
--- linux-2.4.7-pre6/drivers/isdn/hisax/sedlbauer_cs.c	Mon Apr  2 18:15:25 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/isdn/hisax/sedlbauer_cs.c	Sun Jul 15 05:06:14 2001
@@ -42,7 +42,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/ptrace.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/ioport.h>
diff -Nur linux-2.4.7-pre6/drivers/media/video/adv7175.c linux-2.4.7-pre6+mallocRIP/drivers/media/video/adv7175.c
--- linux-2.4.7-pre6/drivers/media/video/adv7175.c	Sun Jun 17 15:54:55 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/media/video/adv7175.c	Sun Jul 15 05:06:15 2001
@@ -30,7 +30,7 @@
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/major.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/pci.h>
 #include <linux/signal.h>
diff -Nur linux-2.4.7-pre6/drivers/media/video/bt819.c linux-2.4.7-pre6+mallocRIP/drivers/media/video/bt819.c
--- linux-2.4.7-pre6/drivers/media/video/bt819.c	Sun Jun 17 15:54:55 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/media/video/bt819.c	Sun Jul 15 05:06:15 2001
@@ -31,7 +31,7 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/pci.h>
 #include <linux/signal.h>
diff -Nur linux-2.4.7-pre6/drivers/media/video/bt856.c linux-2.4.7-pre6+mallocRIP/drivers/media/video/bt856.c
--- linux-2.4.7-pre6/drivers/media/video/bt856.c	Sun Jun 17 15:54:55 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/media/video/bt856.c	Sun Jul 15 05:06:15 2001
@@ -32,7 +32,7 @@
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/major.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/pci.h>
 #include <linux/signal.h>
diff -Nur linux-2.4.7-pre6/drivers/media/video/saa7111.c linux-2.4.7-pre6+mallocRIP/drivers/media/video/saa7111.c
--- linux-2.4.7-pre6/drivers/media/video/saa7111.c	Sun Jun 17 15:54:57 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/media/video/saa7111.c	Sun Jul 15 05:06:15 2001
@@ -28,7 +28,7 @@
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/major.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 
diff -Nur linux-2.4.7-pre6/drivers/media/video/saa7185.c linux-2.4.7-pre6+mallocRIP/drivers/media/video/saa7185.c
--- linux-2.4.7-pre6/drivers/media/video/saa7185.c	Sun Jun 17 15:54:57 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/media/video/saa7185.c	Sun Jul 15 05:06:15 2001
@@ -28,7 +28,7 @@
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/major.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/pci.h>
 #include <linux/signal.h>
diff -Nur linux-2.4.7-pre6/drivers/media/video/zr36067.c linux-2.4.7-pre6+mallocRIP/drivers/media/video/zr36067.c
--- linux-2.4.7-pre6/drivers/media/video/zr36067.c	Thu Jul 12 03:13:02 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/media/video/zr36067.c	Sun Jul 15 05:06:15 2001
@@ -50,7 +50,7 @@
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/major.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/pci.h>
 #include <linux/signal.h>
diff -Nur linux-2.4.7-pre6/drivers/net/au1000_eth.c linux-2.4.7-pre6+mallocRIP/drivers/net/au1000_eth.c
--- linux-2.4.7-pre6/drivers/net/au1000_eth.c	Thu Jul 12 03:13:07 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/net/au1000_eth.c	Sun Jul 15 05:06:14 2001
@@ -39,7 +39,7 @@
 #include <linux/errno.h>
 #include <linux/in.h>
 #include <linux/ioport.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/init.h>
diff -Nur linux-2.4.7-pre6/drivers/net/dmfe.c linux-2.4.7-pre6+mallocRIP/drivers/net/dmfe.c
--- linux-2.4.7-pre6/drivers/net/dmfe.c	Thu Jul 12 03:13:07 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/net/dmfe.c	Sun Jul 15 05:06:14 2001
@@ -61,7 +61,7 @@
 #include <linux/ptrace.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/init.h>
diff -Nur linux-2.4.7-pre6/drivers/net/gt96100eth.c linux-2.4.7-pre6+mallocRIP/drivers/net/gt96100eth.c
--- linux-2.4.7-pre6/drivers/net/gt96100eth.c	Mon Apr 30 14:18:43 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/net/gt96100eth.c	Sun Jul 15 05:06:14 2001
@@ -38,7 +38,7 @@
 #include <linux/errno.h>
 #include <linux/in.h>
 #include <linux/ioport.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/init.h>
diff -Nur linux-2.4.7-pre6/drivers/net/irda/ali-ircc.c linux-2.4.7-pre6+mallocRIP/drivers/net/irda/ali-ircc.c
--- linux-2.4.7-pre6/drivers/net/irda/ali-ircc.c	Thu Jul 12 03:13:07 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/net/irda/ali-ircc.c	Sun Jul 15 05:06:14 2001
@@ -27,7 +27,7 @@
 #include <linux/netdevice.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/rtnetlink.h>
 #include <linux/serial_reg.h>
diff -Nur linux-2.4.7-pre6/drivers/net/irda/irda-usb.c linux-2.4.7-pre6+mallocRIP/drivers/net/irda/irda-usb.c
--- linux-2.4.7-pre6/drivers/net/irda/irda-usb.c	Sun Jun 17 15:55:04 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/net/irda/irda-usb.c	Sun Jul 15 05:06:14 2001
@@ -33,7 +33,7 @@
 #include <linux/init.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/rtnetlink.h>
 #include <linux/usb.h>
 
diff -Nur linux-2.4.7-pre6/drivers/net/lp486e.c linux-2.4.7-pre6+mallocRIP/drivers/net/lp486e.c
--- linux-2.4.7-pre6/drivers/net/lp486e.c	Thu Jul 12 03:13:07 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/net/lp486e.c	Sun Jul 15 05:06:14 2001
@@ -65,7 +65,7 @@
 #include <linux/ptrace.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
diff -Nur linux-2.4.7-pre6/drivers/net/ncr885e.c linux-2.4.7-pre6+mallocRIP/drivers/net/ncr885e.c
--- linux-2.4.7-pre6/drivers/net/ncr885e.c	Wed Jul  4 22:58:50 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/net/ncr885e.c	Sun Jul 15 05:06:14 2001
@@ -19,7 +19,7 @@
 #include <linux/sched.h>
 #include <linux/timer.h>
 #include <linux/ptrace.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
diff -Nur linux-2.4.7-pre6/drivers/net/pcmcia/ibmtr_cs.c linux-2.4.7-pre6+mallocRIP/drivers/net/pcmcia/ibmtr_cs.c
--- linux-2.4.7-pre6/drivers/net/pcmcia/ibmtr_cs.c	Thu Jul 12 03:13:07 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/net/pcmcia/ibmtr_cs.c	Sun Jul 15 05:06:14 2001
@@ -49,7 +49,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/ptrace.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/module.h>
diff -Nur linux-2.4.7-pre6/drivers/net/sk98lin/h/skdrv1st.h linux-2.4.7-pre6+mallocRIP/drivers/net/sk98lin/h/skdrv1st.h
--- linux-2.4.7-pre6/drivers/net/sk98lin/h/skdrv1st.h	Thu Jul 12 03:13:07 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/net/sk98lin/h/skdrv1st.h	Sun Jul 15 05:06:14 2001
@@ -113,7 +113,7 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <asm/byteorder.h>
diff -Nur linux-2.4.7-pre6/drivers/net/sungem.c linux-2.4.7-pre6+mallocRIP/drivers/net/sungem.c
--- linux-2.4.7-pre6/drivers/net/sungem.c	Wed Jul  4 22:58:50 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/net/sungem.c	Sun Jul 15 05:06:14 2001
@@ -14,7 +14,7 @@
 #include <linux/ptrace.h>
 #include <linux/ioport.h>
 #include <linux/in.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/init.h>
diff -Nur linux-2.4.7-pre6/drivers/net/tun.c linux-2.4.7-pre6+mallocRIP/drivers/net/tun.c
--- linux-2.4.7-pre6/drivers/net/tun.c	Wed Jul  4 22:58:50 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/net/tun.c	Sun Jul 15 05:06:14 2001
@@ -29,7 +29,7 @@
 #include <linux/kernel.h>
 #include <linux/major.h>
 #include <linux/sched.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/poll.h>
 #include <linux/fcntl.h>
 #include <linux/init.h>
diff -Nur linux-2.4.7-pre6/drivers/net/wan/sdla_chdlc.c linux-2.4.7-pre6+mallocRIP/drivers/net/wan/sdla_chdlc.c
--- linux-2.4.7-pre6/drivers/net/wan/sdla_chdlc.c	Mon Apr 30 14:18:45 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/net/wan/sdla_chdlc.c	Sun Jul 15 05:06:14 2001
@@ -53,7 +53,7 @@
 #include <linux/stddef.h>	/* offsetof(), etc. */
 #include <linux/errno.h>	/* return codes */
 #include <linux/string.h>	/* inline memset(), etc. */
-#include <linux/malloc.h>	/* kmalloc(), kfree() */
+#include <linux/slab.h>	/* kmalloc(), kfree() */
 #include <linux/wanrouter.h>	/* WAN router definitions */
 #include <linux/wanpipe.h>	/* WANPIPE common user API definitions */
 #include <linux/if_arp.h>	/* ARPHRD_* defines */
diff -Nur linux-2.4.7-pre6/drivers/net/wan/sdla_fr.c linux-2.4.7-pre6+mallocRIP/drivers/net/wan/sdla_fr.c
--- linux-2.4.7-pre6/drivers/net/wan/sdla_fr.c	Wed Jul  4 22:58:50 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/net/wan/sdla_fr.c	Sun Jul 15 05:06:14 2001
@@ -143,7 +143,7 @@
 #include <linux/stddef.h>	/* offsetof(), etc. */
 #include <linux/errno.h>	/* return codes */
 #include <linux/string.h>	/* inline memset(), etc. */
-#include <linux/malloc.h>	/* kmalloc(), kfree() */
+#include <linux/slab.h>	/* kmalloc(), kfree() */
 #include <linux/wanrouter.h>	/* WAN router definitions */
 #include <linux/wanpipe.h>	/* WANPIPE common user API definitions */
 #include <linux/if_arp.h>	/* ARPHRD_* defines */
diff -Nur linux-2.4.7-pre6/drivers/net/wan/sdla_ft1.c linux-2.4.7-pre6+mallocRIP/drivers/net/wan/sdla_ft1.c
--- linux-2.4.7-pre6/drivers/net/wan/sdla_ft1.c	Mon Apr 30 14:18:45 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/net/wan/sdla_ft1.c	Sun Jul 15 05:06:14 2001
@@ -25,7 +25,7 @@
 #include <linux/stddef.h>	/* offsetof(), etc. */
 #include <linux/errno.h>	/* return codes */
 #include <linux/string.h>	/* inline memset(), etc. */
-#include <linux/malloc.h>	/* kmalloc(), kfree() */
+#include <linux/slab.h>	/* kmalloc(), kfree() */
 #include <linux/wanrouter.h>	/* WAN router definitions */
 #include <linux/wanpipe.h>	/* WANPIPE common user API definitions */
 #include <linux/if_arp.h>	/* ARPHRD_* defines */
diff -Nur linux-2.4.7-pre6/drivers/net/wan/sdla_ppp.c linux-2.4.7-pre6+mallocRIP/drivers/net/wan/sdla_ppp.c
--- linux-2.4.7-pre6/drivers/net/wan/sdla_ppp.c	Sun Jun 17 15:55:11 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/net/wan/sdla_ppp.c	Sun Jul 15 05:06:14 2001
@@ -95,7 +95,7 @@
 #include <linux/stddef.h>	/* offsetof(), etc. */
 #include <linux/errno.h>	/* return codes */
 #include <linux/string.h>	/* inline memset(), etc. */
-#include <linux/malloc.h>	/* kmalloc(), kfree() */
+#include <linux/slab.h>	/* kmalloc(), kfree() */
 #include <linux/wanrouter.h>	/* WAN router definitions */
 #include <linux/wanpipe.h>	/* WANPIPE common user API definitions */
 #include <linux/if_arp.h>	/* ARPHRD_* defines */
diff -Nur linux-2.4.7-pre6/drivers/net/wan/sdla_x25.c linux-2.4.7-pre6+mallocRIP/drivers/net/wan/sdla_x25.c
--- linux-2.4.7-pre6/drivers/net/wan/sdla_x25.c	Wed Jul  4 22:58:50 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/net/wan/sdla_x25.c	Sun Jul 15 05:06:14 2001
@@ -87,7 +87,7 @@
 #include <linux/errno.h>	/* return codes */
 #include <linux/string.h>	/* inline memset(), etc. */
 #include <linux/ctype.h>
-#include <linux/malloc.h>	/* kmalloc(), kfree() */
+#include <linux/slab.h>	/* kmalloc(), kfree() */
 #include <linux/wanrouter.h>	/* WAN router definitions */
 #include <linux/wanpipe.h>	/* WANPIPE common user API definitions */
 #include <asm/byteorder.h>	/* htons(), etc. */
diff -Nur linux-2.4.7-pre6/drivers/net/wan/sdlamain.c linux-2.4.7-pre6+mallocRIP/drivers/net/wan/sdlamain.c
--- linux-2.4.7-pre6/drivers/net/wan/sdlamain.c	Mon Apr 30 14:18:45 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/net/wan/sdlamain.c	Sun Jul 15 05:06:14 2001
@@ -51,7 +51,7 @@
 #include <linux/stddef.h>	/* offsetof(), etc. */
 #include <linux/errno.h>	/* return codes */
 #include <linux/string.h>	/* inline memset(), etc. */
-#include <linux/malloc.h>	/* kmalloc(), kfree() */
+#include <linux/slab.h>	/* kmalloc(), kfree() */
 #include <linux/kernel.h>	/* printk(), and other useful stuff */
 #include <linux/module.h>	/* support for loadable modules */
 #include <linux/ioport.h>	/* request_region(), release_region() */
diff -Nur linux-2.4.7-pre6/drivers/net/wan/wanpipe_multppp.c linux-2.4.7-pre6+mallocRIP/drivers/net/wan/wanpipe_multppp.c
--- linux-2.4.7-pre6/drivers/net/wan/wanpipe_multppp.c	Sun Jun 17 15:55:12 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/net/wan/wanpipe_multppp.c	Sun Jul 15 05:06:14 2001
@@ -22,7 +22,7 @@
 #include <linux/stddef.h>	/* offsetof(), etc. */
 #include <linux/errno.h>	/* return codes */
 #include <linux/string.h>	/* inline memset(), etc. */
-#include <linux/malloc.h>	/* kmalloc(), kfree() */
+#include <linux/slab.h>	/* kmalloc(), kfree() */
 #include <linux/wanrouter.h>	/* WAN router definitions */
 #include <linux/wanpipe.h>	/* WANPIPE common user API definitions */
 #include <linux/if_arp.h>	/* ARPHRD_* defines */
diff -Nur linux-2.4.7-pre6/drivers/net/wireless/airo.c linux-2.4.7-pre6+mallocRIP/drivers/net/wireless/airo.c
--- linux-2.4.7-pre6/drivers/net/wireless/airo.c	Wed Jul  4 22:58:50 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/net/wireless/airo.c	Sun Jul 15 05:06:14 2001
@@ -28,7 +28,7 @@
 
 #include <linux/sched.h>
 #include <linux/ptrace.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/interrupt.h>
diff -Nur linux-2.4.7-pre6/drivers/net/wireless/airo_cs.c linux-2.4.7-pre6+mallocRIP/drivers/net/wireless/airo_cs.c
--- linux-2.4.7-pre6/drivers/net/wireless/airo_cs.c	Wed Jul  4 22:58:50 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/net/wireless/airo_cs.c	Sun Jul 15 05:06:14 2001
@@ -31,7 +31,7 @@
 
 #include <linux/sched.h>
 #include <linux/ptrace.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/netdevice.h>
diff -Nur linux-2.4.7-pre6/drivers/net/wireless/airport.c linux-2.4.7-pre6+mallocRIP/drivers/net/wireless/airport.c
--- linux-2.4.7-pre6/drivers/net/wireless/airport.c	Sun Jun 17 15:55:12 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/net/wireless/airport.c	Sun Jul 15 05:06:14 2001
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/ptrace.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/ioport.h>
diff -Nur linux-2.4.7-pre6/drivers/net/wireless/orinoco.c linux-2.4.7-pre6+mallocRIP/drivers/net/wireless/orinoco.c
--- linux-2.4.7-pre6/drivers/net/wireless/orinoco.c	Wed Jul  4 22:58:50 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/net/wireless/orinoco.c	Sun Jul 15 05:06:14 2001
@@ -177,7 +177,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/ptrace.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/ioport.h>
diff -Nur linux-2.4.7-pre6/drivers/net/wireless/orinoco_cs.c linux-2.4.7-pre6+mallocRIP/drivers/net/wireless/orinoco_cs.c
--- linux-2.4.7-pre6/drivers/net/wireless/orinoco_cs.c	Wed Jul  4 22:58:50 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/net/wireless/orinoco_cs.c	Sun Jul 15 05:06:14 2001
@@ -15,7 +15,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/ptrace.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/ioport.h>
diff -Nur linux-2.4.7-pre6/drivers/s390/block/dasd.c linux-2.4.7-pre6+mallocRIP/drivers/s390/block/dasd.c
--- linux-2.4.7-pre6/drivers/s390/block/dasd.c	Sun Jun 17 15:55:17 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/s390/block/dasd.c	Sun Jul 15 05:06:15 2001
@@ -31,7 +31,7 @@
 #include <linux/kernel.h>
 #include <linux/tqueue.h>
 #include <linux/timer.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/genhd.h>
 #include <linux/hdreg.h>
 #include <linux/interrupt.h>
diff -Nur linux-2.4.7-pre6/drivers/s390/block/dasd_diag.c linux-2.4.7-pre6+mallocRIP/drivers/s390/block/dasd_diag.c
--- linux-2.4.7-pre6/drivers/s390/block/dasd_diag.c	Mon Apr 30 14:18:46 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/s390/block/dasd_diag.c	Sun Jul 15 05:06:14 2001
@@ -18,7 +18,7 @@
 #include <linux/kernel.h>
 #include <asm/debug.h>
 
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/hdreg.h>	/* HDIO_GETGEO                      */
 #include <linux/blk.h>
 #include <asm/ccwcache.h>
diff -Nur linux-2.4.7-pre6/drivers/s390/block/dasd_eckd.c linux-2.4.7-pre6+mallocRIP/drivers/s390/block/dasd_eckd.c
--- linux-2.4.7-pre6/drivers/s390/block/dasd_eckd.c	Mon Apr 30 14:18:46 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/s390/block/dasd_eckd.c	Sun Jul 15 05:06:15 2001
@@ -24,7 +24,7 @@
 #include <linux/kernel.h>
 #include <asm/debug.h>
 
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/hdreg.h>	/* HDIO_GETGEO                      */
 #include <linux/blk.h>
 #include <asm/ccwcache.h>
diff -Nur linux-2.4.7-pre6/drivers/s390/block/dasd_fba.c linux-2.4.7-pre6+mallocRIP/drivers/s390/block/dasd_fba.c
--- linux-2.4.7-pre6/drivers/s390/block/dasd_fba.c	Mon Apr 30 14:18:46 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/s390/block/dasd_fba.c	Sun Jul 15 05:06:15 2001
@@ -12,7 +12,7 @@
 #include <linux/kernel.h>
 #include <asm/debug.h>
 
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/hdreg.h>	/* HDIO_GETGEO                      */
 #include <linux/blk.h>
 #include <asm/ccwcache.h>
diff -Nur linux-2.4.7-pre6/drivers/s390/block/xpram.c linux-2.4.7-pre6+mallocRIP/drivers/s390/block/xpram.c
--- linux-2.4.7-pre6/drivers/s390/block/xpram.c	Mon Apr 30 14:18:46 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/s390/block/xpram.c	Sun Jul 15 05:06:14 2001
@@ -74,7 +74,7 @@
 #endif /* V24 */
 #include <linux/sched.h>
 #include <linux/kernel.h> /* printk() */
-#include <linux/malloc.h> /* kmalloc() */
+#include <linux/slab.h> /* kmalloc() */
 #if (XPRAM_VERSION == 24)
 #  include <linux/devfs_fs_kernel.h>
 #endif /* V24 */
diff -Nur linux-2.4.7-pre6/drivers/s390/ccwcache.c linux-2.4.7-pre6+mallocRIP/drivers/s390/ccwcache.c
--- linux-2.4.7-pre6/drivers/s390/ccwcache.c	Mon Apr 30 14:18:46 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/s390/ccwcache.c	Sun Jul 15 05:06:15 2001
@@ -10,7 +10,7 @@
  */
 
 #include <linux/module.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/version.h>
 
 #if (LINUX_VERSION_CODE > KERNEL_VERSION(2,3,98))
diff -Nur linux-2.4.7-pre6/drivers/s390/char/tubio.h linux-2.4.7-pre6+mallocRIP/drivers/s390/char/tubio.h
--- linux-2.4.7-pre6/drivers/s390/char/tubio.h	Mon Apr 30 14:18:46 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/s390/char/tubio.h	Sun Jul 15 05:06:14 2001
@@ -23,7 +23,7 @@
 #endif /* IBM_FS3270_MAJOR */
 
 
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <linux/console.h>
diff -Nur linux-2.4.7-pre6/drivers/s390/idals.c linux-2.4.7-pre6+mallocRIP/drivers/s390/idals.c
--- linux-2.4.7-pre6/drivers/s390/idals.c	Mon Apr 30 14:18:46 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/s390/idals.c	Sun Jul 15 05:06:15 2001
@@ -11,7 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/config.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 
 #include <asm/irq.h>
 #include <asm/idals.h>
diff -Nur linux-2.4.7-pre6/drivers/s390/net/ctcmain.c linux-2.4.7-pre6+mallocRIP/drivers/s390/net/ctcmain.c
--- linux-2.4.7-pre6/drivers/s390/net/ctcmain.c	Mon Apr 30 14:18:46 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/s390/net/ctcmain.c	Sun Jul 15 05:06:14 2001
@@ -98,7 +98,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
diff -Nur linux-2.4.7-pre6/drivers/s390/net/fsm.h linux-2.4.7-pre6+mallocRIP/drivers/s390/net/fsm.h
--- linux-2.4.7-pre6/drivers/s390/net/fsm.h	Sun Feb 25 01:10:38 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/s390/net/fsm.h	Sun Jul 15 05:06:14 2001
@@ -16,7 +16,7 @@
 #include <linux/types.h>
 #include <linux/timer.h>
 #include <linux/time.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/string.h>
 #include <asm/atomic.h>
diff -Nur linux-2.4.7-pre6/drivers/s390/net/iucv.c linux-2.4.7-pre6+mallocRIP/drivers/s390/net/iucv.c
--- linux-2.4.7-pre6/drivers/s390/net/iucv.c	Mon Apr 30 14:18:46 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/s390/net/iucv.c	Sun Jul 15 05:06:14 2001
@@ -13,7 +13,7 @@
 #include <linux/version.h>
 #include <linux/spinlock.h>
 #include <linux/kernel.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/tqueue.h>
 #include <linux/interrupt.h>
diff -Nur linux-2.4.7-pre6/drivers/s390/net/netiucv.c linux-2.4.7-pre6+mallocRIP/drivers/s390/net/netiucv.c
--- linux-2.4.7-pre6/drivers/s390/net/netiucv.c	Mon Apr 30 14:18:46 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/s390/net/netiucv.c	Sun Jul 15 05:06:14 2001
@@ -71,7 +71,7 @@
 #endif
 
 #include <linux/sched.h>	/* task queues                  */
-#include <linux/malloc.h>	/* kmalloc()                    */
+#include <linux/slab.h>	/* kmalloc()                    */
 #include <linux/errno.h>	/* error codes                  */
 #include <linux/types.h>	/* size_t                       */
 #include <linux/interrupt.h>	/* mark_bh                      */
diff -Nur linux-2.4.7-pre6/drivers/s390/s390io.c linux-2.4.7-pre6+mallocRIP/drivers/s390/s390io.c
--- linux-2.4.7-pre6/drivers/s390/s390io.c	Thu Jul 12 03:13:08 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/s390/s390io.c	Sun Jul 15 05:06:15 2001
@@ -24,7 +24,7 @@
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/smp.h>
 #include <linux/threads.h>
diff -Nur linux-2.4.7-pre6/drivers/s390/s390mach.c linux-2.4.7-pre6+mallocRIP/drivers/s390/s390mach.c
--- linux-2.4.7-pre6/drivers/s390/s390mach.c	Mon Apr  2 18:15:29 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/s390/s390mach.c	Sun Jul 15 05:06:15 2001
@@ -11,7 +11,7 @@
 #include <linux/config.h>
 #include <linux/spinlock.h>
 #include <linux/init.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #ifdef CONFIG_SMP
 #include <linux/smp.h>
 #endif
diff -Nur linux-2.4.7-pre6/drivers/scsi/advansys.c linux-2.4.7-pre6+mallocRIP/drivers/scsi/advansys.c
--- linux-2.4.7-pre6/drivers/scsi/advansys.c	Mon Apr 30 14:18:46 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/scsi/advansys.c	Sun Jul 15 05:06:15 2001
@@ -789,7 +789,7 @@
 #include <linux/types.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/proc_fs.h>
 #include <linux/init.h>
diff -Nur linux-2.4.7-pre6/drivers/scsi/aic7xxx/aic7xxx_osm.h linux-2.4.7-pre6+mallocRIP/drivers/scsi/aic7xxx/aic7xxx_osm.h
--- linux-2.4.7-pre6/drivers/scsi/aic7xxx/aic7xxx_osm.h	Thu Jul 12 03:53:53 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/scsi/aic7xxx/aic7xxx_osm.h	Sun Jul 15 05:06:15 2001
@@ -58,7 +58,7 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/version.h>
 
diff -Nur linux-2.4.7-pre6/drivers/scsi/megaraid.c linux-2.4.7-pre6+mallocRIP/drivers/scsi/megaraid.c
--- linux-2.4.7-pre6/drivers/scsi/megaraid.c	Thu Jul 12 03:13:08 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/scsi/megaraid.c	Sun Jul 15 05:06:15 2001
@@ -391,7 +391,7 @@
 
 #include <linux/sched.h>
 #include <linux/stat.h>
-#include <linux/malloc.h>	/* for kmalloc() */
+#include <linux/slab.h>	/* for kmalloc() */
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,0)	/* 0x20100 */
 #include <linux/bios32.h>
 #else
diff -Nur linux-2.4.7-pre6/drivers/sound/cmpci.c linux-2.4.7-pre6+mallocRIP/drivers/sound/cmpci.c
--- linux-2.4.7-pre6/drivers/sound/cmpci.c	Wed Jul  4 22:58:51 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/sound/cmpci.c	Sun Jul 15 05:06:15 2001
@@ -93,7 +93,7 @@
 #include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/sound.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/soundcard.h>
 #include <linux/pci.h>
 #include <linux/wrapper.h>
diff -Nur linux-2.4.7-pre6/drivers/sound/cs4281/cs4281m.c linux-2.4.7-pre6+mallocRIP/drivers/sound/cs4281/cs4281m.c
--- linux-2.4.7-pre6/drivers/sound/cs4281/cs4281m.c	Wed Jul  4 22:58:51 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/sound/cs4281/cs4281m.c	Sun Jul 15 05:06:15 2001
@@ -65,7 +65,7 @@
 #include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/sound.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/soundcard.h>
 #include <linux/pci.h>
 #include <linux/bitops.h>
diff -Nur linux-2.4.7-pre6/drivers/sound/maestro3.c linux-2.4.7-pre6+mallocRIP/drivers/sound/maestro3.c
--- linux-2.4.7-pre6/drivers/sound/maestro3.c	Wed Jul  4 22:58:51 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/sound/maestro3.c	Sun Jul 15 05:06:15 2001
@@ -130,7 +130,7 @@
 #include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/sound.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/soundcard.h>
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
diff -Nur linux-2.4.7-pre6/drivers/usb/catc.c linux-2.4.7-pre6+mallocRIP/drivers/usb/catc.c
--- linux-2.4.7-pre6/drivers/usb/catc.c	Wed Jul  4 22:58:51 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/usb/catc.c	Sun Jul 15 05:06:14 2001
@@ -33,7 +33,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
diff -Nur linux-2.4.7-pre6/drivers/usb/serial/io_edgeport.c linux-2.4.7-pre6+mallocRIP/drivers/usb/serial/io_edgeport.c
--- linux-2.4.7-pre6/drivers/usb/serial/io_edgeport.c	Wed Jul  4 22:58:51 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/usb/serial/io_edgeport.c	Sun Jul 15 05:06:14 2001
@@ -233,7 +233,7 @@
 #include <linux/errno.h>
 #include <linux/poll.h>
 #include <linux/init.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/fcntl.h>
 #include <linux/tty.h>
 #include <linux/tty_driver.h>
diff -Nur linux-2.4.7-pre6/drivers/video/epson1355fb.c linux-2.4.7-pre6+mallocRIP/drivers/video/epson1355fb.c
--- linux-2.4.7-pre6/drivers/video/epson1355fb.c	Sun Jun 17 15:55:44 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/video/epson1355fb.c	Sun Jul 15 05:06:15 2001
@@ -25,7 +25,7 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/sched.h>
diff -Nur linux-2.4.7-pre6/drivers/video/maxinefb.c linux-2.4.7-pre6+mallocRIP/drivers/video/maxinefb.c
--- linux-2.4.7-pre6/drivers/video/maxinefb.c	Thu Jul 12 03:13:09 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/video/maxinefb.c	Sun Jul 15 05:06:15 2001
@@ -31,7 +31,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/tty.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/fb.h>
diff -Nur linux-2.4.7-pre6/drivers/video/pmag-ba-fb.c linux-2.4.7-pre6+mallocRIP/drivers/video/pmag-ba-fb.c
--- linux-2.4.7-pre6/drivers/video/pmag-ba-fb.c	Mon Apr 30 14:18:49 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/video/pmag-ba-fb.c	Sun Jul 15 05:06:15 2001
@@ -27,7 +27,7 @@
 #include <linux/timer.h>
 #include <linux/mm.h>
 #include <linux/tty.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/fb.h>
diff -Nur linux-2.4.7-pre6/drivers/video/pmagb-b-fb.c linux-2.4.7-pre6+mallocRIP/drivers/video/pmagb-b-fb.c
--- linux-2.4.7-pre6/drivers/video/pmagb-b-fb.c	Mon Apr 30 14:18:49 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/video/pmagb-b-fb.c	Sun Jul 15 05:06:15 2001
@@ -30,7 +30,7 @@
 #include <linux/timer.h>
 #include <linux/mm.h>
 #include <linux/tty.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/fb.h>
diff -Nur linux-2.4.7-pre6/drivers/video/pvr2fb.c linux-2.4.7-pre6+mallocRIP/drivers/video/pvr2fb.c
--- linux-2.4.7-pre6/drivers/video/pvr2fb.c	Thu Jul 12 03:13:09 2001
+++ linux-2.4.7-pre6+mallocRIP/drivers/video/pvr2fb.c	Sun Jul 15 05:06:15 2001
@@ -51,7 +51,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/tty.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/config.h>
 #include <linux/interrupt.h>
diff -Nur linux-2.4.7-pre6/fs/partitions/ibm.c linux-2.4.7-pre6+mallocRIP/fs/partitions/ibm.c
--- linux-2.4.7-pre6/fs/partitions/ibm.c	Sun Jun 17 15:55:52 2001
+++ linux-2.4.7-pre6+mallocRIP/fs/partitions/ibm.c	Sun Jul 15 05:06:15 2001
@@ -17,7 +17,7 @@
 #include <linux/major.h>
 #include <linux/string.h>
 #include <linux/blk.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/hdreg.h>
 #include <linux/ioctl.h>
 #include <linux/version.h>
diff -Nur linux-2.4.7-pre6/include/linux/malloc.h linux-2.4.7-pre6+mallocRIP/include/linux/malloc.h
--- linux-2.4.7-pre6/include/linux/malloc.h	Thu Jul 12 03:53:53 2001
+++ linux-2.4.7-pre6+mallocRIP/include/linux/malloc.h	Sun Jul 15 05:07:34 2001
@@ -1,5 +1,5 @@
 #ifndef _LINUX_MALLOC_H
 #define _LINUX_MALLOC_H
-
+#warning The Use of linux/malloc.h is depricated, linux/slab.h
 #include <linux/slab.h>
 #endif /* _LINUX_MALLOC_H */
diff -Nur linux-2.4.7-pre6/net/bluetooth/af_bluetooth.c linux-2.4.7-pre6+mallocRIP/net/bluetooth/af_bluetooth.c
--- linux-2.4.7-pre6/net/bluetooth/af_bluetooth.c	Wed Jul  4 22:58:54 2001
+++ linux-2.4.7-pre6+mallocRIP/net/bluetooth/af_bluetooth.c	Sun Jul 15 05:06:16 2001
@@ -36,7 +36,7 @@
 #include <linux/kernel.h>
 #include <linux/major.h>
 #include <linux/sched.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/skbuff.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
diff -Nur linux-2.4.7-pre6/net/bluetooth/hci_core.c linux-2.4.7-pre6+mallocRIP/net/bluetooth/hci_core.c
--- linux-2.4.7-pre6/net/bluetooth/hci_core.c	Wed Jul  4 22:58:54 2001
+++ linux-2.4.7-pre6+mallocRIP/net/bluetooth/hci_core.c	Sun Jul 15 05:06:16 2001
@@ -36,7 +36,7 @@
 #include <linux/kernel.h>
 #include <linux/major.h>
 #include <linux/sched.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/poll.h>
 #include <linux/fcntl.h>
 #include <linux/init.h>
diff -Nur linux-2.4.7-pre6/net/bluetooth/hci_sock.c linux-2.4.7-pre6+mallocRIP/net/bluetooth/hci_sock.c
--- linux-2.4.7-pre6/net/bluetooth/hci_sock.c	Wed Jul  4 22:58:54 2001
+++ linux-2.4.7-pre6+mallocRIP/net/bluetooth/hci_sock.c	Sun Jul 15 05:06:16 2001
@@ -36,7 +36,7 @@
 #include <linux/kernel.h>
 #include <linux/major.h>
 #include <linux/sched.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/poll.h>
 #include <linux/fcntl.h>
 #include <linux/init.h>
diff -Nur linux-2.4.7-pre6/net/bluetooth/l2cap_core.c linux-2.4.7-pre6+mallocRIP/net/bluetooth/l2cap_core.c
--- linux-2.4.7-pre6/net/bluetooth/l2cap_core.c	Wed Jul  4 22:58:54 2001
+++ linux-2.4.7-pre6+mallocRIP/net/bluetooth/l2cap_core.c	Sun Jul 15 05:06:16 2001
@@ -36,7 +36,7 @@
 #include <linux/kernel.h>
 #include <linux/major.h>
 #include <linux/sched.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/poll.h>
 #include <linux/fcntl.h>
 #include <linux/init.h>
diff -Nur linux-2.4.7-pre6/net/bluetooth/l2cap_proc.c linux-2.4.7-pre6+mallocRIP/net/bluetooth/l2cap_proc.c
--- linux-2.4.7-pre6/net/bluetooth/l2cap_proc.c	Wed Jul  4 22:58:54 2001
+++ linux-2.4.7-pre6+mallocRIP/net/bluetooth/l2cap_proc.c	Sun Jul 15 05:06:16 2001
@@ -36,7 +36,7 @@
 #include <linux/kernel.h>
 #include <linux/major.h>
 #include <linux/sched.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/poll.h>
 #include <linux/fcntl.h>
 #include <linux/init.h>
diff -Nur linux-2.4.7-pre6/net/wanrouter/wanmain.c linux-2.4.7-pre6+mallocRIP/net/wanrouter/wanmain.c
--- linux-2.4.7-pre6/net/wanrouter/wanmain.c	Wed Jul  4 22:58:54 2001
+++ linux-2.4.7-pre6+mallocRIP/net/wanrouter/wanmain.c	Sun Jul 15 05:06:16 2001
@@ -48,7 +48,7 @@
 #include <linux/errno.h>	/* return codes */
 #include <linux/kernel.h>
 #include <linux/module.h>	/* support for loadable modules */
-#include <linux/malloc.h>	/* kmalloc(), kfree() */
+#include <linux/slab.h>	/* kmalloc(), kfree() */
 #include <linux/mm.h>		/* verify_area(), etc. */
 #include <linux/string.h>	/* inline mem*, str* functions */
 
diff -Nur linux-2.4.7-pre6/net/wanrouter/wanproc.c linux-2.4.7-pre6+mallocRIP/net/wanrouter/wanproc.c
--- linux-2.4.7-pre6/net/wanrouter/wanproc.c	Wed Jul  4 22:58:54 2001
+++ linux-2.4.7-pre6+mallocRIP/net/wanrouter/wanproc.c	Sun Jul 15 05:06:16 2001
@@ -25,7 +25,7 @@
 #include <linux/stddef.h>	/* offsetof(), etc. */
 #include <linux/errno.h>	/* return codes */
 #include <linux/kernel.h>
-#include <linux/malloc.h>	/* kmalloc(), kfree() */
+#include <linux/slab.h>	/* kmalloc(), kfree() */
 #include <linux/mm.h>		/* verify_area(), etc. */
 #include <linux/string.h>	/* inline mem*, str* functions */
 #include <asm/byteorder.h>	/* htons(), etc. */
