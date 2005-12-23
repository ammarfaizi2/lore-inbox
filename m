Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161077AbVLWW3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161077AbVLWW3L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbVLWW2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:28:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:40392 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161077AbVLWW2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:28:40 -0500
Date: Fri, 23 Dec 2005 14:27:41 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com,
       bunk@stusta.de, netdev@vger.kernel.org,
       Benjamin Reed <breed@users.sourceforge.net>
Subject: [patch 06/11] airo.c/airo_cs.c: correct prototypes
Message-ID: <20051223222741.GG18252@kroah.com>
References: <20051109182205.294803000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="airo.c-airo_cs.c-correct-prototypes.patch"
In-Reply-To: <20051223222652.GA18252@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>

This patch creates a file airo.h containing prototypes of the global
functions in airo.c used by airo_cs.c .

If you got strange problems with either airo_cs devices or in any other
completely unrelated part of the kernel shortly or long after a airo_cs
device was detected by the kernel, this might have been caused by the
fact that caller and callee disagreed regarding the size of the first
argument to init_airo_card()...

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/net/wireless/airo.c    |    2 ++
 drivers/net/wireless/airo.h    |    9 +++++++++
 drivers/net/wireless/airo_cs.c |    6 ++----
 3 files changed, 13 insertions(+), 4 deletions(-)

--- /dev/null
+++ linux-2.6.14.1/drivers/net/wireless/airo.h
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
--- linux-2.6.14.1.orig/drivers/net/wireless/airo.c
+++ linux-2.6.14.1/drivers/net/wireless/airo.c
@@ -46,6 +46,8 @@
 #include <linux/pci.h>
 #include <asm/uaccess.h>
 
+#include "airo.h"
+
 #ifdef CONFIG_PCI
 static struct pci_device_id card_ids[] = {
 	{ 0x14b9, 1, PCI_ANY_ID, PCI_ANY_ID, },
--- linux-2.6.14.1.orig/drivers/net/wireless/airo_cs.c
+++ linux-2.6.14.1/drivers/net/wireless/airo_cs.c
@@ -42,6 +42,8 @@
 #include <asm/io.h>
 #include <asm/system.h>
 
+#include "airo.h"
+
 /*
    All the PCMCIA modules use PCMCIA_DEBUG to control debugging.  If
    you do not define PCMCIA_DEBUG at all, all the debug code will be
@@ -78,10 +80,6 @@ MODULE_SUPPORTED_DEVICE("Aironet 4500, 4
    event handler. 
 */
 
-struct net_device *init_airo_card( int, int, int, struct device * );
-void stop_airo_card( struct net_device *, int );
-int reset_airo_card( struct net_device * );
-
 static void airo_config(dev_link_t *link);
 static void airo_release(dev_link_t *link);
 static int airo_event(event_t event, int priority,

--
