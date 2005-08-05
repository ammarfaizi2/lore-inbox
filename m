Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262518AbVHEPDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbVHEPDL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbVHEOxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:53:51 -0400
Received: from fep16.inet.fi ([194.251.242.241]:10383 "EHLO fep16.inet.fi")
	by vger.kernel.org with ESMTP id S262256AbVHEOvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:51:07 -0400
Subject: [PATCH 3/8] input: convert kcalloc to kzalloc
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <ikr7j4.hxsbqg.dfp7ughpn3jgy3088i6y0e84l.beaver@cs.helsinki.fi>
In-Reply-To: <ikr7iw.uglatv.4r37ksk0wcjz57bhrrhj6ed0q.beaver@cs.helsinki.fi>
Date: Fri, 5 Aug 2005 17:51:06 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts kcalloc(1, ...) calls to use the new kzalloc() function.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 gameport/emu10k1-gp.c |    2 +-
 gameport/fm801-gp.c   |    2 +-
 gameport/ns558.c      |    4 ++--
 joystick/a3d.c        |    2 +-
 joystick/adi.c        |    2 +-
 joystick/analog.c     |    2 +-
 joystick/cobra.c      |    2 +-
 joystick/db9.c        |    2 +-
 joystick/gamecon.c    |    2 +-
 joystick/gf2k.c       |    2 +-
 joystick/grip.c       |    2 +-
 joystick/grip_mp.c    |    2 +-
 joystick/guillemot.c  |    2 +-
 joystick/interact.c   |    2 +-
 joystick/sidewinder.c |    2 +-
 joystick/tmdc.c       |    2 +-
 joystick/turbografx.c |    2 +-
 keyboard/corgikbd.c   |    2 +-
 mouse/psmouse-base.c  |    2 +-
 serio/serport.c       |    4 ++--
 20 files changed, 22 insertions(+), 22 deletions(-)

