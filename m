Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVAXOXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVAXOXw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 09:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVAXOXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 09:23:52 -0500
Received: from dea.vocord.ru ([217.67.177.50]:44449 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261516AbVAXOXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 09:23:40 -0500
Subject: [1/1] superio: remove unneded exports and make some functions
	static.
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Andrew Morton <akpm@osdl.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1106574971.25992.27.camel@uganda>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <20050124122541.GG3515@stusta.de>  <20050124123448.GA29631@infradead.org>
	 <1106571899.25992.21.camel@uganda>  <1106574971.25992.27.camel@uganda>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eDEsy39PetHFBxAFHlVM"
Organization: MIPT
Date: Mon, 24 Jan 2005 17:14:04 +0300
Message-Id: <1106576044.25992.30.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Mon, 24 Jan 2005 14:08:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eDEsy39PetHFBxAFHlVM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Remove unneded exports and make some functions static.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

diff -ru linux-2.6/drivers/superio.orig/sc_acb.c
linux-2.6/drivers/superio/sc_acb.c
--- linux-2.6/drivers/superio.orig/sc_acb.c	2005-01-24
17:07:28.295779728 +0300
+++ linux-2.6/drivers/superio/sc_acb.c	2005-01-24 17:09:35.377460376
+0300
@@ -29,10 +29,10 @@
 #include "sc.h"
 #include "sc_acb.h"
=20
-int sc_acb_activate(void *data);
-u8 sc_acb_read(void *data, int reg);
-void sc_acb_write(void *data, int reg, u8 byte);
-void sc_acb_control(void *data, int pin, u8 mask, u8 ctl);
+static int sc_acb_activate(void *data);
+static u8 sc_acb_read(void *data, int reg);
+static void sc_acb_write(void *data, int reg, u8 byte);
+static void sc_acb_control(void *data, int pin, u8 mask, u8 ctl);
=20
 static struct logical_dev ldev_acb =3D {
 	.name =3D "ACB",
@@ -48,13 +48,13 @@
 	.orig_ldev =3D NULL,
 };
=20
-void sc_write_reg(struct sc_dev *dev, u8 reg, u8 val)
+static void sc_write_reg(struct sc_dev *dev, u8 reg, u8 val)
 {
 	outb(reg, dev->base_index);
 	outb(val, dev->base_data);
 }
=20
-u8 sc_read_reg(struct sc_dev *dev, u8 reg)
+static u8 sc_read_reg(struct sc_dev *dev, u8 reg)
 {
 	u8 val;
=20
@@ -64,7 +64,7 @@
 	return val;
 }
=20
-int sc_acb_activate(void *data)
+static int sc_acb_activate(void *data)
 {
 	struct logical_dev *ldev =3D (struct logical_dev *)data;
 	u8 val;
@@ -111,7 +111,7 @@
 	return 0;
 }
=20
-u8 sc_acb_read(void *data, int reg)
+static u8 sc_acb_read(void *data, int reg)
 {
 	struct logical_dev *ldev =3D (struct logical_dev *)data;
 	u8 val;
@@ -123,7 +123,7 @@
 	return val;
 }
=20
-void sc_acb_write(void *data, int reg, u8 byte)
+static void sc_acb_write(void *data, int reg, u8 byte)
 {
 	struct logical_dev *ldev =3D (struct logical_dev *)data;
=20
@@ -132,7 +132,7 @@
 	outb(byte, ldev->base_addr + reg);
 }
=20
-void sc_acb_control(void *data, int pin, u8 mask, u8 ctl)
+static void sc_acb_control(void *data, int pin, u8 mask, u8 ctl)
 {
 }
=20
@@ -156,8 +156,3 @@
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
 MODULE_DESCRIPTION("Driver for Access Bus logical device.");
-
-EXPORT_SYMBOL(sc_acb_activate);
-EXPORT_SYMBOL(sc_acb_read);
-EXPORT_SYMBOL(sc_acb_write);
-EXPORT_SYMBOL(sc_acb_control);
diff -ru linux-2.6/drivers/superio.orig/sc_gpio.c
linux-2.6/drivers/superio/sc_gpio.c
--- linux-2.6/drivers/superio.orig/sc_gpio.c	2005-01-24
17:07:28.305778208 +0300
+++ linux-2.6/drivers/superio/sc_gpio.c	2005-01-24 17:10:44.808905192
+0300
@@ -31,6 +31,14 @@
=20
 static struct gpio_pin gpin[SIO_GPIO_NPINS];
=20
+static int sc_gpio_activate(void *);
+static u8 sc_gpio_read(void *, int);
+static void sc_gpio_write(void *, int, u8);
+static void sc_gpio_control(void *, int, u8, u8);
+static void sc_gpio_pin_select(void *, int);
+static irqreturn_t sc_gpio_interrupt(int, void *, struct pt_regs *);
+
+
 static struct logical_dev ldev_gpio =3D {
 	.name =3D "GPIO",
 	.index =3D SIO_LDN_GPIO,
@@ -50,13 +58,13 @@
=20
 static void sc_gpio_write_event(void *data, int pin_number, u8 byte);
=20
-void sc_write_reg(struct sc_dev *dev, u8 reg, u8 val)
+static void sc_write_reg(struct sc_dev *dev, u8 reg, u8 val)
 {
 	outb(reg, dev->base_index);
 	outb(val, dev->base_data);
 }
=20
-u8 sc_read_reg(struct sc_dev *dev, u8 reg)
+static u8 sc_read_reg(struct sc_dev *dev, u8 reg)
 {
 	u8 val;
=20
@@ -66,7 +74,7 @@
 	return val;
 }
=20
-irqreturn_t sc_gpio_interrupt(int irq, void *data, struct pt_regs *
regs)
+static irqreturn_t sc_gpio_interrupt(int irq, void *data, struct
pt_regs * regs)
 {
 	struct logical_dev *ldev =3D (struct logical_dev *)data;
 	static u8 r[4], e[2], s[2];
@@ -122,7 +130,7 @@
 }
=20
=20
-void sc_gpio_pin_select(void *data, int pin_number)
+static void sc_gpio_pin_select(void *data, int pin_number)
 {
 	struct logical_dev *ldev =3D (struct logical_dev *)data;
 	int port, pin;
@@ -136,7 +144,7 @@
 	sc_write_reg(ldev->pdev, SIO_GPIO_PINSEL, val);
 }
=20
-int sc_gpio_activate(void *data)
+static int sc_gpio_activate(void *data)
 {
 	struct logical_dev *ldev =3D (struct logical_dev *)data;
 	int i;
@@ -161,7 +169,7 @@
 	return 0;
 }
=20
-u8 sc_gpio_read(void *data, int pin_number)
+static u8 sc_gpio_read(void *data, int pin_number)
 {
 	struct logical_dev *ldev =3D (struct logical_dev *)data;
 	int port, pin;
@@ -222,7 +230,7 @@
 	outb(1<<pin, ldev->base_addr + reg+1);
 }
=20
-void sc_gpio_write(void *data, int pin_number, u8 byte)
+static void sc_gpio_write(void *data, int pin_number, u8 byte)
 {
 	struct logical_dev *ldev =3D (struct logical_dev *)data;
 	int port, pin;
@@ -263,7 +271,7 @@
 	outb(val, ldev->base_addr + reg);
 }
=20
-void sc_gpio_control(void *data, int pin, u8 mask, u8 ctl)
+static void sc_gpio_control(void *data, int pin, u8 mask, u8 ctl)
 {
 	struct logical_dev *ldev =3D (struct logical_dev *)data;
 	u8 cfg, ev;
@@ -302,9 +310,3 @@
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
 MODULE_DESCRIPTION("Driver for GPIO logical device.");
-
-EXPORT_SYMBOL(sc_gpio_activate);
-EXPORT_SYMBOL(sc_gpio_read);
-EXPORT_SYMBOL(sc_gpio_write);
-EXPORT_SYMBOL(sc_gpio_control);
-EXPORT_SYMBOL(sc_gpio_pin_select);
diff -ru linux-2.6/drivers/superio.orig/sc_gpio.h
linux-2.6/drivers/superio/sc_gpio.h
--- linux-2.6/drivers/superio.orig/sc_gpio.h	2005-01-24
17:07:28.305778208 +0300
+++ linux-2.6/drivers/superio/sc_gpio.h	2005-01-24 17:10:26.750650464
+0300
@@ -40,13 +40,6 @@
 #define SIO_GPIO_CONF_EVENT_POLAR_RIS	(1 << 5)
 #define SIO_GPIO_CONF_DEBOUNCE		(1 << 6)
=20
-int sc_gpio_activate(void *);
-u8 sc_gpio_read(void *, int);
-void sc_gpio_write(void *, int, u8);
-void sc_gpio_control(void *, int, u8, u8);
-void sc_gpio_pin_select(void *, int);
-irqreturn_t sc_gpio_interrupt(int, void *, struct pt_regs *);
-
 struct gpio_pin
 {
 	u8			state;


--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-eDEsy39PetHFBxAFHlVM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB9QKsIKTPhE+8wY0RApgnAJ4oUnaZM+UJNZKVIX31L3eNZ5YsHQCfZjMX
as5BXkVXyra8wn4ZfKIk2BE=
=7Ml5
-----END PGP SIGNATURE-----

--=-eDEsy39PetHFBxAFHlVM--

