Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932938AbWFZTYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932938AbWFZTYQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932939AbWFZTYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:24:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:62667 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932938AbWFZTYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:24:15 -0400
Date: Mon, 26 Jun 2006 20:21:01 +0200
From: Karsten Keil <kkeil@suse.de>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Greg KH <gregkh@suse.de>
Subject: [PATCH] fix processing of the last byte in isdn_readbchan_tty()
Message-ID: <20060626182101.GA6899@pingi.kke.suse.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Greg KH <gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.16.13-4-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The changes in the tty handling contain a bug while accessing
the last byte in the skb. Since special sequence for control of
DTMF and FAX via ttyI* devices handled via this path, these services
do not work anymore.

Signed-off-by: Karsten Keil <kkeil@suse.de>

---

 drivers/isdn/i4l/isdn_common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

1bfb4ea878e3e73e64a5507d1a305517c1f2bbdd
diff --git a/drivers/isdn/i4l/isdn_common.c b/drivers/isdn/i4l/isdn_common.c
index 81accdf..b26e509 100644
--- a/drivers/isdn/i4l/isdn_common.c
+++ b/drivers/isdn/i4l/isdn_common.c
@@ -933,7 +933,7 @@ isdn_readbchan_tty(int di, int channel, 
 			count_put = count_pull;
 			if(count_put > 1)
 				tty_insert_flip_string(tty, skb->data, count_put - 1);
-			last = skb->data[count_put] - 1;
+			last = skb->data[count_put - 1];
 			len -= count_put;
 #ifdef CONFIG_ISDN_AUDIO
 		}


-- 
Karsten Keil
SuSE Labs
ISDN development
