Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbVKHCCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbVKHCCS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbVKHCCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:02:18 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62727 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030244AbVKHCCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:02:13 -0500
Date: Tue, 8 Nov 2005 03:02:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Benjamin Reed <breed@users.sourceforge.net>
Subject: [2.4 patch] airo.c/airo_cs.c: correct prototypes
Message-ID: <20051108020211.GK3847@stusta.de>
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

A similar patch was already included in Linus' 2.6 tree.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/wireless/airo.c    |    2 ++
 drivers/net/wireless/airo.h    |    8 ++++++++
 drivers/net/wireless/airo_cs.c |    6 ++----
 3 files changed, 12 insertions(+), 4 deletions(-)

--- /dev/null	2005-04-28 03:52:17.000000000 +0200
+++ linux-2.4.32-rc2-full/drivers/net/wireless/airo.h	2005-11-08 02:58:54.000000000 +0100
@@ -0,0 +1,8 @@
+#ifndef _AIRO_H_
+#define _AIRO_H_
+
+struct net_device *init_airo_card(unsigned short irq, int port, int is_pcmcia);
+void stop_airo_card(struct net_device *dev, int freeres);
+int reset_airo_card(struct net_device *dev);
+
+#endif  /*  _AIRO_H_  */
--- linux-2.4.32-rc2-full/drivers/net/wireless/airo.c.old	2005-11-08 02:54:44.000000000 +0100
+++ linux-2.4.32-rc2-full/drivers/net/wireless/airo.c	2005-11-08 02:55:04.000000000 +0100
@@ -43,6 +43,8 @@
 #include <linux/pci.h>
 #include <asm/uaccess.h>
 
+#include "airo.h"
+
 #ifdef CONFIG_PCI
 static struct pci_device_id card_ids[] = {
 	{ 0x14b9, 1, PCI_ANY_ID, PCI_ANY_ID, },
--- linux-2.4.32-rc2-full/drivers/net/wireless/airo_cs.c.old	2005-11-08 02:55:54.000000000 +0100
+++ linux-2.4.32-rc2-full/drivers/net/wireless/airo_cs.c	2005-11-08 02:56:20.000000000 +0100
@@ -45,6 +45,8 @@
 #include <pcmcia/cisreg.h>
 #include <pcmcia/ds.h>
 
+#include "airo.h"
+
 /*
    All the PCMCIA modules use PCMCIA_DEBUG to control debugging.  If
    you do not define PCMCIA_DEBUG at all, all the debug code will be
@@ -91,10 +93,6 @@
    event handler. 
 */
 
-struct net_device *init_airo_card( int, int, int );
-void stop_airo_card( struct net_device *, int );
-int reset_airo_card( struct net_device * );
-
 static void airo_config(dev_link_t *link);
 static void airo_release(u_long arg);
 static int airo_event(event_t event, int priority,

