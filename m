Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266564AbUG0SoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266564AbUG0SoW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUG0Snu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:43:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64385 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266545AbUG0Skb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:40:31 -0400
Date: Tue, 27 Jul 2004 11:40:24 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: <marcelo.tosatti@cyclades.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: USB: add free_len=0 initialization to ipaq.c
Message-Id: <20040727114024.2ea5e2ba@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is what happens when driver writers neglect memset after kmalloc.
Patch by Ganesh Varadaraja.

diff -urp -X dontdiff linux-2.4.27-rc3/drivers/usb/serial/ipaq.c linux-2.4.27-rc3-usbx/drivers/usb/serial/ipaq.c
--- linux-2.4.27-rc3/drivers/usb/serial/ipaq.c	2003-11-29 18:53:05.000000000 -0800
+++ linux-2.4.27-rc3-usbx/drivers/usb/serial/ipaq.c	2004-07-27 10:30:49.000000000 -0700
@@ -188,6 +188,7 @@ static int ipaq_open(struct usb_serial_p
 	port->private = (void *)priv;
 	priv->active = 0;
 	priv->queue_len = 0;
+	priv->free_len = 0;
 	INIT_LIST_HEAD(&priv->queue);
 	INIT_LIST_HEAD(&priv->freelist);
 
