Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266463AbUJTA6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUJTA6u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 20:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266465AbUJTA4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:56:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:64179 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266463AbUJTAT0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:26 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <1098231504304@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:24 -0700
Message-Id: <10982315042830@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1867.7.2, 2004/09/13 21:29:32-07:00, greg@kroah.com

I2C: fix up __iomem marking for i2c bus drivers

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-i810.c      |    2 +-
 drivers/i2c/busses/i2c-prosavage.c |    6 +++---
 drivers/i2c/busses/i2c-savage4.c   |    2 +-
 drivers/i2c/busses/i2c-voodoo3.c   |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-i810.c b/drivers/i2c/busses/i2c-i810.c
--- a/drivers/i2c/busses/i2c-i810.c	2004-10-19 16:55:21 -07:00
+++ b/drivers/i2c/busses/i2c-i810.c	2004-10-19 16:55:21 -07:00
@@ -70,7 +70,7 @@
 #define CYCLE_DELAY		10
 #define TIMEOUT			(HZ / 2)
 
-static void *ioaddr;
+static void __iomem *ioaddr;
 
 /* The i810 GPIO registers have individual masks for each bit
    so we never have to read before writing. Nice. */
diff -Nru a/drivers/i2c/busses/i2c-prosavage.c b/drivers/i2c/busses/i2c-prosavage.c
--- a/drivers/i2c/busses/i2c-prosavage.c	2004-10-19 16:55:21 -07:00
+++ b/drivers/i2c/busses/i2c-prosavage.c	2004-10-19 16:55:21 -07:00
@@ -68,7 +68,7 @@
 #define MAX_BUSSES	2
 
 struct s_i2c_bus {
-	void	*mmvga;
+	void __iomem *mmvga;
 	int	i2c_reg;
 	int	adap_ok;
 	struct i2c_adapter		adap;
@@ -76,7 +76,7 @@
 };
 
 struct s_i2c_chip {
-	void	*mmio;
+	void __iomem *mmio;
 	struct s_i2c_bus	i2c_bus[MAX_BUSSES];
 };
 
@@ -181,7 +181,7 @@
 /*
  * adapter initialisation
  */
-static int i2c_register_bus(struct pci_dev *dev, struct s_i2c_bus *p, u8 *mmvga, u32 i2c_reg)
+static int i2c_register_bus(struct pci_dev *dev, struct s_i2c_bus *p, void __iomem *mmvga, u32 i2c_reg)
 {
 	int ret;
 	p->adap.owner	  = THIS_MODULE;
diff -Nru a/drivers/i2c/busses/i2c-savage4.c b/drivers/i2c/busses/i2c-savage4.c
--- a/drivers/i2c/busses/i2c-savage4.c	2004-10-19 16:55:21 -07:00
+++ b/drivers/i2c/busses/i2c-savage4.c	2004-10-19 16:55:21 -07:00
@@ -73,7 +73,7 @@
 #define TIMEOUT			(HZ / 2)
 
 
-static void *ioaddr;
+static void __iomem *ioaddr;
 
 /* The sav GPIO registers don't have individual masks for each bit
    so we always have to read before writing. */
diff -Nru a/drivers/i2c/busses/i2c-voodoo3.c b/drivers/i2c/busses/i2c-voodoo3.c
--- a/drivers/i2c/busses/i2c-voodoo3.c	2004-10-19 16:55:21 -07:00
+++ b/drivers/i2c/busses/i2c-voodoo3.c	2004-10-19 16:55:21 -07:00
@@ -61,7 +61,7 @@
 #define TIMEOUT		(HZ / 2)
 
 
-static void *ioaddr;
+static void __iomem *ioaddr;
 
 /* The voo GPIO registers don't have individual masks for each bit
    so we always have to read before writing. */

