Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992994AbWJUMVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992994AbWJUMVQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 08:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992995AbWJUMVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 08:21:16 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:25824 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S2992994AbWJUMVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 08:21:14 -0400
Subject: [PATCH] Add include/linux/freezer.h and move definitions from
	sched.h
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>,
       suspend2-devel <suspend2-devel@lists.suspend2.net>
Content-Type: text/plain
Date: Sat, 21 Oct 2006 22:21:05 +1000
Message-Id: <1161433266.7644.7.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move process freezing functions from include/linux/sched.h to freezer.h,
so that modifications to the freezer or the kernel configuration don't
require recompiling just about everything.

Prepared against current git.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 48cf7ff..f38a60a 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -11,6 +11,7 @@ #include <linux/errno.h>
 #include <linux/signal.h>
 #include <linux/ptrace.h>
 #include <linux/personality.h>
+#include <linux/freezer.h>
 
 #include <asm/cacheflush.h>
 #include <asm/ucontext.h>
diff --git a/arch/avr32/kernel/signal.c b/arch/avr32/kernel/signal.c
index 3309665..0ec1485 100644
--- a/arch/avr32/kernel/signal.c
+++ b/arch/avr32/kernel/signal.c
@@ -15,7 +15,7 @@ #include <linux/mm.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
 #include <linux/unistd.h>
-#include <linux/suspend.h>
+#include <linux/freezer.h>
 
 #include <asm/uaccess.h>
 #include <asm/ucontext.h>
diff --git a/arch/frv/kernel/signal.c b/arch/frv/kernel/signal.c
index b8a5882..85baeae 100644
--- a/arch/frv/kernel/signal.c
+++ b/arch/frv/kernel/signal.c
@@ -21,7 +21,7 @@ #include <linux/wait.h>
 #include <linux/ptrace.h>
 #include <linux/unistd.h>
 #include <linux/personality.h>
-#include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/cacheflush.h>
diff --git a/arch/h8300/kernel/signal.c b/arch/h8300/kernel/signal.c
index 7787f70..0295560 100644
--- a/arch/h8300/kernel/signal.c
+++ b/arch/h8300/kernel/signal.c
@@ -38,7 +38,7 @@ #include <linux/highuid.h>
 #include <linux/personality.h>
 #include <linux/tty.h>
 #include <linux/binfmts.h>
-#include <linux/suspend.h>
+#include <linux/freezer.h>
 
 #include <asm/setup.h>
 #include <asm/uaccess.h>
diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
index 350192d..d8c7686 100644
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -34,6 +34,7 @@ #include <linux/sysdev.h>
 #include <linux/pci.h>
 #include <linux/msi.h>
 #include <linux/htirq.h>
+#include <linux/freezer.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
diff --git a/arch/m32r/kernel/signal.c b/arch/m32r/kernel/signal.c
index b60cea4..092ea86 100644
--- a/arch/m32r/kernel/signal.c
+++ b/arch/m32r/kernel/signal.c
@@ -21,7 +21,7 @@ #include <linux/wait.h>
 #include <linux/unistd.h>
 #include <linux/stddef.h>
 #include <linux/personality.h>
-#include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <asm/cacheflush.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 320353f..e4ebe1a 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -36,7 +36,7 @@ #include <linux/unistd.h>
 #include <linux/stddef.h>
 #include <linux/tty.h>
 #include <linux/binfmts.h>
-#include <linux/suspend.h>
+#include <linux/freezer.h>
 #endif
 
 #include <asm/uaccess.h>
diff --git a/arch/sh/kernel/signal.c b/arch/sh/kernel/signal.c
index 5213f5b..380249a 100644
--- a/arch/sh/kernel/signal.c
+++ b/arch/sh/kernel/signal.c
@@ -23,6 +23,7 @@ #include <linux/tty.h>
 #include <linux/elf.h>
 #include <linux/personality.h>
 #include <linux/binfmts.h>
