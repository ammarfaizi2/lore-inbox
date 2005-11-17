Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbVKQSKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbVKQSKN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbVKQSKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:10:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:25250 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932503AbVKQSEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:04:12 -0500
Date: Thu, 17 Nov 2005 09:47:49 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [patch 17/22] usb devio warning fix
Message-ID: <20051117174749.GQ11174@kroah.com>
References: <20051117174227.007572000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-devio-warning-fix.patch"
In-Reply-To: <20051117174609.GA11174@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

drivers/usb/core/devio.c: In function `proc_ioctl_compat':
drivers/usb/core/devio.c:1401: warning: passing arg 1 of `compat_ptr' makes integer from pointer without a cast

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/core/devio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- usb-2.6.orig/drivers/usb/core/devio.c
+++ usb-2.6/drivers/usb/core/devio.c
@@ -1398,7 +1398,7 @@ static int proc_ioctl_compat(struct dev_
 	struct usbdevfs_ioctl ctrl;
 	u32 udata;
 
-	uioc = compat_ptr(arg);
+	uioc = compat_ptr((long)arg);
 	if (get_user(ctrl.ifno, &uioc->ifno) ||
 	    get_user(ctrl.ioctl_code, &uioc->ioctl_code) ||
 	    __get_user(udata, &uioc->data))

--
