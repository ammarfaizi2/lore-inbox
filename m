Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVFUCSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVFUCSJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVFUCRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:17:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:32740 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261730AbVFTW7s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:48 -0400
Cc: mhoffman@lightlink.com
Subject: [PATCH] USB: trivial error path fix
In-Reply-To: <1119308363226@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:23 -0700
Message-Id: <11193083632112@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] USB: trivial error path fix

Trivial fix to USB class-creation error path; please apply.

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 5cebfb759cc75208c04590ad7f4485cdd822cf46
tree df6589c03ea968b674249f5092fbb021f71df157
parent 56b2293595b2eb52cc2aa2baf92c6cfa8265f9d5
author Mark M. Hoffman <mhoffman@lightlink.com> Mon, 02 May 2005 23:35:45 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:09 -0700

 drivers/usb/core/file.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/core/file.c b/drivers/usb/core/file.c
--- a/drivers/usb/core/file.c
+++ b/drivers/usb/core/file.c
@@ -82,6 +82,7 @@ int usb_major_init(void)
 
 	usb_class = class_create(THIS_MODULE, "usb");
 	if (IS_ERR(usb_class)) {
+		error = PTR_ERR(usb_class);
 		err("class_create failed for usb devices");
 		unregister_chrdev(USB_MAJOR, "usb");
 		goto out;

