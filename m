Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWJ1Som@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWJ1Som (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWJ1Som
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:44:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:21049 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932068AbWJ1Sol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:44:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=nGCK07QoWJn/wvx/kG7XEvNBjlAHZm9XcTZe/IjEkSyrocHPn+k7rwpBdoBIgRjc4OjD75qxThZzHgc3s7DjdOTWj1AbYUDQHlME44miFJC/HGqQW7aJV5NmQYEBOGIqydWv2QeyxCZFoVEFPlefnJAhh8NZoqUH09LDm44jPyw=
Date: Sun, 29 Oct 2006 03:45:00 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Kai Germaschewski <kai.germaschewski@gmx.de>,
       Hansjoerg Lipp <hjlipp@web.de>, Tilman Schmidt <tilman@imap.cc>,
       Karsten Keil <kkeil@suse.de>
Subject: [PATCH] isdn/gigaset: avoid cs->dev null pointer dereference
Message-ID: <20061028184500.GE9973@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai.germaschewski@gmx.de>,
	Hansjoerg Lipp <hjlipp@web.de>, Tilman Schmidt <tilman@imap.cc>,
	Karsten Keil <kkeil@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When gigaset_initbcs() is called, cs->dev is not initialized yet.
If dev_alloc_skb() failed in this function, NULL poinster
dereference will happen at dev_warn().

Cc: Kai Germaschewski <kai.germaschewski@gmx.de>
Cc: Hansjoerg Lipp <hjlipp@web.de>
Cc: Tilman Schmidt <tilman@imap.cc>
Cc: Karsten Keil <kkeil@suse.de>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/isdn/gigaset/common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: work-fault-inject/drivers/isdn/gigaset/common.c
===================================================================
--- work-fault-inject.orig/drivers/isdn/gigaset/common.c
+++ work-fault-inject/drivers/isdn/gigaset/common.c
@@ -579,7 +579,7 @@ static struct bc_state *gigaset_initbcs(
 	} else if ((bcs->skb = dev_alloc_skb(SBUFSIZE + HW_HDR_LEN)) != NULL)
 		skb_reserve(bcs->skb, HW_HDR_LEN);
 	else {
-		dev_warn(cs->dev, "could not allocate skb\n");
+		gig_dbg(DEBUG_INIT, "could not allocate skb\n");
 		bcs->inputstate |= INS_skip_frame;
 	}
 
