Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261409AbSKRDrA>; Sun, 17 Nov 2002 22:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261411AbSKRDrA>; Sun, 17 Nov 2002 22:47:00 -0500
Received: from 2-023.ctame701-2.telepar.net.br ([200.181.170.23]:19730 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261409AbSKRDqv>; Sun, 17 Nov 2002 22:46:51 -0500
Date: Mon, 18 Nov 2002 01:53:46 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] sound: fixup after header files cleanups: add include <linux/interrupt.h>
Message-ID: <20021118035345.GH32457@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

	Please pull from:

master.kernel.org:/home/acme/BK/includes-2.5

	Now there is only this outstanding changeset.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.888, 2002-11-18 01:33:05-02:00, acme@conectiva.com.br
  o sound: fix up header cleanups: add include <linux/interrupt.h>
  
  Also convert cmipci to C99 designated initializers style


 drivers/serial-u16550.c   |    4 ++
 isa/ad1848/ad1848_lib.c   |    6 ++--
 isa/cs423x/cs4231_lib.c   |    8 +++--
 isa/es1688/es1688_lib.c   |    6 ++--
 isa/gus/gus_main.c        |    4 ++
 isa/opl3sa2.c             |    4 ++
 isa/sb/sb_common.c        |    6 ++--
 isa/wavefront/wavefront.c |    1 
 oss/ad1816.c              |    1 
 oss/ad1848.c              |    1 
 oss/cmpci.c               |   62 +++++++++++++++++++++++-----------------------
 oss/es1370.c              |   10 ++++---
 oss/es1371.c              |    8 +++--
 oss/esssolo1.c            |   10 ++++---
 oss/gus_card.c            |    1 
 oss/i810_audio.c          |   10 +++----
 oss/mpu401.c              |    1 
 oss/nm256_audio.c         |    1 
 oss/pas2_card.c           |    1 
 oss/sb_common.c           |    1 
 oss/sonicvibes.c          |   11 ++++----
 oss/uart401.c             |    1 
 oss/uart6850.c            |    1 
 oss/via82cxxx_audio.c     |    2 -
 oss/ymfpci.c              |    1 
 25 files changed, 98 insertions(+), 64 deletions(-)


diff -Nru a/sound/drivers/serial-u16550.c b/sound/drivers/serial-u16550.c
--- a/sound/drivers/serial-u16550.c	Mon Nov 18 01:48:59 2002
+++ b/sound/drivers/serial-u16550.c	Mon Nov 18 01:48:59 2002
@@ -31,8 +31,8 @@
  */
 
 #include <sound/driver.h>
-#include <asm/io.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <sound/core.h>
@@ -41,6 +41,8 @@
 #include <sound/initval.h>
 
 #include <linux/serial_reg.h>
+
+#include <asm/io.h>
 
 MODULE_DESCRIPTION("MIDI serial u16550");
 MODULE_LICENSE("GPL");
diff -Nru a/sound/isa/ad1848/ad1848_lib.c b/sound/isa/ad1848/ad1848_lib.c
--- a/sound/isa/ad1848/ad1848_lib.c	Mon Nov 18 01:48:59 2002
+++ b/sound/isa/ad1848/ad1848_lib.c	Mon Nov 18 01:48:59 2002
@@ -21,15 +21,17 @@
 
 #define SNDRV_MAIN_OBJECT_FILE
 #include <sound/driver.h>
-#include <asm/io.h>
-#include <asm/dma.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <sound/core.h>
 #include <sound/ad1848.h>
 #include <sound/pcm_params.h>
+
+#include <asm/io.h>
+#include <asm/dma.h>
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("Routines for control of AD1848/AD1847/CS4248");
diff -Nru a/sound/isa/cs423x/cs4231_lib.c b/sound/isa/cs423x/cs4231_lib.c
--- a/sound/isa/cs423x/cs4231_lib.c	Mon Nov 18 01:48:59 2002
+++ b/sound/isa/cs423x/cs4231_lib.c	Mon Nov 18 01:48:59 2002
@@ -25,17 +25,19 @@
  */
 
 #include <sound/driver.h>