+#include <linux/freezer.h>
 
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
diff --git a/arch/sh64/kernel/signal.c b/arch/sh64/kernel/signal.c
index 9e2ffc4..1666d3e 100644
--- a/arch/sh64/kernel/signal.c
+++ b/arch/sh64/kernel/signal.c
@@ -22,7 +22,7 @@ #include <linux/signal.h>
 #include <linux/errno.h>
 #include <linux/wait.h>
 #include <linux/personality.h>
-#include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <linux/ptrace.h>
 #include <linux/unistd.h>
 #include <linux/stddef.h>
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index f2904f6..e45eaa2 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -54,7 +54,7 @@ #include <linux/file.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/miscdevice.h>
-#include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <linux/mutex.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_ioctl.h>
diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
index 9902ffa..cc2cd46 100644
--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -38,6 +38,7 @@ #include <linux/tty_flip.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/delay.h>
+#include <linux/freezer.h>
 
 #include <asm/uaccess.h>
 
diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 4bde30b..54e4490 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -28,6 +28,7 @@ #include <linux/list.h>
 #include <linux/sysdev.h>
 #include <linux/ctype.h>
 #include <linux/kthread.h>
+#include <linux/freezer.h>
 #include <asm/uaccess.h>
 #include <asm/page.h>
 #include <asm/edac.h>
diff --git a/drivers/ieee1394/nodemgr.c b/drivers/ieee1394/nodemgr.c
index 8e7b83f..e829c93 100644
--- a/drivers/ieee1394/nodemgr.c
+++ b/drivers/ieee1394/nodemgr.c
@@ -15,6 +15,7 @@ #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/moduleparam.h>
+#include <linux/freezer.h>
 #include <asm/atomic.h>
 
 #include "csr.h"
diff --git a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
index a0af97e..79dfb4b 100644
--- a/drivers/input/gameport/gameport.c
+++ b/drivers/input/gameport/gameport.c
@@ -23,6 +23,7 @@ #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/sched.h>	/* HZ */
 #include <linux/mutex.h>
+#include <linux/freezer.h>
 
 /*#include <asm/io.h>*/
 
diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 211943f..5f1d403 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -35,6 +35,7 @@ #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/kthread.h>
 #include <linux/mutex.h>
+#include <linux/freezer.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Serio abstraction core");
diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index a0f30d0..9397b08 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -24,6 +24,7 @@ #include <linux/wait.h>
 #include <linux/suspend.h>
 #include <linux/kthread.h>
 #include <linux/moduleparam.h>
+#include <linux/freezer.h>
 
 #include <asm/prom.h>
 #include <asm/machdep.h>
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index e63ea1c..c8558d4 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -42,7 +42,7 @@ #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/sysdev.h>
-#include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <linux/syscalls.h>
 #include <linux/cpu.h>
 #include <asm/prom.h>
diff --git a/drivers/macintosh/windfarm_core.c b/drivers/macintosh/windfarm_core.c
index ab3faa7..e947af9 100644
--- a/drivers/macintosh/windfarm_core.c
+++ b/drivers/macintosh/windfarm_core.c
@@ -34,6 +34,7 @@ #include <linux/reboot.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
+#include <linux/freezer.h>
 
 #include <asm/prom.h>
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index f7f1908..eabbf0d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -39,10 +39,10 @@ #include <linux/raid/md.h>
 #include <linux/raid/bitmap.h>
 #include <linux/sysctl.h>
 #include <linux/buffer_head.h> /* for invalidate_bdev */
-#include <linux/suspend.h>
 #include <linux/poll.h>
 #include <linux/mutex.h>
 #include <linux/ctype.h>
+#include <linux/freezer.h>
 
 #include <linux/init.h>
 
diff --git a/drivers/media/dvb/dvb-core/dvb_frontend.c b/drivers/media/dvb/dvb-core/dvb_frontend.c
index 53304e6..0fefdf0 100644
--- a/drivers/media/dvb/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb/dvb-core/dvb_frontend.c
@@ -34,7 +34,7 @@ #include <linux/poll.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/list.h>
-#include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <linux/jiffies.h>
 #include <asm/processor.h>
 
