Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262829AbVHEBM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbVHEBM4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 21:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbVHEBKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 21:10:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:55527 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262806AbVHEBHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 21:07:09 -0400
Date: Thu, 4 Aug 2005 18:06:47 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ok@artecdesign.ee
Subject: [patch 5/5] USB: Fix setup packet initialization in isp116x-hcd
Message-ID: <20050805010647.GF19625@kroah.com>
References: <20050805010206.711658000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-fix-setup-packet-init-in-isp116x-hcd.patch"
In-Reply-To: <20050805010533.GA19625@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olav Kongas <ok@artecdesign.ee>


When recently addressing remarks by Alexey Dobriyan about
the isp116x-hcd, I introduced a bug in the driver. Please
apply the attached patch to fix it.

Signed-off-by: Olav Kongas <ok@artecdesign.ee>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/host/isp116x-hcd.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- gregkh-2.6.orig/drivers/usb/host/isp116x-hcd.c	2005-08-04 17:37:11.000000000 -0700
+++ gregkh-2.6/drivers/usb/host/isp116x-hcd.c	2005-08-04 17:40:10.000000000 -0700
@@ -229,9 +229,11 @@
 	struct isp116x_ep *ep;
 	struct urb *urb;
 	struct ptd *ptd;
-	u16 toggle = 0, dir = PTD_DIR_SETUP, len;
+	u16 len;
 
 	for (ep = isp116x->atl_active; ep; ep = ep->active) {
+		u16 toggle = 0, dir = PTD_DIR_SETUP;
+
 		BUG_ON(list_empty(&ep->hep->urb_list));
 		urb = container_of(ep->hep->urb_list.next,
 				   struct urb, urb_list);

--
