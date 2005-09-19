Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbVISOKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbVISOKk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 10:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbVISOKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 10:10:40 -0400
Received: from ns.suse.de ([195.135.220.2]:38124 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932420AbVISOKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 10:10:39 -0400
Date: Mon, 19 Sep 2005 16:10:37 +0200
From: Karsten Keil <kkeil@suse.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Remove URB_ASYNC_UNLINK from last patch
Message-ID: <20050919141037.GB13054@pingi3.kke.suse.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.13-15-default i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, tested the wrong HEAD for compile.

- usb_unlink_urb is always async now, so URB_ASYNC_UNLINK was removed from
  core USB and we must do as well.

Signed-off-by: Karsten Keil <kkeil@suse.de>

---

 drivers/isdn/hisax/st5481_b.c   |    2 --
 drivers/isdn/hisax/st5481_usb.c |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)

2eb47d73594e18ef894b94a26bea26962eca1374
diff --git a/drivers/isdn/hisax/st5481_b.c b/drivers/isdn/hisax/st5481_b.c
--- a/drivers/isdn/hisax/st5481_b.c
+++ b/drivers/isdn/hisax/st5481_b.c
@@ -209,9 +209,7 @@ static void st5481B_mode(struct st5481_b
 	bcs->mode = mode;
 
 	// Cancel all USB transfers on this B channel
-	b_out->urb[0]->transfer_flags |= URB_ASYNC_UNLINK;
 	usb_unlink_urb(b_out->urb[0]);
-	b_out->urb[1]->transfer_flags |= URB_ASYNC_UNLINK;
 	usb_unlink_urb(b_out->urb[1]);
 	b_out->busy = 0;
 
diff --git a/drivers/isdn/hisax/st5481_usb.c b/drivers/isdn/hisax/st5481_usb.c
--- a/drivers/isdn/hisax/st5481_usb.c
+++ b/drivers/isdn/hisax/st5481_usb.c
@@ -645,9 +645,7 @@ void st5481_in_mode(struct st5481_in *in
 
 	in->mode = mode;
 
-	in->urb[0]->transfer_flags |= URB_ASYNC_UNLINK;
 	usb_unlink_urb(in->urb[0]);
-	in->urb[1]->transfer_flags |= URB_ASYNC_UNLINK;
 	usb_unlink_urb(in->urb[1]);
 
 	if (in->mode != L1_MODE_NULL) {

-- 
Karsten Keil
SuSE Labs
ISDN development
