Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbUKCJQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbUKCJQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 04:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUKCJPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 04:15:54 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:34449 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261514AbUKCJLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 04:11:04 -0500
Date: Wed, 3 Nov 2004 01:10:49 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] USB: fix compile warning for USB w/oPM
Message-ID: <20041103091049.GB22469@taniwha.stupidest.org>
References: <20041020023803.GF8597@taniwha.stupidest.org> <20041020235056.GA16606@kroah.com> <20041021002935.GA13781@taniwha.stupidest.org> <20041021021329.GA27812@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021021329.GA27812@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove compile warning for USB w/o PM.

Signed-off-by: Chris Wedgwood <cw@f00f.org>
---

This one I even tested...  sorry about before!



===== drivers/usb/host/ohci-hcd.c 1.76 vs edited =====
--- 1.76/drivers/usb/host/ohci-hcd.c	2004-10-12 06:24:03 -07:00
+++ edited/drivers/usb/host/ohci-hcd.c	2004-11-02 11:32:44 -08:00
@@ -140,7 +140,6 @@ static const char	hcd_name [] = "ohci_hc
 
 static void ohci_dump (struct ohci_hcd *ohci, int verbose);
 static int ohci_init (struct ohci_hcd *ohci);
-static int ohci_restart (struct ohci_hcd *ohci);
 static void ohci_stop (struct usb_hcd *hcd);
 
 #include "ohci-hub.c"
===== drivers/usb/host/ohci-hub.c 1.29 vs edited =====
--- 1.29/drivers/usb/host/ohci-hub.c	2004-10-06 14:35:08 -07:00
+++ edited/drivers/usb/host/ohci-hub.c	2004-11-02 11:32:44 -08:00
@@ -41,6 +41,7 @@
 #define OHCI_SCHED_ENABLES \
 	(OHCI_CTRL_CLE|OHCI_CTRL_BLE|OHCI_CTRL_PLE|OHCI_CTRL_IE)
 
+static int ohci_restart (struct ohci_hcd *ohci);
 static void dl_done_list (struct ohci_hcd *, struct pt_regs *);
 static void finish_unlinks (struct ohci_hcd *, u16 , struct pt_regs *);
 
