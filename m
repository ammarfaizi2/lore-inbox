Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267263AbUJRSpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267263AbUJRSpy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUJRSnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:43:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:19609 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267263AbUJRSmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:42:11 -0400
Date: Mon, 18 Oct 2004 11:41:26 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: handle NAK packets in input devices.
Message-ID: <20041018184126.GA23748@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew requested this fix go in before 2.6.9 was out, to keep people's
syslog quiet for a lot of different USB input devices.

Fixes bug bugzilla.kernel.org bug #3564

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	2004-10-15 16:40:01 -07:00
+++ b/drivers/usb/input/hid-core.c	2004-10-15 16:40:01 -07:00
@@ -926,6 +926,8 @@
 		case -ENOENT:
 		case -ESHUTDOWN:
 			return;
+		case -ETIMEDOUT:	/* NAK */
+			break;
 		default:		/* error */
 			warn("input irq status %d received", urb->status);
 	}
