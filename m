Return-Path: <linux-kernel-owner+w=401wt.eu-S1030350AbXAEGgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbXAEGgK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 01:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbXAEGgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 01:36:10 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:51173 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030350AbXAEGgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 01:36:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent:from;
        b=I5N+bRJHIBKtt2wxbcZnrrHcguOk1mlzEPPbb+dUQ8/ruc6GwVVJ1JTmn3YjRhl0OX/4xCFD/rQXNK4/XFdc+HkI60RuRQ3TGd/zKT2OTrq26FvzSMxxnRMYvZ8AMmF5fTkiByf92k7jwpXaDYFFrygraE2jE5LKRBbBC9eh9qU=
Date: Fri, 5 Jan 2007 08:36:00 +0200
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.20-rc3] TTY_IO: Remove unnecessary kmalloc casts
Message-ID: <20070105063600.GA13571@Ahmed>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary kmalloc casts in drivers/char/tty_io.c

Signed-off-by: Ahmed Darwish <darwish.07@gmail.com>

diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index 47a6eac..97f54b0 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -1932,16 +1932,14 @@ static int init_dev(struct tty_driver *driver, int idx,
 	}
 
 	if (!*tp_loc) {
-		tp = (struct ktermios *) kmalloc(sizeof(struct ktermios),
-						GFP_KERNEL);
+		tp = kmalloc(sizeof(struct ktermios), GFP_KERNEL);
 		if (!tp)
 			goto free_mem_out;
 		*tp = driver->init_termios;
 	}
 
 	if (!*ltp_loc) {
-		ltp = (struct ktermios *) kmalloc(sizeof(struct ktermios),
-						 GFP_KERNEL);
+		ltp = kmalloc(sizeof(struct ktermios), GFP_KERNEL);
 		if (!ltp)
 			goto free_mem_out;
 		memset(ltp, 0, sizeof(struct ktermios));
@@ -1965,16 +1963,14 @@ static int init_dev(struct tty_driver *driver, int idx,
 		}
 
 		if (!*o_tp_loc) {
-			o_tp = (struct ktermios *)
-				kmalloc(sizeof(struct ktermios), GFP_KERNEL);
+			o_tp = kmalloc(sizeof(struct ktermios), GFP_KERNEL);
 			if (!o_tp)
 				goto free_mem_out;
 			*o_tp = driver->other->init_termios;
 		}
 
 		if (!*o_ltp_loc) {
-			o_ltp = (struct ktermios *)
-				kmalloc(sizeof(struct ktermios), GFP_KERNEL);
+			o_ltp = kmalloc(sizeof(struct ktermios), GFP_KERNEL);
 			if (!o_ltp)
 				goto free_mem_out;
 			memset(o_ltp, 0, sizeof(struct ktermios));

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