Index: 2.6/drivers/input/gameport/emu10k1-gp.c
===================================================================
--- 2.6.orig/drivers/input/gameport/emu10k1-gp.c
+++ 2.6/drivers/input/gameport/emu10k1-gp.c
@@ -75,7 +75,7 @@ static int __devinit emu_probe(struct pc
 	if (!request_region(ioport, iolen, "emu10k1-gp"))
 		return -EBUSY;
 
-	emu = kcalloc(1, sizeof(struct emu), GFP_KERNEL);
+	emu = kzalloc(sizeof(struct emu), GFP_KERNEL);
 	port = gameport_allocate_port();
 	if (!emu || !port) {
 		printk(KERN_ERR "emu10k1-gp: Memory allocation failed\n");
Index: 2.6/drivers/input/gameport/fm801-gp.c
===================================================================
--- 2.6.orig/drivers/input/gameport/fm801-gp.c
+++ 2.6/drivers/input/gameport/fm801-gp.c
@@ -83,7 +83,7 @@ static int __devinit fm801_gp_probe(stru
 	struct fm801_gp *gp;
 	struct gameport *port;
 
-	gp = kcalloc(1, sizeof(struct fm801_gp), GFP_KERNEL);
+	gp = kzalloc(sizeof(struct fm801_gp), GFP_KERNEL);
 	port = gameport_allocate_port();
 	if (!gp || !port) {
 		printk(KERN_ERR "fm801-gp: Memory allocation failed\n");
Index: 2.6/drivers/input/gameport/ns558.c
===================================================================
--- 2.6.orig/drivers/input/gameport/ns558.c
+++ 2.6/drivers/input/gameport/ns558.c
@@ -142,7 +142,7 @@ static int ns558_isa_probe(int io)
 			return -EBUSY;
 	}
 
-	ns558 = kcalloc(1, sizeof(struct ns558), GFP_KERNEL);
+	ns558 = kzalloc(sizeof(struct ns558), GFP_KERNEL);
 	port = gameport_allocate_port();
 	if (!ns558 || !port) {
 		printk(KERN_ERR "ns558: Memory allocation failed.\n");
@@ -215,7 +215,7 @@ static int ns558_pnp_probe(struct pnp_de
 	if (!request_region(ioport, iolen, "ns558-pnp"))
 		return -EBUSY;
 
-	ns558 = kcalloc(1, sizeof(struct ns558), GFP_KERNEL);
+	ns558 = kzalloc(sizeof(struct ns558), GFP_KERNEL);
 	port = gameport_allocate_port();
 	if (!ns558 || !port) {
 		printk(KERN_ERR "ns558: Memory allocation failed\n");
Index: 2.6/drivers/input/joystick/a3d.c
===================================================================
--- 2.6.orig/drivers/input/joystick/a3d.c
+++ 2.6/drivers/input/joystick/a3d.c
@@ -269,7 +269,7 @@ static int a3d_connect(struct gameport *
 	int i;
 	int err;
 
-	if (!(a3d = kcalloc(1, sizeof(struct a3d), GFP_KERNEL)))
+	if (!(a3d = kzalloc(sizeof(struct a3d), GFP_KERNEL)))
 		return -ENOMEM;
 
 	a3d->gameport = gameport;
Index: 2.6/drivers/input/joystick/adi.c
===================================================================
--- 2.6.orig/drivers/input/joystick/adi.c
+++ 2.6/drivers/input/joystick/adi.c
@@ -469,7 +469,7 @@ static int adi_connect(struct gameport *
 	int i;
 	int err;
 
-	if (!(port = kcalloc(1, sizeof(struct adi_port), GFP_KERNEL)))
+	if (!(port = kzalloc(sizeof(struct adi_port), GFP_KERNEL)))
 		return -ENOMEM;
 
 	port->gameport = gameport;
Index: 2.6/drivers/input/joystick/analog.c
===================================================================
--- 2.6.orig/drivers/input/joystick/analog.c
+++ 2.6/drivers/input/joystick/analog.c
@@ -655,7 +655,7 @@ static int analog_connect(struct gamepor
 	int i;
 	int err;
 
-	if (!(port = kcalloc(1, sizeof(struct analog_port), GFP_KERNEL)))
+	if (!(port = kzalloc(sizeof(struct analog_port), GFP_KERNEL)))
 		return - ENOMEM;
 
 	err = analog_init_port(gameport, drv, port);
Index: 2.6/drivers/input/joystick/cobra.c
===================================================================
--- 2.6.orig/drivers/input/joystick/cobra.c
+++ 2.6/drivers/input/joystick/cobra.c
@@ -163,7 +163,7 @@ static int cobra_connect(struct gameport
 	int i, j;
 	int err;
 
-	if (!(cobra = kcalloc(1, sizeof(struct cobra), GFP_KERNEL)))
+	if (!(cobra = kzalloc(sizeof(struct cobra), GFP_KERNEL)))
 		return -ENOMEM;
 
 	cobra->gameport = gameport;
Index: 2.6/drivers/input/joystick/db9.c
===================================================================
--- 2.6.orig/drivers/input/joystick/db9.c
+++ 2.6/drivers/input/joystick/db9.c
@@ -572,7 +572,7 @@ static struct db9 __init *db9_probe(int 
 		}
 	}
 
-	if (!(db9 = kcalloc(1, sizeof(struct db9), GFP_KERNEL))) {
+	if (!(db9 = kzalloc(sizeof(struct db9), GFP_KERNEL))) {
 		parport_put_port(pp);
 		return NULL;
 	}
Index: 2.6/drivers/input/joystick/gamecon.c
===================================================================
--- 2.6.orig/drivers/input/joystick/gamecon.c
+++ 2.6/drivers/input/joystick/gamecon.c
@@ -554,7 +554,7 @@ static struct gc __init *gc_probe(int *c
 		return NULL;
 	}
 
-	if (!(gc = kcalloc(1, sizeof(struct gc), GFP_KERNEL))) {
+	if (!(gc = kzalloc(sizeof(struct gc), GFP_KERNEL))) {
 		parport_put_port(pp);
 		return NULL;
 	}
Index: 2.6/drivers/input/joystick/gf2k.c
===================================================================
--- 2.6.orig/drivers/input/joystick/gf2k.c
+++ 2.6/drivers/input/joystick/gf2k.c
@@ -242,7 +242,7 @@ static int gf2k_connect(struct gameport 
 	unsigned char data[GF2K_LENGTH];
 	int i, err;
 
-	if (!(gf2k = kcalloc(1, sizeof(struct gf2k), GFP_KERNEL)))
+	if (!(gf2k = kzalloc(sizeof(struct gf2k), GFP_KERNEL)))
 		return -ENOMEM;
 
 	gf2k->gameport = gameport;
Index: 2.6/drivers/input/joystick/grip.c
===================================================================
--- 2.6.orig/drivers/input/joystick/grip.c
+++ 2.6/drivers/input/joystick/grip.c
@@ -301,7 +301,7 @@ static int grip_connect(struct gameport 
 	int i, j, t;
 	int err;
 
-	if (!(grip = kcalloc(1, sizeof(struct grip), GFP_KERNEL)))
+	if (!(grip = kzalloc(sizeof(struct grip), GFP_KERNEL)))
 		return -ENOMEM;
 
 	grip->gameport = gameport;
Index: 2.6/drivers/input/joystick/grip_mp.c
===================================================================
--- 2.6.orig/drivers/input/joystick/grip_mp.c
+++ 2.6/drivers/input/joystick/grip_mp.c
@@ -607,7 +607,7 @@ static int grip_connect(struct gameport 
 	struct grip_mp *grip;
 	int err;
 
-	if (!(grip = kcalloc(1, sizeof(struct grip_mp), GFP_KERNEL)))
+	if (!(grip = kzalloc(sizeof(struct grip_mp), GFP_KERNEL)))
 		return -ENOMEM;
 
 	grip->gameport = gameport;
Index: 2.6/drivers/input/joystick/guillemot.c
===================================================================
--- 2.6.orig/drivers/input/joystick/guillemot.c
+++ 2.6/drivers/input/joystick/guillemot.c
@@ -183,7 +183,7 @@ static int guillemot_connect(struct game
 	int i, t;
 	int err;
 
-	if (!(guillemot = kcalloc(1, sizeof(struct guillemot), GFP_KERNEL)))
+	if (!(guillemot = kzalloc(sizeof(struct guillemot), GFP_KERNEL)))
 		return -ENOMEM;
 
 	guillemot->gameport = gameport;
Index: 2.6/drivers/input/joystick/interact.c
===================================================================
--- 2.6.orig/drivers/input/joystick/interact.c
+++ 2.6/drivers/input/joystick/interact.c
@@ -212,7 +212,7 @@ static int interact_connect(struct gamep
 	int i, t;
 	int err;
 
-	if (!(interact = kcalloc(1, sizeof(struct interact), GFP_KERNEL)))
+	if (!(interact = kzalloc(sizeof(struct interact), GFP_KERNEL)))
 		return -ENOMEM;
 
 	interact->gameport = gameport;
Index: 2.6/drivers/input/joystick/sidewinder.c
===================================================================
--- 2.6.orig/drivers/input/joystick/sidewinder.c
+++ 2.6/drivers/input/joystick/sidewinder.c
@@ -590,7 +590,7 @@ static int sw_connect(struct gameport *g
 
 	comment[0] = 0;
 
-	sw = kcalloc(1, sizeof(struct sw), GFP_KERNEL);
+	sw = kzalloc(sizeof(struct sw), GFP_KERNEL);
 	buf = kmalloc(SW_LENGTH, GFP_KERNEL);
 	idbuf = kmalloc(SW_LENGTH, GFP_KERNEL);
 	if (!sw || !buf || !idbuf) {
Index: 2.6/drivers/input/joystick/tmdc.c
===================================================================
--- 2.6.orig/drivers/input/joystick/tmdc.c
+++ 2.6/drivers/input/joystick/tmdc.c
@@ -262,7 +262,7 @@ static int tmdc_connect(struct gameport 
 	int i, j, k, l, m;
 	int err;
 
-	if (!(tmdc = kcalloc(1, sizeof(struct tmdc), GFP_KERNEL)))
+	if (!(tmdc = kzalloc(sizeof(struct tmdc), GFP_KERNEL)))
 		return -ENOMEM;
 
 	tmdc->gameport = gameport;
Index: 2.6/drivers/input/joystick/turbografx.c
===================================================================
--- 2.6.orig/drivers/input/joystick/turbografx.c
+++ 2.6/drivers/input/joystick/turbografx.c
@@ -178,7 +178,7 @@ static struct tgfx __init *tgfx_probe(in
 		return NULL;
 	}
 
-	if (!(tgfx = kcalloc(1, sizeof(struct tgfx), GFP_KERNEL))) {
+	if (!(tgfx = kzalloc(sizeof(struct tgfx), GFP_KERNEL))) {
 		parport_put_port(pp);
 		return NULL;
 	}
Index: 2.6/drivers/input/keyboard/corgikbd.c
===================================================================
--- 2.6.orig/drivers/input/keyboard/corgikbd.c
+++ 2.6/drivers/input/keyboard/corgikbd.c
@@ -260,7 +260,7 @@ static int __init corgikbd_probe(struct 
 	int i;
 	struct corgikbd *corgikbd;
 
-	corgikbd = kcalloc(1, sizeof(struct corgikbd), GFP_KERNEL);
+	corgikbd = kzalloc(sizeof(struct corgikbd), GFP_KERNEL);
 	if (!corgikbd)
 		return -ENOMEM;
 
Index: 2.6/drivers/input/mouse/psmouse-base.c
===================================================================
--- 2.6.orig/drivers/input/mouse/psmouse-base.c
+++ 2.6/drivers/input/mouse/psmouse-base.c
@@ -883,7 +883,7 @@ static int psmouse_connect(struct serio 
 		psmouse_deactivate(parent);
 	}
 
-	if (!(psmouse = kcalloc(1, sizeof(struct psmouse), GFP_KERNEL))) {
+	if (!(psmouse = kzalloc(sizeof(struct psmouse), GFP_KERNEL))) {
 		retval = -ENOMEM;
 		goto out;
 	}
Index: 2.6/drivers/input/serio/serport.c
===================================================================
--- 2.6.orig/drivers/input/serio/serport.c
+++ 2.6/drivers/input/serio/serport.c
@@ -87,7 +87,7 @@ static int serport_ldisc_open(struct tty
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	serport = kcalloc(1, sizeof(struct serport), GFP_KERNEL);
+	serport = kzalloc(sizeof(struct serport), GFP_KERNEL);
 	if (!serport)
 		return -ENOMEM;
 
@@ -165,7 +165,7 @@ static ssize_t serport_ldisc_read(struct
 	if (test_and_set_bit(SERPORT_BUSY, &serport->flags))
 		return -EBUSY;
 
-	serport->serio = serio = kcalloc(1, sizeof(struct serio), GFP_KERNEL);
+	serport->serio = serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (!serio)
 		return -ENOMEM;
 