-#include <asm/io.h>
-#include <asm/dma.h>
-#include <asm/irq.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <sound/core.h>
 #include <sound/cs4231.h>
 #include <sound/pcm_params.h>
+
+#include <asm/io.h>
+#include <asm/dma.h>
+#include <asm/irq.h>
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("Routines for control of CS4231(A)/CS4232/InterWave & compatible chips");
diff -Nru a/sound/isa/es1688/es1688_lib.c b/sound/isa/es1688/es1688_lib.c
--- a/sound/isa/es1688/es1688_lib.c	Mon Nov 18 01:48:59 2002
+++ b/sound/isa/es1688/es1688_lib.c	Mon Nov 18 01:48:59 2002
@@ -20,15 +20,17 @@
  */
 
 #include <sound/driver.h>
-#include <asm/io.h>
-#include <asm/dma.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <sound/core.h>
 #include <sound/es1688.h>
 #include <sound/initval.h>
+
+#include <asm/io.h>
+#include <asm/dma.h>
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("ESS ESx688 lowlevel module");
diff -Nru a/sound/isa/gus/gus_main.c b/sound/isa/gus/gus_main.c
--- a/sound/isa/gus/gus_main.c	Mon Nov 18 01:48:59 2002
+++ b/sound/isa/gus/gus_main.c	Mon Nov 18 01:48:59 2002
@@ -20,14 +20,16 @@
  */
 
 #include <sound/driver.h>
-#include <asm/dma.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <sound/core.h>
 #include <sound/gus.h>
 #include <sound/control.h>
+
+#include <asm/dma.h>
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("Routines for Gravis UltraSound soundcards");
diff -Nru a/sound/isa/opl3sa2.c b/sound/isa/opl3sa2.c
--- a/sound/isa/opl3sa2.c	Mon Nov 18 01:48:59 2002
+++ b/sound/isa/opl3sa2.c	Mon Nov 18 01:48:59 2002
@@ -20,8 +20,8 @@
  */
 
 #include <sound/driver.h>
-#include <asm/io.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
 #ifndef LINUX_ISAPNP_H
@@ -35,6 +35,8 @@
 #include <sound/opl3.h>
 #define SNDRV_GET_ID
 #include <sound/initval.h>
+
+#include <asm/io.h>
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("Yamaha OPL3SA2+");
diff -Nru a/sound/isa/sb/sb_common.c b/sound/isa/sb/sb_common.c
--- a/sound/isa/sb/sb_common.c	Mon Nov 18 01:48:59 2002
+++ b/sound/isa/sb/sb_common.c	Mon Nov 18 01:48:59 2002
@@ -21,15 +21,17 @@
  */
 
 #include <sound/driver.h>
-#include <asm/io.h>
-#include <asm/dma.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <sound/core.h>
 #include <sound/sb.h>
 #include <sound/initval.h>
+
+#include <asm/io.h>
+#include <asm/dma.h>
 
 #define chip_t sb_t
 
diff -Nru a/sound/isa/wavefront/wavefront.c b/sound/isa/wavefront/wavefront.c
--- a/sound/isa/wavefront/wavefront.c	Mon Nov 18 01:48:59 2002
+++ b/sound/isa/wavefront/wavefront.c	Mon Nov 18 01:48:59 2002
@@ -21,6 +21,7 @@
 
 #include <sound/driver.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/slab.h>
 #ifndef LINUX_ISAPNP_H
 #include <linux/isapnp.h>
diff -Nru a/sound/oss/ad1816.c b/sound/oss/ad1816.c
--- a/sound/oss/ad1816.c	Mon Nov 18 01:48:59 2002
+++ b/sound/oss/ad1816.c	Mon Nov 18 01:48:59 2002
@@ -35,6 +35,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/isapnp.h>
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
diff -Nru a/sound/oss/ad1848.c b/sound/oss/ad1848.c
--- a/sound/oss/ad1848.c	Mon Nov 18 01:48:59 2002
+++ b/sound/oss/ad1848.c	Mon Nov 18 01:48:59 2002
@@ -43,6 +43,7 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/stddef.h>
 #include <linux/pm.h>
