Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVAHH1C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVAHH1C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVAHH0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:26:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:63877 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261899AbVAHFsd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:33 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632582603@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:38 -0800
Message-Id: <11051632582144@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.55, 2005/01/07 09:07:22-08:00, david-b@pacbell.net

[PATCH] USB: ohci diagnostic tweak

This changes the OHCI "USB HC TakeOver failed" message to be a bit
more informative, by fingering the root cause:  a BIOS/SMM bug.

That way they're more likely to either bug the board vendor, or find
workarounds (like tweaking the BIOS setup, or the ohci_hcd no_handshake
parameter) before giving up or (wrongly) reporting a Linux bug.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/host/ohci-hcd.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
--- a/drivers/usb/host/ohci-hcd.c	2005-01-07 15:35:13 -08:00
+++ b/drivers/usb/host/ohci-hcd.c	2005-01-07 15:35:13 -08:00
@@ -441,7 +441,8 @@
 		while (ohci_readl (ohci, &ohci->regs->control) & OHCI_CTRL_IR) {
 			msleep (10);
 			if (--temp == 0) {
-				ohci_err (ohci, "USB HC TakeOver failed!\n");
+				ohci_err (ohci, "USB HC takeover failed!"
+					"  (BIOS/SMM bug)\n");
 				return -EBUSY;
 			}
 		}

