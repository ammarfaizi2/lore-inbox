Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbUCPBLP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbUCPADc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:03:32 -0500
Received: from mail.kroah.org ([65.200.24.183]:3247 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262873AbUCPAB5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:01:57 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.4
In-Reply-To: <10793951461961@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 15:59:07 -0800
Message-Id: <10793951473255@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.84.5, 2004/03/10 16:05:50-08:00, chrisw@osdl.org

[PATCH] class_simple cleanup in misc

Error path doesn't class_simple_destroy.


 drivers/char/misc.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/char/misc.c b/drivers/char/misc.c
--- a/drivers/char/misc.c	Mon Mar 15 15:29:45 2004
+++ b/drivers/char/misc.c	Mon Mar 15 15:29:45 2004
@@ -342,6 +342,7 @@
 	if (register_chrdev(MISC_MAJOR,"misc",&misc_fops)) {
 		printk("unable to get major %d for misc devices\n",
 		       MISC_MAJOR);
+		class_simple_destroy(misc_class);
 		return -EIO;
 	}
 	return 0;

