Return-Path: <linux-kernel-owner+w=401wt.eu-S1754791AbWL0Vrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791AbWL0Vrx (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 16:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754780AbWL0Vrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 16:47:52 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:28462 "HELO
	smtp107.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754791AbWL0Vrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 16:47:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=NOSzji1C3mNKjKyyKBQ/9TSKFVhMPbygjKIFgyOuVLomDYcvIVjjYzFeTOvVYhwGOZY/oi/YkacB25lKYw5eLgNvibOYBNQIvvFYz7xnFsl8ya7bDpdsf7XwkLWo0Sesx2F8bX1wliNg7ysBnAzJ3nW7j+rM6yjB1XE1D/o1FNY=  ;
X-YMail-OSG: 5BZd9f8VM1kOEWR6NAm9y7duOQMr9N6gy_ie22YCs4Ah11GzbOK6gg2XTR.bliyLvzr7D1f9pxBDEq5fdH7.75sa8QCo0zbX39oUWwTvn_8gX9zcU_xiciFJ73ti7sNTJiuGj__.0HgpHTg-
From: David Brownell <david-b@pacbell.net>
To: Adam Belay <abelay@novell.com>, ambx1@neo.rr.com
Subject: [patch 2.6.12-rc2] PNP: export pnp_bus_type
Date: Wed, 27 Dec 2006 13:47:45 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612271347.47114.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PNP framework doesn't export "pnp_bus_type", which is an unfortunate
exception to the policy followed by pretty much every other bus.  I noticed
this when I had to find a device in order to provide its platform_data.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/drivers/pnp/base.h
===================================================================
--- g26.orig/drivers/pnp/base.h	2006-12-18 05:45:29.000000000 -0800
+++ g26/drivers/pnp/base.h	2006-12-18 05:45:41.000000000 -0800
@@ -1,4 +1,3 @@
-extern struct bus_type pnp_bus_type;
 extern spinlock_t pnp_lock;
 void *pnp_alloc(long size);
 int pnp_interface_attach_device(struct pnp_dev *dev);
Index: g26/drivers/pnp/driver.c
===================================================================
--- g26.orig/drivers/pnp/driver.c	2006-07-03 10:45:14.000000000 -0700
+++ g26/drivers/pnp/driver.c	2006-12-18 05:41:56.000000000 -0800
@@ -199,6 +199,7 @@ struct bus_type pnp_bus_type = {
 	.suspend = pnp_bus_suspend,
 	.resume = pnp_bus_resume,
 };
+EXPORT_SYMBOL(pnp_bus_type);
 
 int pnp_register_driver(struct pnp_driver *drv)
 {
Index: g26/include/linux/pnp.h
===================================================================
--- g26.orig/include/linux/pnp.h	2006-12-18 05:45:29.000000000 -0800
+++ g26/include/linux/pnp.h	2006-12-27 13:22:58.000000000 -0800
@@ -352,6 +352,8 @@ struct pnp_protocol {
 	(dev) = protocol_to_pnp_dev((dev)->protocol_list.next))
 
 
+extern struct bus_type pnp_bus_type;
+
 #if defined(CONFIG_PNP)
 
 /* device management */
