Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965135AbWACXpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbWACXpz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWACXpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:45:54 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:38805 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964997AbWACXpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:45:51 -0500
Message-Id: <200601040037.k040bmls012576@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 11/12] UML - Fix flip_buf full handling
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Jan 2006 19:37:48 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the tty flip_buf is full, it's a good idea to delay the input
processing for a jiffy, rather than just scheduling the tasklet
immediately.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/chan_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/chan_kern.c	2005-12-25 22:35:58.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/chan_kern.c	2005-12-25 22:42:14.000000000 -0500
@@ -629,7 +629,7 @@ void chan_interrupt(struct list_head *ch
 		do {
 			if((tty != NULL) &&
 			   (tty->flip.count >= TTY_FLIPBUF_SIZE)){
-				schedule_work(task);
+				schedule_delayed_work(task, 1);
 				goto out;
 			}
 			err = chan->ops->read(chan->fd, &c, chan->data);

