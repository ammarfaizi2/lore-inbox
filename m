Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263516AbSJGWLP>; Mon, 7 Oct 2002 18:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263522AbSJGWLO>; Mon, 7 Oct 2002 18:11:14 -0400
Received: from dhcp31182033.columbus.rr.com ([24.31.182.33]:3207 "EHLO
	caphernaum.rivenstone.net") by vger.kernel.org with ESMTP
	id <S263516AbSJGWKK>; Mon, 7 Oct 2002 18:10:10 -0400
Date: Mon, 7 Oct 2002 06:27:41 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: PC speaker dead in 2.5.40? (resend)
Message-ID: <20021007102739.GA4342@rivenstone.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3DA1BD31.4040707@earthlink.net> <20021007070857.GA1927@rivenstone.net> <20021007211427.A833@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <20021007211427.A833@ucw.cz>
User-Agent: Mutt/1.4i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2002 at 09:14:27PM +0200, Vojtech Pavlik wrote:
> On Mon, Oct 07, 2002 at 03:08:57AM -0400, Joseph Fannin wrote:
>=20
> > > Configuring a kernel with Sound support with either
> > > OSS or ALSA, I still get nothing from my PC speaker.
> > > Works fine under 2.4.18.
> >=20
> >     Look under all the submenus in the Input section of
> >     "menuconfig" for the speaker entry and enable it.
> >=20
> >     There's a good technical reason why the speaker is an input
> >     device, but hiding it in the menus is *bad*.
>=20
> Send me a patch that fixes this - if you know how.

    Resend of this little patch -- vger didn't like the last one, I
    think.  This creates a new "PC Speaker" submenu -- it's clearly
    marked and higher up on the "make menuconfig" screen rather than
    hidden away under "misc".

--=20
Joseph Fannin
jhf@rivenstone.net

"Anyone who quotes me in their sig is an idiot." -- Rusty Russell.

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pc-speaker.diff"
Content-Transfer-Encoding: quoted-printable

diff -urN linux-2.5.40/drivers/input/Config.in linux-2.5.40-new/drivers/inp=
ut/Config.in
--- linux-2.5.40/drivers/input/Config.in	2002-09-17 20:58:57.000000000 -0400
+++ linux-2.5.40-new/drivers/input/Config.in	2002-10-07 16:40:44.000000000 =
-0400
@@ -32,6 +32,7 @@
 if [ "$CONFIG_INPUT" !=3D "n" ]; then
    source drivers/input/keyboard/Config.in
    source drivers/input/mouse/Config.in
+   source drivers/input/speaker/Config.in
    source drivers/input/joystick/Config.in
    source drivers/input/touchscreen/Config.in
    source drivers/input/misc/Config.in
diff -urN linux-2.5.40/drivers/input/Makefile linux-2.5.40-new/drivers/inpu=
t/Makefile
--- linux-2.5.40/drivers/input/Makefile	2002-09-17 20:59:18.000000000 -0400
+++ linux-2.5.40-new/drivers/input/Makefile	2002-10-07 16:31:27.000000000 -=
0400
@@ -20,6 +20,7 @@
 obj-$(CONFIG_INPUT_MOUSE)	+=3D mouse/
 obj-$(CONFIG_INPUT_JOYSTICK)	+=3D joystick/
 obj-$(CONFIG_INPUT_TOUCHSCREEN)	+=3D touchscreen/
+obj-$(CONFIG_INPUT_SPEAKER)	+=3D speaker/
 obj-$(CONFIG_INPUT_MISC)	+=3D misc/
=20
 # The global Rules.make.
diff -urN linux-2.5.40/drivers/input/misc/Config.help linux-2.5.40-new/driv=
ers/input/misc/Config.help
--- linux-2.5.40/drivers/input/misc/Config.help	2002-09-17 20:59:20.0000000=
00 -0400
+++ linux-2.5.40-new/drivers/input/misc/Config.help	2002-10-07 16:35:52.000=
000000 -0400
@@ -6,29 +6,6 @@
=20
   If unsure, say Y.
=20
-CONFIG_INPUT_PCSPKR
-  Say Y here if you want the standard PC Speaker to be used for
-  bells and whistles.
-
-  If unsure, say Y.
-
-  This driver is also available as a module ( =3D code which can be
-  inserted in and removed from the running kernel whenever you want).
-  The module will be called pcspkr.o. If you want to compile it as a
-  module, say M here and read <file:Documentation/modules.txt>.
-
-CONFIG_INPUT_SPARCSPKR
-  Say Y here if you want the standard Speaker on Sparc PCI systems
-  to be used for bells and whistles.
-
-  If unsure, say Y.
-
-  This driver is also available as a module ( =3D code which can be
-  inserted in and removed from the running kernel whenever you want).
-  The module will be called pcspkr.o. If you want to compile it as a
-  module, say M here and read <file:Documentation/modules.txt>.
-
-
 CONFIG_INPUT_UINPUT
   Say Y here if you want to support user level drivers for input
   subsystem accessible under char device 10:223 - /dev/input/uinput.
diff -urN linux-2.5.40/drivers/input/misc/Config.in linux-2.5.40-new/driver=
s/input/misc/Config.in
--- linux-2.5.40/drivers/input/misc/Config.in	2002-09-17 20:59:04.000000000=
 -0400
+++ linux-2.5.40-new/drivers/input/misc/Config.in	2002-10-07 16:37:15.00000=
0000 -0400
@@ -4,8 +4,4 @@
=20
 bool 'Misc' CONFIG_INPUT_MISC
=20
-dep_tristate '  PC Speaker support' CONFIG_INPUT_PCSPKR $CONFIG_INPUT $CON=
FIG_INPUT_MISC
-if [ "$CONFIG_SPARC32" =3D "y" -o "$CONFIG_SPARC64" =3D "y" ]; then
-   dep_tristate '  SPARC Speaker support' CONFIG_INPUT_SPARCSPKR $CONFIG_I=
NPUT $CONFIG_INPUT_MISC
-fi
 dep_tristate '  User level driver support' CONFIG_INPUT_UINPUT $CONFIG_INP=
UT $CONFIG_INPUT_MISC
diff -urN linux-2.5.40/drivers/input/misc/Makefile linux-2.5.40-new/drivers=
/input/misc/Makefile
--- linux-2.5.40/drivers/input/misc/Makefile	2002-09-17 20:59:00.000000000 =
-0400
+++ linux-2.5.40-new/drivers/input/misc/Makefile	2002-10-07 16:36:04.000000=
000 -0400
@@ -4,8 +4,6 @@
=20
 # Each configuration option enables a list of files.
=20
-obj-$(CONFIG_INPUT_SPARCSPKR)		+=3D sparcspkr.o
-obj-$(CONFIG_INPUT_PCSPKR)		+=3D pcspkr.o
 obj-$(CONFIG_INPUT_UINPUT)		+=3D uinput.o
=20
 # The global Rules.make.
diff -urN linux-2.5.40/drivers/input/misc/pcspkr.c linux-2.5.40-new/drivers=
/input/misc/pcspkr.c
--- linux-2.5.40/drivers/input/misc/pcspkr.c	2002-09-17 20:58:59.000000000 =
-0400
+++ linux-2.5.40-new/drivers/input/misc/pcspkr.c	1969-12-31 19:00:00.000000=
000 -0500
@@ -1,94 +0,0 @@
-/*
- *  PC Speaker beeper driver for Linux
- *
- *  Copyright (c) 2002 Vojtech Pavlik
- *  Copyright (c) 1992 Orest Zborowski
- *
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as publishe=
d by
- * the Free Software Foundation
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/input.h>
-#include <asm/io.h>
-
-MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
-MODULE_DESCRIPTION("PC Speaker beeper driver");
-MODULE_LICENSE("GPL");
-
-static char pcspkr_name[] =3D "PC Speaker";
-static char pcspkr_phys[] =3D "isa0061/input0";
-static struct input_dev pcspkr_dev;
-
-spinlock_t i8253_beep_lock =3D SPIN_LOCK_UNLOCKED;
-
-static int pcspkr_event(struct input_dev *dev, unsigned int type, unsigned=
 int code, int value)
-{
-	unsigned int count =3D 0;
-	unsigned long flags;
-
-	if (type !=3D EV_SND)
-		return -1;
-
-	switch (code) {
-		case SND_BELL: if (value) value =3D 1000;
-		case SND_TONE: break;
-		default: return -1;
-	}=20
-
-	if (value > 20 && value < 32767)
-		count =3D 1193182 / value;
-=09
-	spin_lock_irqsave(&i8253_beep_lock, flags);
-
-	if (count) {
-		/* enable counter 2 */
-		outb_p(inb_p(0x61) | 3, 0x61);
-		/* set command for counter 2, 2 byte write */
-		outb_p(0xB6, 0x43);
-		/* select desired HZ */
-		outb_p(count & 0xff, 0x42);
-		outb((count >> 8) & 0xff, 0x42);
-	} else {
-		/* disable counter 2 */
-		outb(inb_p(0x61) & 0xFC, 0x61);
-	}
-
-	spin_unlock_irqrestore(&i8253_beep_lock, flags);
-
-	return 0;
-}
-
-static int __init pcspkr_init(void)
-{
-	pcspkr_dev.evbit[0] =3D BIT(EV_SND);
-	pcspkr_dev.sndbit[0] =3D BIT(SND_BELL) | BIT(SND_TONE);
-	pcspkr_dev.event =3D pcspkr_event;
-
-	pcspkr_dev.name =3D pcspkr_name;
-	pcspkr_dev.phys =3D pcspkr_phys;
-	pcspkr_dev.id.bustype =3D BUS_ISA;
-	pcspkr_dev.id.vendor =3D 0x001f;
-	pcspkr_dev.id.product =3D 0x0001;
-	pcspkr_dev.id.version =3D 0x0100;
-
-	input_register_device(&pcspkr_dev);
-
-        printk(KERN_INFO "input: %s\n", pcspkr_name);
-
-	return 0;
-}
-
-static void __exit pcspkr_exit(void)
-{
-        input_unregister_device(&pcspkr_dev);
-}
-
-module_init(pcspkr_init);
-module_exit(pcspkr_exit);
diff -urN linux-2.5.40/drivers/input/misc/sparcspkr.c linux-2.5.40-new/driv=
ers/input/misc/sparcspkr.c
--- linux-2.5.40/drivers/input/misc/sparcspkr.c	2002-09-17 20:58:55.0000000=
00 -0400
+++ linux-2.5.40-new/drivers/input/misc/sparcspkr.c	1969-12-31 19:00:00.000=
000000 -0500
@@ -1,189 +0,0 @@
-/*
- *  Driver for PC-speaker like devices found on various Sparc systems.
- *
- *  Copyright (c) 2002 Vojtech Pavlik
- *  Copyright (c) 2002 David S. Miller (davem@redhat.com)
- */
-#include <linux/config.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/input.h>
-
-#include <asm/io.h>
-#include <asm/ebus.h>
-#ifdef CONFIG_SPARC64
-#include <asm/isa.h>
-#endif
-
-MODULE_AUTHOR("David S. Miller <davem@redhat.com>");
-MODULE_DESCRIPTION("PC Speaker beeper driver");
-MODULE_LICENSE("GPL");
-
-static unsigned long beep_iobase;
-
-static char *sparcspkr_isa_name =3D "Sparc ISA Speaker";
-static char *sparcspkr_ebus_name =3D "Sparc EBUS Speaker";
-static char *sparcspkr_phys =3D "sparc/input0";
-static struct input_dev sparcspkr_dev;
-
-spinlock_t beep_lock =3D SPIN_LOCK_UNLOCKED;
-
-static void __init init_sparcspkr_struct(void)
-{
-	sparcspkr_dev.evbit[0] =3D BIT(EV_SND);
-	sparcspkr_dev.sndbit[0] =3D BIT(SND_BELL) | BIT(SND_TONE);
-
-	sparcspkr_dev.phys =3D sparcspkr_phys;
-	sparcspkr_dev.id.bustype =3D BUS_ISA;
-	sparcspkr_dev.id.vendor =3D 0x001f;
-	sparcspkr_dev.id.product =3D 0x0001;
-	sparcspkr_dev.id.version =3D 0x0100;
-}
-
-static int ebus_spkr_event(struct input_dev *dev, unsigned int type, unsig=
ned int code, int value)
-{
-	unsigned int count =3D 0;
-	unsigned long flags;
-
-	if (type !=3D EV_SND)
-		return -1;
-
-	switch (code) {
-		case SND_BELL: if (value) value =3D 1000;
-		case SND_TONE: break;
-		default: return -1;
-	}=20
-
-	if (value > 20 && value < 32767)
-		count =3D 1193182 / value;
-=09
-	spin_lock_irqsave(&beep_lock, flags);
-
-	/* EBUS speaker only has on/off state, the frequency does not
-	 * appear to be programmable.
-	 */
-	if (count) {
-		if (beep_iobase & 0x2UL)
-			outb(1, beep_iobase);
-		else
-			outl(1, beep_iobase);
-	} else {
-		if (beep_iobase & 0x2UL)
-			outb(0, beep_iobase);
-		else
-			outl(0, beep_iobase);
-	}
-
-	spin_unlock_irqrestore(&beep_lock, flags);
-
-	return 0;
-}
-
-static int __init init_ebus_beep(struct linux_ebus_device *edev)
-{
-	beep_iobase =3D edev->resource[0].start;
-
-	init_sparcspkr_struct();
-
-	sparcspkr_dev.name =3D sparcspkr_ebus_name;
-	sparcspkr_dev.event =3D ebus_spkr_event;
-
-	input_register_device(&sparcspkr_dev);
-
-        printk(KERN_INFO "input: %s\n", sparcspkr_ebus_name);
-	return 0;
-}
-
-#ifdef CONFIG_SPARC64
-static int isa_spkr_event(struct input_dev *dev, unsigned int type, unsign=
ed int code, int value)
-{
-	unsigned int count =3D 0;
-	unsigned long flags;
-
-	if (type !=3D EV_SND)
-		return -1;
-
-	switch (code) {
-		case SND_BELL: if (value) value =3D 1000;
-		case SND_TONE: break;
-		default: return -1;
-	}=20
-
-	if (value > 20 && value < 32767)
-		count =3D 1193182 / value;
-=09
-	spin_lock_irqsave(&beep_lock, flags);
-
-	if (count) {
-		/* enable counter 2 */
-		outb(inb(beep_iobase + 0x61) | 3, beep_iobase + 0x61);
-		/* set command for counter 2, 2 byte write */
-		outb(0xB6, beep_iobase + 0x43);
-		/* select desired HZ */
-		outb(count & 0xff, beep_iobase + 0x42);
-		outb((count >> 8) & 0xff, beep_iobase + 0x42);
-	} else {
-		/* disable counter 2 */
-		outb(inb_p(beep_iobase + 0x61) & 0xFC, beep_iobase + 0x61);
-	}
-
-	spin_unlock_irqrestore(&beep_lock, flags);
-
-	return 0;
-}
-
-static int __init init_isa_beep(struct isa_device *isa_dev)
-{
-	beep_iobase =3D isa_dev->resource.start;
-
-	init_sparcspkr_struct();
-
-	sparcspkr_dev.name =3D sparcspkr_isa_name;
-	sparcspkr_dev.event =3D isa_spkr_event;
-	sparcspkr_dev.id.bustype =3D BUS_ISA;
-
-	input_register_device(&sparcspkr_dev);
-
-        printk(KERN_INFO "input: %s\n", sparcspkr_isa_name);
-	return 0;
-}
-#endif
-
-static int __init sparcspkr_init(void)
-{
-	struct linux_ebus *ebus;
-	struct linux_ebus_device *edev =3D NULL;
-#ifdef CONFIG_SPARC64
-	struct isa_bridge *isa_br;
-	struct isa_device *isa_dev;
-#endif
-
-	for_each_ebus(ebus) {
-		for_each_ebusdev(edev, ebus) {
-			if (!strcmp(edev->prom_name, "beep"))
-				return init_ebus_beep(edev);
-		}
-	}
-#ifdef CONFIG_SPARC64
-	for_each_isa(isa_br) {
-		for_each_isadev(isa_dev, isa_br) {
-			/* A hack, the beep device's base lives in
-			 * the DMA isa node.
-			 */
-			if (!strcmp(isa_dev->prom_name, "dma"))
-				return init_isa_beep(isa_dev);
-		}
-	}
-#endif
-
-	return -ENODEV;
-}
-
-static void __exit sparcspkr_exit(void)
-{
-	input_unregister_device(&sparcspkr_dev);
-}
-
-module_init(sparcspkr_init);
-module_exit(sparcspkr_exit);
diff -urN linux-2.5.40/drivers/input/speaker/Config.help linux-2.5.40-new/d=
rivers/input/speaker/Config.help
--- linux-2.5.40/drivers/input/speaker/Config.help	1969-12-31 19:00:00.0000=
00000 -0500
+++ linux-2.5.40-new/drivers/input/speaker/Config.help	2002-10-07 16:35:20.=
000000000 -0400
@@ -0,0 +1,29 @@
+CONFIG_INPUT_SPEAKER
+  Say Y here, and a list available PC speaker drivers will be
+  displayed. These are not drivers for soundcards but for the
+  simple PC speaker "beeps". This option doesn't affect the kernel.
+
+  If unsure, say Y.
+
+CONFIG_INPUT_PCSPKR
+  Say Y here if you want the standard PC Speaker to be used for
+  bells and whistles.
+
+  If unsure, say Y.
+
+  This driver is also available as a module ( =3D code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called pcspkr.o. If you want to compile it as a
+  module, say M here and read <file:Documentation/modules.txt>.
+
+CONFIG_INPUT_SPARCSPKR
+  Say Y here if you want the standard Speaker on Sparc PCI systems
+  to be used for bells and whistles.
+
+  If unsure, say Y.
+
+  This driver is also available as a module ( =3D code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called pcspkr.o. If you want to compile it as a
+  module, say M here and read <file:Documentation/modules.txt>.
+
diff -urN linux-2.5.40/drivers/input/speaker/Config.in linux-2.5.40-new/dri=
vers/input/speaker/Config.in
--- linux-2.5.40/drivers/input/speaker/Config.in	1969-12-31 19:00:00.000000=
000 -0500
+++ linux-2.5.40-new/drivers/input/speaker/Config.in	2002-10-07 16:39:57.00=
0000000 -0400
@@ -0,0 +1,11 @@
+#
+# Input misc drivers configuration
+#
+
+bool 'PC speakers' CONFIG_INPUT_SPEAKER
+
+dep_tristate '  PC Speaker support' CONFIG_INPUT_PCSPKR $CONFIG_INPUT $CON=
FIG_INPUT_SPEAKER
+if [ "$CONFIG_SPARC32" =3D "y" -o "$CONFIG_SPARC64" =3D "y" ]; then
+   dep_tristate '  SPARC Speaker support' CONFIG_INPUT_SPARCSPKR $CONFIG_I=
NPUT $CONFIG_INPUT_SPEAKER
+fi
+
diff -urN linux-2.5.40/drivers/input/speaker/Makefile linux-2.5.40-new/driv=
ers/input/speaker/Makefile
--- linux-2.5.40/drivers/input/speaker/Makefile	1969-12-31 19:00:00.0000000=
00 -0500
+++ linux-2.5.40-new/drivers/input/speaker/Makefile	2002-10-07 16:21:28.000=
000000 -0400
@@ -0,0 +1,12 @@
+#
+# Makefile for the input speaker drivers.
+#
+
+# Each configuration option enables a list of files.
+
+obj-$(CONFIG_INPUT_SPARCSPKR)		+=3D sparcspkr.o
+obj-$(CONFIG_INPUT_PCSPKR)		+=3D pcspkr.o
+
+# The global Rules.make.
+
+include $(TOPDIR)/Rules.make
diff -urN linux-2.5.40/drivers/input/speaker/pcspkr.c linux-2.5.40-new/driv=
ers/input/speaker/pcspkr.c
--- linux-2.5.40/drivers/input/speaker/pcspkr.c	1969-12-31 19:00:00.0000000=
00 -0500
+++ linux-2.5.40-new/drivers/input/speaker/pcspkr.c	2002-10-07 16:20:51.000=
000000 -0400
@@ -0,0 +1,94 @@
+/*
+ *  PC Speaker beeper driver for Linux
+ *
+ *  Copyright (c) 2002 Vojtech Pavlik
+ *  Copyright (c) 1992 Orest Zborowski
+ *
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as publishe=
d by
+ * the Free Software Foundation
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <asm/io.h>
+
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
+MODULE_DESCRIPTION("PC Speaker beeper driver");
+MODULE_LICENSE("GPL");
+
+static char pcspkr_name[] =3D "PC Speaker";
+static char pcspkr_phys[] =3D "isa0061/input0";
+static struct input_dev pcspkr_dev;
+
+spinlock_t i8253_beep_lock =3D SPIN_LOCK_UNLOCKED;
+
+static int pcspkr_event(struct input_dev *dev, unsigned int type, unsigned=
 int code, int value)
+{
+	unsigned int count =3D 0;
+	unsigned long flags;
+
+	if (type !=3D EV_SND)
+		return -1;
+
+	switch (code) {
+		case SND_BELL: if (value) value =3D 1000;
+		case SND_TONE: break;
+		default: return -1;
+	}=20
+
+	if (value > 20 && value < 32767)
+		count =3D 1193182 / value;
+=09
+	spin_lock_irqsave(&i8253_beep_lock, flags);
+
+	if (count) {
+		/* enable counter 2 */
+		outb_p(inb_p(0x61) | 3, 0x61);
+		/* set command for counter 2, 2 byte write */
+		outb_p(0xB6, 0x43);
+		/* select desired HZ */
+		outb_p(count & 0xff, 0x42);
+		outb((count >> 8) & 0xff, 0x42);
+	} else {
+		/* disable counter 2 */
+		outb(inb_p(0x61) & 0xFC, 0x61);
+	}
+
+	spin_unlock_irqrestore(&i8253_beep_lock, flags);
+
+	return 0;
+}
+
+static int __init pcspkr_init(void)
+{
+	pcspkr_dev.evbit[0] =3D BIT(EV_SND);
+	pcspkr_dev.sndbit[0] =3D BIT(SND_BELL) | BIT(SND_TONE);
+	pcspkr_dev.event =3D pcspkr_event;
+
+	pcspkr_dev.name =3D pcspkr_name;
+	pcspkr_dev.phys =3D pcspkr_phys;
+	pcspkr_dev.id.bustype =3D BUS_ISA;
+	pcspkr_dev.id.vendor =3D 0x001f;
+	pcspkr_dev.id.product =3D 0x0001;
+	pcspkr_dev.id.version =3D 0x0100;
+
+	input_register_device(&pcspkr_dev);
+
+        printk(KERN_INFO "input: %s\n", pcspkr_name);
+
+	return 0;
+}
+
+static void __exit pcspkr_exit(void)
+{
+        input_unregister_device(&pcspkr_dev);
+}
+
+module_init(pcspkr_init);
+module_exit(pcspkr_exit);
diff -urN linux-2.5.40/drivers/input/speaker/sparcspkr.c linux-2.5.40-new/d=
rivers/input/speaker/sparcspkr.c
--- linux-2.5.40/drivers/input/speaker/sparcspkr.c	1969-12-31 19:00:00.0000=
00000 -0500
+++ linux-2.5.40-new/drivers/input/speaker/sparcspkr.c	2002-10-07 16:20:51.=
000000000 -0400
@@ -0,0 +1,189 @@
+/*
+ *  Driver for PC-speaker like devices found on various Sparc systems.
+ *
+ *  Copyright (c) 2002 Vojtech Pavlik
+ *  Copyright (c) 2002 David S. Miller (davem@redhat.com)
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/input.h>
+
+#include <asm/io.h>
+#include <asm/ebus.h>
+#ifdef CONFIG_SPARC64
+#include <asm/isa.h>
+#endif
+
+MODULE_AUTHOR("David S. Miller <davem@redhat.com>");
+MODULE_DESCRIPTION("PC Speaker beeper driver");
+MODULE_LICENSE("GPL");
+
+static unsigned long beep_iobase;
+
+static char *sparcspkr_isa_name =3D "Sparc ISA Speaker";
+static char *sparcspkr_ebus_name =3D "Sparc EBUS Speaker";
+static char *sparcspkr_phys =3D "sparc/input0";
+static struct input_dev sparcspkr_dev;
+
+spinlock_t beep_lock =3D SPIN_LOCK_UNLOCKED;
+
+static void __init init_sparcspkr_struct(void)
+{
+	sparcspkr_dev.evbit[0] =3D BIT(EV_SND);
+	sparcspkr_dev.sndbit[0] =3D BIT(SND_BELL) | BIT(SND_TONE);
+
+	sparcspkr_dev.phys =3D sparcspkr_phys;
+	sparcspkr_dev.id.bustype =3D BUS_ISA;
+	sparcspkr_dev.id.vendor =3D 0x001f;
+	sparcspkr_dev.id.product =3D 0x0001;
+	sparcspkr_dev.id.version =3D 0x0100;
+}
+
+static int ebus_spkr_event(struct input_dev *dev, unsigned int type, unsig=
ned int code, int value)
+{
+	unsigned int count =3D 0;
+	unsigned long flags;
+
+	if (type !=3D EV_SND)
+		return -1;
+
+	switch (code) {
+		case SND_BELL: if (value) value =3D 1000;
+		case SND_TONE: break;
+		default: return -1;
+	}=20
+
+	if (value > 20 && value < 32767)
+		count =3D 1193182 / value;
+=09
+	spin_lock_irqsave(&beep_lock, flags);
+
+	/* EBUS speaker only has on/off state, the frequency does not
+	 * appear to be programmable.
+	 */
+	if (count) {
+		if (beep_iobase & 0x2UL)
+			outb(1, beep_iobase);
+		else
+			outl(1, beep_iobase);
+	} else {
+		if (beep_iobase & 0x2UL)
+			outb(0, beep_iobase);
+		else
+			outl(0, beep_iobase);
+	}
+
+	spin_unlock_irqrestore(&beep_lock, flags);
+
+	return 0;
+}
+
+static int __init init_ebus_beep(struct linux_ebus_device *edev)
+{
+	beep_iobase =3D edev->resource[0].start;
+
+	init_sparcspkr_struct();
+
+	sparcspkr_dev.name =3D sparcspkr_ebus_name;
+	sparcspkr_dev.event =3D ebus_spkr_event;
+
+	input_register_device(&sparcspkr_dev);
+
+        printk(KERN_INFO "input: %s\n", sparcspkr_ebus_name);
+	return 0;
+}
+
+#ifdef CONFIG_SPARC64
+static int isa_spkr_event(struct input_dev *dev, unsigned int type, unsign=
ed int code, int value)
+{
+	unsigned int count =3D 0;
+	unsigned long flags;
+
+	if (type !=3D EV_SND)
+		return -1;
+
+	switch (code) {
+		case SND_BELL: if (value) value =3D 1000;
+		case SND_TONE: break;
+		default: return -1;
+	}=20
+
+	if (value > 20 && value < 32767)
+		count =3D 1193182 / value;
+=09
+	spin_lock_irqsave(&beep_lock, flags);
+
+	if (count) {
+		/* enable counter 2 */
+		outb(inb(beep_iobase + 0x61) | 3, beep_iobase + 0x61);
+		/* set command for counter 2, 2 byte write */
+		outb(0xB6, beep_iobase + 0x43);
+		/* select desired HZ */
+		outb(count & 0xff, beep_iobase + 0x42);
+		outb((count >> 8) & 0xff, beep_iobase + 0x42);
+	} else {
+		/* disable counter 2 */
+		outb(inb_p(beep_iobase + 0x61) & 0xFC, beep_iobase + 0x61);
+	}
+
+	spin_unlock_irqrestore(&beep_lock, flags);
+
+	return 0;
+}
+
+static int __init init_isa_beep(struct isa_device *isa_dev)
+{
+	beep_iobase =3D isa_dev->resource.start;
+
+	init_sparcspkr_struct();
+
+	sparcspkr_dev.name =3D sparcspkr_isa_name;
+	sparcspkr_dev.event =3D isa_spkr_event;
+	sparcspkr_dev.id.bustype =3D BUS_ISA;
+
+	input_register_device(&sparcspkr_dev);
+
+        printk(KERN_INFO "input: %s\n", sparcspkr_isa_name);
+	return 0;
+}
+#endif
+
+static int __init sparcspkr_init(void)
+{
+	struct linux_ebus *ebus;
+	struct linux_ebus_device *edev =3D NULL;
+#ifdef CONFIG_SPARC64
+	struct isa_bridge *isa_br;
+	struct isa_device *isa_dev;
+#endif
+
+	for_each_ebus(ebus) {
+		for_each_ebusdev(edev, ebus) {
+			if (!strcmp(edev->prom_name, "beep"))
+				return init_ebus_beep(edev);
+		}
+	}
+#ifdef CONFIG_SPARC64
+	for_each_isa(isa_br) {
+		for_each_isadev(isa_dev, isa_br) {
+			/* A hack, the beep device's base lives in
+			 * the DMA isa node.
+			 */
+			if (!strcmp(isa_dev->prom_name, "dma"))
+				return init_isa_beep(isa_dev);
+		}
+	}
+#endif
+
+	return -ENODEV;
+}
+
+static void __exit sparcspkr_exit(void)
+{
+	input_unregister_device(&sparcspkr_dev);
+}
+
+module_init(sparcspkr_init);
+module_exit(sparcspkr_exit);

--u3/rZRmxL6MmkK24--

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9oWGaWv4KsgKfSVgRAu5oAKCfdQPGR6g24qsUz6TOPHLxvYDP0wCfUMQ0
ZIQlGUgc7yrX8zaKwCOpGPY=
=pfmq
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
