Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVAHLH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVAHLH1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 06:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVAHHe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:34:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:49541 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261876AbVAHFsU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:20 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632623391@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:42 -0800
Message-Id: <1105163262636@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.25, 2004/12/21 11:20:39-08:00, david-b@pacbell.net

[PATCH] USB: ohci build tweaks

Resolves some build glitches that snuck into OHCI.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/host/ohci-hcd.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)


diff -Nru a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
--- a/drivers/usb/host/ohci-hcd.c	2005-01-07 15:40:54 -08:00
+++ b/drivers/usb/host/ohci-hcd.c	2005-01-07 15:40:54 -08:00
@@ -416,7 +416,6 @@
 
 static int ohci_init (struct ohci_hcd *ohci)
 {
-	u32 temp;
 	int ret;
 
 	disable (ohci);
@@ -427,6 +426,8 @@
 	/* SMM owns the HC?  not for long! */
 	if (!no_handshake && ohci_readl (ohci,
 					&ohci->regs->control) & OHCI_CTRL_IR) {
+		u32 temp;
+
 		ohci_dbg (ohci, "USB HC TakeOver from BIOS/SMM\n");
 
 		/* this timeout is arbitrary.  we make it long, so systems
@@ -902,14 +903,4 @@
       || defined (CONFIG_PXA27x) \
 	)
 #error "missing bus glue for ohci-hcd"
-#endif
-
-#if	!defined(HAVE_HNP) && defined(CONFIG_USB_OTG)
-
-#warning non-OTG configuration, too many HCDs
-
-static void start_hnp(struct ohci_hcd *ohci)
-{
-	/* "can't happen" */
-}
 #endif