diff --git a/drivers/media/video/msp3400-driver.c b/drivers/media/video/msp3400-driver.c
index cf43df3..e1b56dc 100644
--- a/drivers/media/video/msp3400-driver.c
+++ b/drivers/media/video/msp3400-driver.c
@@ -56,7 +56,7 @@ #include <media/v4l2-common.h>
 #include <media/tvaudio.h>
 #include <media/msp3400.h>
 #include <linux/kthread.h>
-#include <linux/suspend.h>
+#include <linux/freezer.h>
 #include "msp3400-driver.h"
 
 /* ---------------------------------------------------------------------- */
diff --git a/drivers/media/video/tvaudio.c b/drivers/media/video/tvaudio.c
index fcaef4b..d506dfa 100644
--- a/drivers/media/video/tvaudio.c
+++ b/drivers/media/video/tvaudio.c
@@ -29,6 +29,7 @@ #include <linux/i2c-algo-bit.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/kthread.h>
+#include <linux/freezer.h>
 
 #include <media/tvaudio.h>
 #include <media/v4l2-common.h>
diff --git a/drivers/media/video/video-buf-dvb.c b/drivers/media/video/video-buf-dvb.c
index f53edf1..fcc5467 100644
--- a/drivers/media/video/video-buf-dvb.c
+++ b/drivers/media/video/video-buf-dvb.c
@@ -20,7 +20,7 @@ #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/kthread.h>
 #include <linux/file.h>
-#include <linux/suspend.h>
+#include <linux/freezer.h>
 
 #include <media/video-buf.h>
 #include <media/video-buf-dvb.h>
diff --git a/drivers/media/video/vivi.c b/drivers/media/video/vivi.c
index 3c8dc72..9986de5 100644
--- a/drivers/media/video/vivi.c
+++ b/drivers/media/video/vivi.c
@@ -36,6 +36,7 @@ #include <media/video-buf.h>
 #include <media/v4l2-common.h>
 #include <linux/kthread.h>
 #include <linux/highmem.h>
+#include <linux/freezer.h>
 
 /* Wake up at about 30 fps */
 #define WAKE_NUMERATOR 30
diff --git a/drivers/mfd/ucb1x00-ts.c b/drivers/mfd/ucb1x00-ts.c
index 82938ad..ce1a481 100644
--- a/drivers/mfd/ucb1x00-ts.c
+++ b/drivers/mfd/ucb1x00-ts.c
@@ -28,7 +28,7 @@ #include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/input.h>
 #include <linux/device.h>
-#include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <linux/slab.h>
 #include <linux/kthread.h>
 
diff --git a/drivers/net/irda/stir4200.c b/drivers/net/irda/stir4200.c
index be8a66e..5a9c8e8 100644
--- a/drivers/net/irda/stir4200.c
+++ b/drivers/net/irda/stir4200.c
@@ -51,6 +51,7 @@ #include <linux/delay.h>
 #include <linux/usb.h>
 #include <linux/crc32.h>
 #include <linux/kthread.h>
+#include <linux/freezer.h>
 #include <net/irda/irda.h>
 #include <net/irda/irlap.h>
 #include <net/irda/irda_device.h>
diff --git a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
index 0a33c8a..9599dd1 100644
--- a/drivers/net/wireless/airo.c
+++ b/drivers/net/wireless/airo.c
@@ -49,6 +49,7 @@ #include <linux/pci.h>
 #include <asm/uaccess.h>
 #include <net/ieee80211.h>
 #include <linux/kthread.h>
+#include <linux/freezer.h>
 
 #include "airo.h"
 
diff --git a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
index f9cd831..606a467 100644
--- a/drivers/pcmcia/cs.c
+++ b/drivers/pcmcia/cs.c
@@ -29,6 +29,7 @@ #include <linux/pm.h>
 #include <linux/pci.h>
 #include <linux/device.h>
 #include <linux/kthread.h>
