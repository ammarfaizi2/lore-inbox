Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbVLLUCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVLLUCn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbVLLUCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:02:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:47781 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932194AbVLLUCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:02:14 -0500
Date: Mon, 12 Dec 2005 12:01:36 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       stern@rowland.harvard.edu
Subject: [patch 4/4] UHCI: add missing memory barriers
Message-ID: <20051212200136.GE27657@kroah.com>
References: <20051212192030.873030000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="uhci-add-missing-memory-barriers.patch"
In-Reply-To: <20051212200044.GA27657@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

This patch (as617) adds a couple of memory barriers that Ben H. forgot in
his recent suspend/resume fix.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/host/uhci-hcd.c |    2 ++
 1 file changed, 2 insertions(+)

--- greg-2.6.orig/drivers/usb/host/uhci-hcd.c
+++ greg-2.6/drivers/usb/host/uhci-hcd.c
@@ -717,6 +717,7 @@ static int uhci_suspend(struct usb_hcd *
 	 * at the source, so we must turn off PIRQ.
 	 */
 	pci_write_config_word(to_pci_dev(uhci_dev(uhci)), USBLEGSUP, 0);
+	mb();
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 	uhci->hc_inaccessible = 1;
 	hcd->poll_rh = 0;
@@ -738,6 +739,7 @@ static int uhci_resume(struct usb_hcd *h
 	 * really don't want to keep a stale HCD_FLAG_HW_ACCESSIBLE=0
 	 */
 	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+	mb();
 
 	if (uhci->rh_state == UHCI_RH_RESET)	/* Dead */
 		return 0;

--
