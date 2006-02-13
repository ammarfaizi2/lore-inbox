Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbWBMXaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWBMXaI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWBMXaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:30:07 -0500
Received: from ns.suse.de ([195.135.220.2]:6314 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030279AbWBMXaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:30:06 -0500
Date: Tue, 14 Feb 2006 00:30:03 +0100
From: Karsten Keil <kkeil@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix NULL pointer dereference in isdn_tty_at_cout
Message-ID: <20060213233003.GA17663@pingi.kke.suse.de>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.13-15.7-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The changes in the tty related code introduced wrong parenthesis in a
if condition in the isdn_tty_at_cout function.
This caused access to index -1 in the dev->drv[] array.
This patch change it back to the correct condition from the previous
versions.

Signed-off-by: Karsten Keil <kkeil@suse.de>

---

 drivers/isdn/i4l/isdn_tty.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

f472fc1267e4975379b7566b1236b9235aaeeda0
diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
index f190a99..3936336 100644
--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -2359,8 +2359,8 @@ isdn_tty_at_cout(char *msg, modem_info *
 
 	/* use queue instead of direct, if online and */
 	/* data is in queue or buffer is full */
-	if ((info->online && tty_buffer_request_room(tty, l) < l) ||
-	    (!skb_queue_empty(&dev->drv[info->isdn_driver]->rpqueue[info->isdn_channel]))) {
+	if (info->online && ((tty_buffer_request_room(tty, l) < l) ||
+	    !skb_queue_empty(&dev->drv[info->isdn_driver]->rpqueue[info->isdn_channel]))) {
 		skb = alloc_skb(l, GFP_ATOMIC);
 		if (!skb) {
 			spin_unlock_irqrestore(&info->readlock, flags);

-- 
Karsten Keil
SuSE Labs
ISDN development