+#include <linux/freezer.h>
 #include <asm/system.h>
 #include <asm/irq.h>
 
diff --git a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
index 81a6c83..81186f4 100644
--- a/drivers/pnp/pnpbios/core.c
+++ b/drivers/pnp/pnpbios/core.c
@@ -61,6 +61,7 @@ #include <linux/spinlock.h>
 #include <linux/dmi.h>
 #include <linux/delay.h>
 #include <linux/acpi.h>
+#include <linux/freezer.h>
 
 #include <asm/page.h>
 #include <asm/desc.h>
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 66bff18..d269773 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -22,6 +22,7 @@ #include <linux/usb.h>
 #include <linux/usbdevice_fs.h>
 #include <linux/kthread.h>
 #include <linux/mutex.h>
+#include <linux/freezer.h>
 
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
diff --git a/drivers/usb/gadget/file_storage.c b/drivers/usb/gadget/file_storage.c
index 8b975d1..c98316c 100644
--- a/drivers/usb/gadget/file_storage.c
+++ b/drivers/usb/gadget/file_storage.c
@@ -250,7 +250,7 @@ #include <linux/signal.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
-#include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <linux/utsname.h>
 
 #include <linux/usb_ch9.h>
diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
index b8d6031..e021bc9 100644
--- a/drivers/usb/storage/usb.c
+++ b/drivers/usb/storage/usb.c
@@ -49,7 +49,7 @@
 
 #include <linux/sched.h>
 #include <linux/errno.h>
-#include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index de3e979..63c0724 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -31,6 +31,7 @@ #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/kthread.h>
+#include <linux/freezer.h>
 
 #include <asm/atomic.h>
 
diff --git a/fs/afs/kafsasyncd.c b/fs/afs/kafsasyncd.c
index f09a794..615df24 100644
--- a/fs/afs/kafsasyncd.c
+++ b/fs/afs/kafsasyncd.c
@@ -20,6 +20,7 @@ #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/completion.h>
+#include <linux/freezer.h>
 #include "cell.h"
 #include "server.h"
 #include "volume.h"
diff --git a/fs/afs/kafstimod.c b/fs/afs/kafstimod.c
index 65bc05a..694344e 100644
--- a/fs/afs/kafstimod.c
+++ b/fs/afs/kafstimod.c
@@ -13,6 +13,7 @@ #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/completion.h>
+#include <linux/freezer.h>
 #include "cell.h"
 #include "volume.h"
 #include "kafstimod.h"
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 84976cd..df95c71 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -34,6 +34,7 @@ #include <linux/vfs.h>
 #include <linux/mempool.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
+#include <linux/freezer.h>
 #include "cifsfs.h"
 #include "cifspdu.h"
 #define DECLARE_GLOBALS_HERE
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 4093d53..d205551 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -31,6 +31,7 @@ #include <linux/mempool.h>
 #include <linux/delay.h>
 #include <linux/completion.h>
 #include <linux/pagevec.h>
+#include <linux/freezer.h>
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 #include "cifspdu.h"
diff --git a/fs/jbd/journal.c b/fs/jbd/journal.c
index b85c686..75d3d86 100644
--- a/fs/jbd/journal.c
+++ b/fs/jbd/journal.c
@@ -31,7 +31,7 @@ #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/mm.h>
-#include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <linux/pagemap.h>
 #include <linux/kthread.h>
 #include <linux/poison.h>
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index c60f378..93ca71c 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -31,7 +31,7 @@ #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/mm.h>
-#include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <linux/pagemap.h>
 #include <linux/kthread.h>
 #include <linux/poison.h>
diff --git a/fs/jffs/intrep.c b/fs/jffs/intrep.c
index 4a543e1..478a74e 100644
--- a/fs/jffs/intrep.c
+++ b/fs/jffs/intrep.c
@@ -66,6 +66,7 @@ #include <asm/byteorder.h>
 #include <linux/smp_lock.h>
 #include <linux/time.h>
 #include <linux/ctype.h>
