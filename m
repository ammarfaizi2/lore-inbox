Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161010AbWCXGO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbWCXGO6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423165AbWCXGMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:12:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:41178 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161016AbWCXGLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:11:52 -0500
Cc: "Ed L. Cashin" <ecashin@coraid.com>, "Ed L. Cashin" <ecashin@coraid.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 09/12] aoe: do not stop retransmit timer when device goes down
In-Reply-To: <1143180654383-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Thu, 23 Mar 2006 22:10:54 -0800
Message-Id: <1143180654198-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a bugfix that follows and depends on the
eight aoe driver patches sent January 19th.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/block/aoe/aoecmd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

1c6f3fcac03a16c901ee5acd58100bff963add6d
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 22bebf8..207aabc 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -331,7 +331,7 @@ rexmit_timer(ulong vp)
 	spin_lock_irqsave(&d->lock, flags);
 
 	if (d->flags & DEVFL_TKILL) {
-tdie:		spin_unlock_irqrestore(&d->lock, flags);
+		spin_unlock_irqrestore(&d->lock, flags);
 		return;
 	}
 	f = d->frames;
@@ -342,7 +342,7 @@ tdie:		spin_unlock_irqrestore(&d->lock, 
 			n /= HZ;
 			if (n > MAXWAIT) { /* waited too long.  device failure. */
 				aoedev_downdev(d);
-				goto tdie;
+				break;
 			}
 			rexmit(d, f);
 		}
-- 
1.2.4


