Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbVKEQmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbVKEQmd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVKEQmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:42:32 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:49417 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751243AbVKEQm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:42:29 -0500
Date: Sat, 5 Nov 2005 17:42:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org,
       Benjamin Reed <breed@users.sourceforge.net>
Subject: [2.6 patch] airo.c/airo_cs.c: correct prototypes
Message-ID: <20051105164227.GK5368@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates a file airo.h containing prototypes of the global 
functions in airo.c used by airo_cs.c .

If you got strange problems with either airo_cs devices or in any other 
completely unrelated part of the kernel shortly or long after a airo_cs 
device was detected by the kernel, this might have been caused by the 
fact that caller and callee disagreed regarding the size of the first 
argument to init_airo_card()...


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/wireless/airo.c    |    2 ++
 drivers/net/wireless/airo.h    |    9 +++++++++
 drivers/net/wireless/airo_cs.c |    6 ++----
 3 files changed, 13 insertions(+), 4 deletions(-)

--- /dev/null	2005-04-28 03:52:17.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/drivers/net/wireless/airo.h	2005-11-05 16:57:14.000000000 +0100
@@ -0,0 +1,9 @@
+#ifndef _AIRO_H_
+#define _AIRO_H_
+
+struct net_device *init_airo_card(unsigned short irq, int port, int is_pcmcia,
+				  struct device *dmdev);
+int reset_airo_card(struct net_device *dev);
+void stop_airo_card(struct net_device *dev, int freeres);
+
+#endif  /*  _AIRO_H_  */
--- linux-2.6.14-rc5-mm1-full/drivers/net/wireless/airo.c.old	2005-11-05 16:54:10.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/net/wireless/airo.c	2005-11-05 16:54:43.000000000 +0100
@@ -47,6 +47,8 @@
 #include <linux/pci.h>
 #include <asm/uaccess.h>
 
+#include "airo.h"
+
 #ifdef CONFIG_PCI
 static struct pci_device_id card_ids[] = {
 	{ 0x14b9, 1, PCI_ANY_ID, PCI_ANY_ID, },
--- linux-2.6.14-rc5-mm1-full/drivers/net/wireless/airo_cs.c.old	2005-11-05 16:57:27.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/net/wireless/airo_cs.c	2005-11-05 16:57:58.000000000 +0100
@@ -42,6 +42,8 @@
 #include <asm/io.h>
 #include <asm/system.h>
 
+#include "airo.h"
+
 /*
    All the PCMCIA modules use PCMCIA_DEBUG to control debugging.  If
    you do not define PCMCIA_DEBUG at all, all the debug code will be
@@ -78,10 +80,6 @@
    event handler. 
 */
 
-struct net_device *init_airo_card( int, int, int, struct device * );
-void stop_airo_card( struct net_device *, int );
-int reset_airo_card( struct net_device * );
-
 static void airo_config(dev_link_t *link);
 static void airo_release(dev_link_t *link);
 static int airo_event(event_t event, int priority,