diff -Nru a/sound/oss/cmpci.c b/sound/oss/cmpci.c
--- a/sound/oss/cmpci.c	Mon Nov 18 01:48:59 2002
+++ b/sound/oss/cmpci.c	Mon Nov 18 01:48:59 2002
@@ -90,6 +90,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/string.h>
+#include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
@@ -98,15 +99,16 @@
 #include <linux/soundcard.h>
 #include <linux/pci.h>
 #include <linux/wrapper.h>
-#include <asm/io.h>
-#include <asm/dma.h>
 #include <linux/init.h>
 #include <linux/poll.h>
 #include <linux/spinlock.h>
 #include <linux/smp_lock.h>
-#include <asm/uaccess.h>
-#include <asm/hardirq.h>
 #include <linux/bitops.h>
+#include <linux/wait.h>
+
+#include <asm/io.h>
+#include <asm/page.h>
+#include <asm/uaccess.h>
 
 #include "dm.h"
 
@@ -1466,11 +1468,11 @@
 }
 
 static /*const*/ struct file_operations cm_mixer_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		cm_ioctl_mixdev,
-	open:		cm_open_mixdev,
-	release:	cm_release_mixdev,
+	.owner	 = THIS_MODULE,
+	.llseek	 = no_llseek,
+	.ioctl	 = cm_ioctl_mixdev,
+	.open	 = cm_open_mixdev,
+	.release = cm_release_mixdev,
 };
 
 
@@ -2278,15 +2280,15 @@
 }
 
 static /*const*/ struct file_operations cm_audio_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		cm_read,
-	write:		cm_write,
-	poll:		cm_poll,
-	ioctl:		cm_ioctl,
-	mmap:		cm_mmap,
-	open:		cm_open,
-	release:	cm_release,
+	.owner	 = THIS_MODULE,
+	.llseek	 = no_llseek,
+	.read	 = cm_read,
+	.write	 = cm_write,
+	.poll	 = cm_poll,
+	.ioctl	 = cm_ioctl,
+	.mmap	 = cm_mmap,
+	.open	 = cm_open,
+	.release = cm_release,
 };
 
 #ifdef CONFIG_SOUND_CMPCI_MIDI
@@ -2556,13 +2558,13 @@
 }
 
 static /*const*/ struct file_operations cm_midi_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		cm_midi_read,
-	write:		cm_midi_write,
-	poll:		cm_midi_poll,
-	open:		cm_midi_open,
-	release:	cm_midi_release,
+	.owner	 = THIS_MODULE,
+	.llseek	 = no_llseek,
+	.read	 = cm_midi_read,
+	.write	 = cm_midi_write,
+	.poll	 = cm_midi_poll,
+	.open	 = cm_midi_open,
+	.release = cm_midi_release,
 };
 #endif
 
@@ -2722,11 +2724,11 @@
 }
 
 static /*const*/ struct file_operations cm_dmfm_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		cm_dmfm_ioctl,
-	open:		cm_dmfm_open,
-	release:	cm_dmfm_release,
+	.owner	 = THIS_MODULE,
+	.llseek	 = no_llseek,
+	.ioctl	 = cm_dmfm_ioctl,
+	.open	 = cm_dmfm_open,
+	.release = cm_dmfm_release,
 };
 #endif /* CONFIG_SOUND_CMPCI_FM */
 
diff -Nru a/sound/oss/es1370.c b/sound/oss/es1370.c
--- a/sound/oss/es1370.c	Mon Nov 18 01:48:59 2002
+++ b/sound/oss/es1370.c	Mon Nov 18 01:48:59 2002
@@ -140,6 +140,7 @@
 /*****************************************************************************/
       
 #include <linux/version.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/ioport.h>
@@ -151,14 +152,15 @@
 #include <linux/pci.h>
 #include <linux/smp_lock.h>
 #include <linux/wrapper.h>
-#include <asm/io.h>
-#include <asm/dma.h>
 #include <linux/init.h>
 #include <linux/poll.h>
 #include <linux/spinlock.h>
