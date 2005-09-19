Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932700AbVISV2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700AbVISV2j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 17:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbVISV2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 17:28:39 -0400
Received: from ns.suse.de ([195.135.220.2]:64442 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932700AbVISV2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 17:28:39 -0400
Date: Mon, 19 Sep 2005 23:28:36 +0200
From: Karsten Keil <kkeil@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Karsten Keil <kkeil@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] Remove URB_ASYNC_UNLINK from last patch
Message-ID: <20050919212836.GA24376@pingi3.kke.suse.de>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Karsten Keil <kkeil@suse.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20050919141037.GB13054@pingi3.kke.suse.de> <20050919142409.GB2959@pingi3.kke.suse.de> <Pine.LNX.4.58.0509191002530.9106@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509191002530.9106@g5.osdl.org>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.13-15-default i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 10:12:38AM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 19 Sep 2005, Karsten Keil wrote:
> > 
> > Is here a way in git to "merge" these two patches ?
> 
> Just do "git diff a..b" to generate the diff over both of them (where "a" 
> is the commit before the two, and "b" is the last one, of course).

Thank you.

> 
> Btw, the patch doesn't apply any more. I already applied your earlier one.
> 

You should only need the second part then, which removes the not longer
needed URB_ASYNC_UNLINK settings, this is this one

Subject: [PATCH 2/2] Remove URB_ASYNC_UNLINK from last patch

Sorry, tested the wrong HEAD for compile.

- usb_unlink_urb is always async now, so URB_ASYNC_UNLINK was removed from
  core USB and we must do as well.

Signed-off-by: Karsten Keil <kkeil@suse.de>

---

 drivers/isdn/hisax/st5481_b.c   |    2 --
 drivers/isdn/hisax/st5481_usb.c |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)

7c3b2c6e0875808314829f11d8a317af2b1b549c
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
