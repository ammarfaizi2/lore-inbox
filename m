Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVAHGtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVAHGtO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVAHGtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:49:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:7302 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261912AbVAHFsk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:40 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632651375@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:45 -0800
Message-Id: <1105163265199@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.19, 2004/12/15 16:34:18-08:00, david-b@pacbell.net

[PATCH] USB: EHCI HCD and usb_dev->epmaxpacket (7/15)

Makes EHCI stop referencing the udev->epmaxpacket[] arrays.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/host/ehci-sched.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


diff -Nru a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
--- a/drivers/usb/host/ehci-sched.c	2005-01-07 15:49:06 -08:00
+++ b/drivers/usb/host/ehci-sched.c	2005-01-07 15:49:06 -08:00
@@ -614,11 +614,10 @@
 	 */
 	epnum = usb_pipeendpoint (pipe);
 	is_input = usb_pipein (pipe) ? USB_DIR_IN : 0;
+	maxp = usb_maxpacket(dev, pipe, !is_input);
 	if (is_input) {
-		maxp = dev->epmaxpacketin [epnum];
 		buf1 = (1 << 11);
 	} else {
-		maxp = dev->epmaxpacketout [epnum];
 		buf1 = 0;
 	}
 