+#include <linux/freezer.h>
 
 #include "intrep.h"
 #include "jffs_fm.h"
diff --git a/fs/jffs2/background.c b/fs/jffs2/background.c
index ff2a872..6eb3dae 100644
--- a/fs/jffs2/background.c
+++ b/fs/jffs2/background.c
@@ -16,6 +16,7 @@ #include <linux/jffs2.h>
 #include <linux/mtd/mtd.h>
 #include <linux/completion.h>
 #include <linux/sched.h>
+#include <linux/freezer.h>
 #include "nodelist.h"
 
 
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index b89c9ab..5065baa 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -67,7 +67,7 @@ #include <linux/completion.h>
 #include <linux/kthread.h>
 #include <linux/buffer_head.h>		/* for sync_blockdev() */
 #include <linux/bio.h>
-#include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include "jfs_incore.h"
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index 81f6f04..d558e51 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -46,7 +46,7 @@ #include <linux/fs.h>
 #include <linux/vmalloc.h>
 #include <linux/smp_lock.h>
 #include <linux/completion.h>
-#include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kthread.h>
diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index 3d84f60..50643b6 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -13,6 +13,7 @@ #include <linux/fs.h>
 #include <linux/nfs_fs.h>
 #include <linux/utsname.h>
 #include <linux/smp_lock.h>
+#include <linux/freezer.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/lockd/lockd.h>
diff --git a/fs/xfs/linux-2.6/xfs_buf.c b/fs/xfs/linux-2.6/xfs_buf.c
index db5f5a3..bc94d0c 100644
--- a/fs/xfs/linux-2.6/xfs_buf.c
+++ b/fs/xfs/linux-2.6/xfs_buf.c
@@ -31,6 +31,7 @@ #include <linux/hash.h>
 #include <linux/kthread.h>
 #include <linux/migrate.h>
 #include <linux/backing-dev.h>
+#include <linux/freezer.h>
 #include "xfs_linux.h"
 
 STATIC kmem_zone_t *xfs_buf_zone;
diff --git a/fs/xfs/linux-2.6/xfs_super.c b/fs/xfs/linux-2.6/xfs_super.c
index 38c4d12..6fa3406 100644
--- a/fs/xfs/linux-2.6/xfs_super.c
+++ b/fs/xfs/linux-2.6/xfs_super.c
@@ -56,6 +56,7 @@ #include <linux/mount.h>
 #include <linux/mempool.h>
 #include <linux/writeback.h>
 #include <linux/kthread.h>
+#include <linux/freezer.h>
 
 STATIC struct quotactl_ops xfs_quotactl_operations;
 STATIC struct super_operations xfs_super_operations;
