Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbULAAsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbULAAsH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbULAAdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:33:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:58596 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261302AbULAAO3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:14:29 -0500
Subject: Re: [PATCH] I2C fixes for 2.6.10-rc2
In-Reply-To: <11018600202097@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Nov 2004 16:13:40 -0800
Message-Id: <11018600202671@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2223.2.12, 2004/11/30 15:23:40-08:00, johnpol@2ka.mipt.ru

[PATCH] W1: check nls in return path.

Check netlink socket being non NULL in error return path.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/w1_int.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
--- a/drivers/w1/w1_int.c	2004-11-30 16:00:26 -08:00
+++ b/drivers/w1/w1_int.c	2004-11-30 16:00:26 -08:00
@@ -96,7 +96,7 @@
 	err = device_register(&dev->dev);
 	if (err) {
 		printk(KERN_ERR "Failed to register master device. err=%d\n", err);
-		if (dev->nls->sk_socket)
+		if (dev->nls && dev->nls->sk_socket)
 			sock_release(dev->nls->sk_socket);
 		memset(dev, 0, sizeof(struct w1_master));
 		kfree(dev);

