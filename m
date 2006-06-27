Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932882AbWF0LBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932882AbWF0LBa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 07:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933385AbWF0LBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 07:01:30 -0400
Received: from cantor2.suse.de ([195.135.220.15]:1729 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932882AbWF0LB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 07:01:29 -0400
Date: Tue, 27 Jun 2006 13:01:27 +0200
From: Karsten Keil <kkeil@suse.de>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Greg KH <gregkh@suse.de>
Subject: [PATCH] i4l fix DLE masking in isdn_tty_try_read
Message-ID: <20060627110127.GA11021@pingi.kke.suse.de>
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

DLE masking was none functional since the new tty handling.
Found by Peter Evertz <leo2@pec.homeip.net>

Signed-off-by: Karsten Keil <kkeil@suse.de>

---

 drivers/isdn/i4l/isdn_tty.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

d895418ed29eb92a72c5c2ef68a6dafeaa53b717
diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
index 2ac9024..433389d 100644
--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -82,7 +82,7 @@ isdn_tty_try_read(modem_info * info, str
 						int l = skb->len;
 						unsigned char *dp = skb->data;
 						while (--l) {
-							if (*skb->data == DLE)
+							if (*dp == DLE)
 								tty_insert_flip_char(tty, DLE, 0);
 							tty_insert_flip_char(tty, *dp++, 0);
 						}

-- 
Karsten Keil
SuSE Labs
ISDN development