diff --git a/include/linux/freezer.h b/include/linux/freezer.h
new file mode 100644
index 0000000..266373f
--- /dev/null
+++ b/include/linux/freezer.h
@@ -0,0 +1,84 @@
+/* Freezer declarations */
+
+#ifdef CONFIG_PM
+/*
+ * Check if a process has been frozen
+ */
+static inline int frozen(struct task_struct *p)
+{
+	return p->flags & PF_FROZEN;
+}
+
+/*
+ * Check if there is a request to freeze a process
+ */
+static inline int freezing(struct task_struct *p)
+{
+	return p->flags & PF_FREEZE;
+}
+
+/*
+ * Request that a process be frozen
+ * FIXME: SMP problem. We may not modify other process' flags!
+ */
+static inline void freeze(struct task_struct *p)
+{
+	p->flags |= PF_FREEZE;
+}
+
+/*
+ * Sometimes we may need to cancel the previous 'freeze' request
+ */
+static inline void do_not_freeze(struct task_struct *p)
+{
+	p->flags &= ~PF_FREEZE;
+}
+
+/*
+ * Wake up a frozen process
+ */
+static inline int thaw_process(struct task_struct *p)
+{
+	if (frozen(p)) {
+		p->flags &= ~PF_FROZEN;
+		wake_up_process(p);
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * freezing is complete, mark process as frozen
+ */
+static inline void frozen_process(struct task_struct *p)
+{
+	p->flags = (p->flags & ~PF_FREEZE) | PF_FROZEN;
+}
+
+extern void refrigerator(void);
+extern int freeze_processes(void);
+extern void thaw_processes(void);
+
+static inline int try_to_freeze(void)
+{
+	if (freezing(current)) {
+		refrigerator();
+		return 1;
+	} else
+		return 0;
+}
+#else
+static inline int frozen(struct task_struct *p) { return 0; }
+static inline int freezing(struct task_struct *p) { return 0; }
+static inline void freeze(struct task_struct *p) { BUG(); }
+static inline int thaw_process(struct task_struct *p) { return 1; }
+static inline void frozen_process(struct task_struct *p) { BUG(); }
+
+static inline void refrigerator(void) {}
+static inline int freeze_processes(void) { BUG(); return 0; }
+static inline void thaw_processes(void) {}
+
+static inline int try_to_freeze(void) { return 0; }
+
+
+#endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6735c1c..aeac5d1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1611,87 +1611,6 @@ extern int sched_create_sysfs_power_savi
 
 extern void normalize_rt_tasks(void);
 
-#ifdef CONFIG_PM
-/*
- * Check if a process has been frozen
- */
-static inline int frozen(struct task_struct *p)
-{
-	return p->flags & PF_FROZEN;
-}
-
-/*
- * Check if there is a request to freeze a process
- */
-static inline int freezing(struct task_struct *p)
-{
-	return p->flags & PF_FREEZE;
-}
-
-/*
- * Request that a process be frozen
- * FIXME: SMP problem. We may not modify other process' flags!
- */
-static inline void freeze(struct task_struct *p)
-{
-	p->flags |= PF_FREEZE;
-}
-
-/*
- * Sometimes we may need to cancel the previous 'freeze' request
- */
-static inline void do_not_freeze(struct task_struct *p)
-{
-	p->flags &= ~PF_FREEZE;
-}
-
-/*
- * Wake up a frozen process
- */
-static inline int thaw_process(struct task_struct *p)
-{
-	if (frozen(p)) {
-		p->flags &= ~PF_FROZEN;
-		wake_up_process(p);
-		return 1;
-	}
-	return 0;
-}
-
-/*
- * freezing is complete, mark process as frozen
- */
-static inline void frozen_process(struct task_struct *p)
-{
-	p->flags = (p->flags & ~PF_FREEZE) | PF_FROZEN;
-}
-
-extern void refrigerator(void);
-extern int freeze_processes(void);
-extern void thaw_processes(void);
-
-static inline int try_to_freeze(void)
-{
-	if (freezing(current)) {
-		refrigerator();
-		return 1;
-	} else
-		return 0;
-}
-#else
-static inline int frozen(struct task_struct *p) { return 0; }
-static inline int freezing(struct task_struct *p) { return 0; }
-static inline void freeze(struct task_struct *p) { BUG(); }
-static inline int thaw_process(struct task_struct *p) { return 1; }
-static inline void frozen_process(struct task_struct *p) { BUG(); }
-
-static inline void refrigerator(void) {}
-static inline int freeze_processes(void) { BUG(); return 0; }
-static inline void thaw_processes(void) {}
-
-static inline int try_to_freeze(void) { return 0; }
-
-#endif /* CONFIG_PM */
 #endif /* __KERNEL__ */
 
 #endif
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 919a80c..2cfd7cb 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -6,6 +6,7 @@ #include <linux/ext2_fs.h>
 #include <linux/romfs_fs.h>
 #include <linux/initrd.h>
 #include <linux/sched.h>
+#include <linux/freezer.h>
 
 #include "do_mounts.h"
 
diff --git a/kernel/audit.c b/kernel/audit.c
index 98106f6..d9b690a 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -57,6 +57,7 @@ #include <linux/skbuff.h>
 #include <linux/netlink.h>
 #include <linux/selinux.h>
 #include <linux/inotify.h>
+#include <linux/freezer.h>
 
 #include "audit.h"
 
diff --git a/kernel/power/process.c b/kernel/power/process.c
index 72e72d2..29be608 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -13,6 +13,7 @@ #include <linux/interrupt.h>
 #include <linux/suspend.h>
 #include <linux/module.h>
 #include <linux/syscalls.h>
+#include <linux/freezer.h>
 
 /* 
  * Timeout for stopping processes
diff --git a/kernel/rtmutex-tester.c b/kernel/rtmutex-tester.c
index 6dcea9d..015fc63 100644
--- a/kernel/rtmutex-tester.c
+++ b/kernel/rtmutex-tester.c
@@ -13,6 +13,7 @@ #include <linux/smp_lock.h>
 #include <linux/spinlock.h>
 #include <linux/sysdev.h>
 #include <linux/timer.h>
+#include <linux/freezer.h>
 
 #include "rtmutex.h"
 
diff --git a/kernel/sched.c b/kernel/sched.c
index 3399701..12fdbef 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -34,7 +34,7 @@ #include <linux/debug_locks.h>
 #include <linux/security.h>
 #include <linux/notifier.h>
 #include <linux/profile.h>
-#include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <linux/vmalloc.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
diff --git a/kernel/signal.c b/kernel/signal.c
index 7ed8d53..90dad6d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -23,6 +23,7 @@ #include <linux/syscalls.h>
 #include <linux/ptrace.h>
 #include <linux/signal.h>
 #include <linux/capability.h>
+#include <linux/freezer.h>
 #include <asm/param.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
diff --git a/mm/pdflush.c b/mm/pdflush.c
index b02102f..8ce0900 100644
--- a/mm/pdflush.c
+++ b/mm/pdflush.c
@@ -21,6 +21,7 @@ #include <linux/fs.h>		// Needed by writ
 #include <linux/writeback.h>	// Prototypes pdflush_operation()
 #include <linux/kthread.h>
 #include <linux/cpuset.h>
+#include <linux/freezer.h>
 
 
 /*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f05527b..3c99ab5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -36,6 +36,7 @@ #include <linux/notifier.h>
 #include <linux/rwsem.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
+#include <linux/freezer.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
diff --git a/net/rxrpc/krxiod.c b/net/rxrpc/krxiod.c
index dada34a..49effd9 100644
--- a/net/rxrpc/krxiod.c
+++ b/net/rxrpc/krxiod.c
@@ -13,6 +13,7 @@ #include <linux/sched.h>
 #include <linux/completion.h>
 #include <linux/spinlock.h>
 #include <linux/init.h>
+#include <linux/freezer.h>
 #include <rxrpc/krxiod.h>
 #include <rxrpc/transport.h>
 #include <rxrpc/peer.h>
diff --git a/net/rxrpc/krxsecd.c b/net/rxrpc/krxsecd.c
index cea4eb5..3ab0f77 100644
--- a/net/rxrpc/krxsecd.c
+++ b/net/rxrpc/krxsecd.c
@@ -27,6 +27,7 @@ #include <rxrpc/peer.h>
 #include <rxrpc/call.h>
 #include <linux/udp.h>
 #include <linux/ip.h>
+#include <linux/freezer.h>
 #include <net/sock.h>
 #include "internal.h"
 
diff --git a/net/rxrpc/krxtimod.c b/net/rxrpc/krxtimod.c
index 3e74669..9a9b613 100644
--- a/net/rxrpc/krxtimod.c
+++ b/net/rxrpc/krxtimod.c
@@ -13,6 +13,7 @@ #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/completion.h>
+#include <linux/freezer.h>
 #include <rxrpc/rxrpc.h>
 #include <rxrpc/krxtimod.h>
 #include <asm/errno.h>
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 96521f1..6a23b9d 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -32,6 +32,7 @@ #include <linux/slab.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <linux/file.h>
+#include <linux/freezer.h>
 #include <net/sock.h>
 #include <net/checksum.h>
 #include <net/ip.h>