-#include <asm/uaccess.h>
-#include <asm/hardirq.h>
 #include <linux/gameport.h>
+#include <linux/wait.h>
+
+#include <asm/io.h>
+#include <asm/page.h>
+#include <asm/uaccess.h>
 
 /* --------------------------------------------------------------------- */
 
diff -Nru a/sound/oss/es1371.c b/sound/oss/es1371.c
--- a/sound/oss/es1371.c	Mon Nov 18 01:48:59 2002
+++ b/sound/oss/es1371.c	Mon Nov 18 01:48:59 2002
@@ -109,6 +109,7 @@
 /*****************************************************************************/
       
 #include <linux/version.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/ioport.h>
@@ -126,11 +127,12 @@
 #include <linux/smp_lock.h>
 #include <linux/ac97_codec.h>
 #include <linux/wrapper.h>
+#include <linux/gameport.h>
+#include <linux/wait.h>
+
 #include <asm/io.h>
-#include <asm/dma.h>
+#include <asm/page.h>
 #include <asm/uaccess.h>
-#include <asm/hardirq.h>
-#include <linux/gameport.h>
 
 /* --------------------------------------------------------------------- */
 
diff -Nru a/sound/oss/esssolo1.c b/sound/oss/esssolo1.c
--- a/sound/oss/esssolo1.c	Mon Nov 18 01:48:59 2002
+++ b/sound/oss/esssolo1.c	Mon Nov 18 01:48:59 2002
@@ -87,6 +87,7 @@
 /*****************************************************************************/
       
 #include <linux/version.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/ioport.h>
@@ -97,16 +98,17 @@
 #include <linux/soundcard.h>
 #include <linux/pci.h>
 #include <linux/bitops.h>
-#include <asm/io.h>
-#include <asm/dma.h>
 #include <linux/init.h>
 #include <linux/poll.h>
 #include <linux/spinlock.h>
 #include <linux/smp_lock.h>
 #include <linux/wrapper.h>
-#include <asm/uaccess.h>
-#include <asm/hardirq.h>
 #include <linux/gameport.h>
+#include <linux/wait.h>
+
+#include <asm/io.h>
+#include <asm/page.h>
+#include <asm/uaccess.h>
 
 #include "dm.h"
 
diff -Nru a/sound/oss/gus_card.c b/sound/oss/gus_card.c
--- a/sound/oss/gus_card.c	Mon Nov 18 01:48:59 2002
+++ b/sound/oss/gus_card.c	Mon Nov 18 01:48:59 2002
@@ -17,6 +17,7 @@
  
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 
 #include "sound_config.h"
diff -Nru a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
--- a/sound/oss/i810_audio.c	Mon Nov 18 01:48:59 2002
+++ b/sound/oss/i810_audio.c	Mon Nov 18 01:48:59 2002
@@ -70,24 +70,24 @@
 #include <linux/module.h>
 #include <linux/version.h>
 #include <linux/string.h>
-#include <linux/ctype.h>
+#include <linux/interrupt.h>
 #include <linux/ioport.h>
-#include <linux/sched.h>
+#include <linux/wait.h>
 #include <linux/delay.h>
 #include <linux/sound.h>
 #include <linux/slab.h>
 #include <linux/soundcard.h>
 #include <linux/pci.h>
-#include <asm/io.h>
-#include <asm/dma.h>
 #include <linux/init.h>
 #include <linux/poll.h>
 #include <linux/spinlock.h>
 #include <linux/smp_lock.h>
 #include <linux/ac97_codec.h>
 #include <linux/wrapper.h>
+
+#include <asm/io.h>
+#include <asm/page.h>
 #include <asm/uaccess.h>
-#include <asm/hardirq.h>
 
 #ifndef PCI_DEVICE_ID_INTEL_82801
 #define PCI_DEVICE_ID_INTEL_82801	0x2415
