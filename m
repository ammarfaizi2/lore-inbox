Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262444AbUKXHou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbUKXHou (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 02:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbUKXHno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 02:43:44 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:35186 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262523AbUKXHlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 02:41:39 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 9/11] gameport renames part 1
Date: Wed, 24 Nov 2004 02:11:18 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200411240205.10502.dtor_core@ameritech.net> <200411240210.21043.dtor_core@ameritech.net> <200411240210.49162.dtor_core@ameritech.net>
In-Reply-To: <200411240210.49162.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411240211.20241.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1964, 2004-11-24 01:20:17-05:00, dtor_core@ameritech.net
  Input: rename gameport->driver to gameport->port_data in preparation
         to sysfs integration.
    
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/gameport/lightning.c |    8 ++++----
 drivers/input/gameport/vortex.c    |   10 +++++-----
 drivers/input/joystick/a3d.c       |    8 ++++----
 include/linux/gameport.h           |    4 ++--
 sound/oss/trident.c                |   10 +++++-----
 sound/pci/au88x0/au88x0_game.c     |   15 +++++++--------
 6 files changed, 27 insertions(+), 28 deletions(-)


===================================================================



diff -Nru a/drivers/input/gameport/lightning.c b/drivers/input/gameport/lightning.c
--- a/drivers/input/gameport/lightning.c	2004-11-24 01:55:49 -05:00
+++ b/drivers/input/gameport/lightning.c	2004-11-24 01:55:49 -05:00
@@ -79,7 +79,7 @@
 
 static int l4_cooked_read(struct gameport *gameport, int *axes, int *buttons)
 {
-	struct l4 *l4 = gameport->driver;
+	struct l4 *l4 = gameport->port_data;
 	unsigned char status;
 	int i, result = -1;
 
@@ -112,7 +112,7 @@
 
 static int l4_open(struct gameport *gameport, int mode)
 {
-	struct l4 *l4 = gameport->driver;
+	struct l4 *l4 = gameport->port_data;
         if (l4->port != 0 && mode != GAMEPORT_MODE_COOKED)
 		return -1;
 	outb(L4_SELECT_ANALOG, L4_PORT);
@@ -190,7 +190,7 @@
 {
 	int i, t;
 	int cal[4];
-	struct l4 *l4 = gameport->driver;
+	struct l4 *l4 = gameport->port_data;
 
 	if (l4_getcal(l4->port, cal))
 		return -1;
@@ -252,7 +252,7 @@
 			sprintf(l4->phys, "isa%04x/gameport%d", L4_PORT, 4 * i + j);
 
 			gameport = &l4->gameport;
-			gameport->driver = l4;
+			gameport->port_data = l4;
 			gameport->open = l4_open;
 			gameport->cooked_read = l4_cooked_read;
 			gameport->calibrate = l4_calibrate;
diff -Nru a/drivers/input/gameport/vortex.c b/drivers/input/gameport/vortex.c
--- a/drivers/input/gameport/vortex.c	2004-11-24 01:55:49 -05:00
+++ b/drivers/input/gameport/vortex.c	2004-11-24 01:55:49 -05:00
@@ -62,19 +62,19 @@
 
 static unsigned char vortex_read(struct gameport *gameport)
 {
-	struct vortex *vortex = gameport->driver;
+	struct vortex *vortex = gameport->port_data;
 	return readb(vortex->io + VORTEX_LEG);
 }
 
 static void vortex_trigger(struct gameport *gameport)
 {
-	struct vortex *vortex = gameport->driver;
+	struct vortex *vortex = gameport->port_data;
 	writeb(0xff, vortex->io + VORTEX_LEG);
 }
 
 static int vortex_cooked_read(struct gameport *gameport, int *axes, int *buttons)
 {
-	struct vortex *vortex = gameport->driver;
+	struct vortex *vortex = gameport->port_data;
 	int i;
 
 	*buttons = (~readb(vortex->base + VORTEX_LEG) >> 4) & 0xf;
@@ -89,7 +89,7 @@
 
 static int vortex_open(struct gameport *gameport, int mode)
 {
-	struct vortex *vortex = gameport->driver;
+	struct vortex *vortex = gameport->port_data;
 
 	switch (mode) {
 		case GAMEPORT_MODE_COOKED:
@@ -120,7 +120,7 @@
 
 	pci_set_drvdata(dev, vortex);
 
-	vortex->gameport.driver = vortex;
+	vortex->gameport.port_data = vortex;
 	vortex->gameport.fuzz = 64;
 
 	vortex->gameport.read = vortex_read;
diff -Nru a/drivers/input/joystick/a3d.c b/drivers/input/joystick/a3d.c
--- a/drivers/input/joystick/a3d.c	2004-11-24 01:55:49 -05:00
+++ b/drivers/input/joystick/a3d.c	2004-11-24 01:55:49 -05:00
@@ -197,7 +197,7 @@
 
 int a3d_adc_cooked_read(struct gameport *gameport, int *axes, int *buttons)
 {
-	struct a3d *a3d = gameport->driver;
+	struct a3d *a3d = gameport->port_data;
 	int i;
 	for (i = 0; i < 4; i++)
 		axes[i] = (a3d->axes[i] < 254) ? a3d->axes[i] : -1;
@@ -212,7 +212,7 @@
 
 int a3d_adc_open(struct gameport *gameport, int mode)
 {
-	struct a3d *a3d = gameport->driver;
+	struct a3d *a3d = gameport->port_data;
 	if (mode != GAMEPORT_MODE_COOKED)
 		return -1;
 	if (!a3d->used++)
@@ -226,7 +226,7 @@
 
 static void a3d_adc_close(struct gameport *gameport)
 {
-	struct a3d *a3d = gameport->driver;
+	struct a3d *a3d = gameport->port_data;
 	if (!--a3d->used)
 		del_timer(&a3d->timer);
 }
@@ -336,7 +336,7 @@
 		a3d->dev.relbit[0] |= BIT(REL_X) | BIT(REL_Y);
 		a3d->dev.keybit[LONG(BTN_MOUSE)] |= BIT(BTN_RIGHT) | BIT(BTN_LEFT) | BIT(BTN_MIDDLE);
 
-		a3d->adc.driver = a3d;
+		a3d->adc.port_data = a3d;
 		a3d->adc.open = a3d_adc_open;
 		a3d->adc.close = a3d_adc_close;
 		a3d->adc.cooked_read = a3d_adc_cooked_read;
diff -Nru a/include/linux/gameport.h b/include/linux/gameport.h
--- a/include/linux/gameport.h	2004-11-24 01:55:49 -05:00
+++ b/include/linux/gameport.h	2004-11-24 01:55:49 -05:00
@@ -17,8 +17,8 @@
 
 struct gameport {
 
-	void *private;	/* Private pointer for joystick drivers */
-	void *driver;	/* Private pointer for gameport drivers */
+	void *private;		/* Private pointer for joystick drivers */
+	void *port_data;	/* Private pointer for gameport drivers */
 	char *name;
 	char *phys;
 
diff -Nru a/sound/oss/trident.c b/sound/oss/trident.c
--- a/sound/oss/trident.c	2004-11-24 01:55:49 -05:00
+++ b/sound/oss/trident.c	2004-11-24 01:55:49 -05:00
@@ -4256,21 +4256,21 @@
 static unsigned char
 trident_game_read(struct gameport *gameport)
 {
-	struct trident_card *card = gameport->driver;
+	struct trident_card *card = gameport->port_data;
 	return inb(TRID_REG(card, T4D_GAME_LEG));
 }
 
 static void
 trident_game_trigger(struct gameport *gameport)
 {
-	struct trident_card *card = gameport->driver;
+	struct trident_card *card = gameport->port_data;
 	outb(0xff, TRID_REG(card, T4D_GAME_LEG));
 }
 
 static int
 trident_game_cooked_read(struct gameport *gameport, int *axes, int *buttons)
 {
-	struct trident_card *card = gameport->driver;
+	struct trident_card *card = gameport->port_data;
 	int i;
 
 	*buttons = (~inb(TRID_REG(card, T4D_GAME_LEG)) >> 4) & 0xf;
@@ -4287,7 +4287,7 @@
 static int
 trident_game_open(struct gameport *gameport, int mode)
 {
-	struct trident_card *card = gameport->driver;
+	struct trident_card *card = gameport->port_data;
 
 	switch (mode) {
 	case GAMEPORT_MODE_COOKED:
@@ -4367,7 +4367,7 @@
 	card->banks[BANK_B].addresses = &bank_b_addrs;
 	card->banks[BANK_B].bitmap = 0UL;
 
-	card->gameport.driver = card;
+	card->gameport.port_data = card;
 	card->gameport.fuzz = 64;
 	card->gameport.read = trident_game_read;
 	card->gameport.trigger = trident_game_trigger;
diff -Nru a/sound/pci/au88x0/au88x0_game.c b/sound/pci/au88x0/au88x0_game.c
--- a/sound/pci/au88x0/au88x0_game.c	2004-11-24 01:55:49 -05:00
+++ b/sound/pci/au88x0/au88x0_game.c	2004-11-24 01:55:49 -05:00
@@ -44,20 +44,20 @@
 
 static unsigned char vortex_game_read(struct gameport *gameport)
 {
-	vortex_t *vortex = gameport->driver;
+	vortex_t *vortex = gameport->port_data;
 	return hwread(vortex->mmio, VORTEX_GAME_LEGACY);
 }
 
 static void vortex_game_trigger(struct gameport *gameport)
 {
-	vortex_t *vortex = gameport->driver;
+	vortex_t *vortex = gameport->port_data;
 	hwwrite(vortex->mmio, VORTEX_GAME_LEGACY, 0xff);
 }
 
 static int
 vortex_game_cooked_read(struct gameport *gameport, int *axes, int *buttons)
 {
-	vortex_t *vortex = gameport->driver;
+	vortex_t *vortex = gameport->port_data;
 	int i;
 
 	*buttons = (~hwread(vortex->mmio, VORTEX_GAME_LEGACY) >> 4) & 0xf;
@@ -73,7 +73,7 @@
 
 static int vortex_game_open(struct gameport *gameport, int mode)
 {
-	vortex_t *vortex = gameport->driver;
+	vortex_t *vortex = gameport->port_data;
 
 	switch (mode) {
 	case GAMEPORT_MODE_COOKED:
@@ -96,11 +96,10 @@
 
 static int vortex_gameport_register(vortex_t * vortex)
 {
-	if ((vortex->gameport = kcalloc(1, sizeof(struct gameport), GFP_KERNEL)) == NULL) {
+	if ((vortex->gameport = kcalloc(1, sizeof(struct gameport), GFP_KERNEL)) == NULL)
 		return -1;
-	};
-	
-	vortex->gameport->driver = vortex;
+
+	vortex->gameport->port_data = vortex;
 	vortex->gameport->fuzz = 64;
 
 	vortex->gameport->read = vortex_game_read;
