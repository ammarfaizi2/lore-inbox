Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVAHH1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVAHH1D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbVAHH0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:26:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:65157 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261901AbVAHFsd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:33 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163262636@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:42 -0800
Message-Id: <11051632623844@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.26, 2004/12/21 11:21:08-08:00, david-b@pacbell.net

[PATCH] USB: fix Scheduling while atomic warning when resuming.

From: David Brownell <david-b@pacbell.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/host/ehci-hub.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
--- a/drivers/usb/host/ehci-hub.c	2005-01-07 15:40:46 -08:00
+++ b/drivers/usb/host/ehci-hub.c	2005-01-07 15:40:46 -08:00
@@ -122,7 +122,7 @@
 		writel (temp, &ehci->regs->port_status [i]);
 	}
 	i = HCS_N_PORTS (ehci->hcs_params);
-	msleep (20);
+	mdelay (20);
 	while (i--) {
 		temp = readl (&ehci->regs->port_status [i]);
 		if ((temp & PORT_SUSPEND) == 0)