diff -Nru a/sound/oss/mpu401.c b/sound/oss/mpu401.c
--- a/sound/oss/mpu401.c	Mon Nov 18 01:48:59 2002
+++ b/sound/oss/mpu401.c	Mon Nov 18 01:48:59 2002
@@ -19,6 +19,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #define USE_SEQ_MACROS
 #define USE_SIMPLE_MACROS
diff -Nru a/sound/oss/nm256_audio.c b/sound/oss/nm256_audio.c
--- a/sound/oss/nm256_audio.c	Mon Nov 18 01:48:59 2002
+++ b/sound/oss/nm256_audio.c	Mon Nov 18 01:48:59 2002
@@ -22,6 +22,7 @@
 #define __NO_VERSION__
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/delay.h>
diff -Nru a/sound/oss/pas2_card.c b/sound/oss/pas2_card.c
--- a/sound/oss/pas2_card.c	Mon Nov 18 01:48:59 2002
+++ b/sound/oss/pas2_card.c	Mon Nov 18 01:48:59 2002
@@ -6,6 +6,7 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include "sound_config.h"
diff -Nru a/sound/oss/sb_common.c b/sound/oss/sb_common.c
--- a/sound/oss/sb_common.c	Mon Nov 18 01:48:59 2002
+++ b/sound/oss/sb_common.c	Mon Nov 18 01:48:59 2002
@@ -28,6 +28,7 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
diff -Nru a/sound/oss/sonicvibes.c b/sound/oss/sonicvibes.c
--- a/sound/oss/sonicvibes.c	Mon Nov 18 01:48:59 2002
+++ b/sound/oss/sonicvibes.c	Mon Nov 18 01:48:59 2002
@@ -103,22 +103,23 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/ioport.h>
-#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/wait.h>
+#include <linux/mm.h>
 #include <linux/delay.h>
 #include <linux/sound.h>
 #include <linux/slab.h>
 #include <linux/soundcard.h>
 #include <linux/pci.h>
-#include <asm/io.h>
-#include <asm/dma.h>
 #include <linux/init.h>
 #include <linux/poll.h>
 #include <linux/spinlock.h>
 #include <linux/smp_lock.h>
 #include <linux/wrapper.h>
-#include <asm/uaccess.h>
-#include <asm/hardirq.h>
 #include <linux/gameport.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
 
 #include "dm.h"
 
diff -Nru a/sound/oss/uart401.c b/sound/oss/uart401.c
--- a/sound/oss/uart401.c	Mon Nov 18 01:48:59 2002
+++ b/sound/oss/uart401.c	Mon Nov 18 01:48:59 2002
@@ -22,6 +22,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include "sound_config.h"
diff -Nru a/sound/oss/uart6850.c b/sound/oss/uart6850.c
--- a/sound/oss/uart6850.c	Mon Nov 18 01:48:59 2002
+++ b/sound/oss/uart6850.c	Mon Nov 18 01:48:59 2002
@@ -22,6 +22,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
 /* Mon Nov 22 22:38:35 MET 1993 marco@driq.home.usn.nl:
diff -Nru a/sound/oss/via82cxxx_audio.c b/sound/oss/via82cxxx_audio.c
--- a/sound/oss/via82cxxx_audio.c	Mon Nov 18 01:48:59 2002
+++ b/sound/oss/via82cxxx_audio.c	Mon Nov 18 01:48:59 2002
@@ -22,6 +22,7 @@
 #include <linux/mm.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
 #include <linux/sound.h>
@@ -34,7 +35,6 @@
 #include <linux/delay.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
-#include <asm/hardirq.h>
 #include <asm/semaphore.h>
 #include "sound_config.h"
 #include "dev_table.h"
diff -Nru a/sound/oss/ymfpci.c b/sound/oss/ymfpci.c
--- a/sound/oss/ymfpci.c	Mon Nov 18 01:48:59 2002
+++ b/sound/oss/ymfpci.c	Mon Nov 18 01:48:59 2002
@@ -54,6 +54,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/pci.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.888
## Wrapped with gzip_uu ##


begin 664 bkpatch7982
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
DWI9S$.)BU$?M7WGHWUO_8[:-W_MAZ(4TP,[_`.+Z2KMD40``
`
end
