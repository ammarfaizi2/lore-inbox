Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261192AbRELHdi>; Sat, 12 May 2001 03:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261195AbRELHd2>; Sat, 12 May 2001 03:33:28 -0400
Received: from cs666822-22.austin.rr.com ([66.68.22.22]:10409 "HELO
	hatchling.taral.net") by vger.kernel.org with SMTP
	id <S261192AbRELHdK>; Sat, 12 May 2001 03:33:10 -0400
Date: Sat, 12 May 2001 02:33:07 -0500
From: Taral <taral@taral.net>
To: linux-kernel@vger.kernel.org
Subject: tty kill character handling problems
Message-ID: <20010512023307.A9339@taral.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the current echok/echoke/echoe handling is wrong. The following
patch should fix the problem, unless I've totally misunderstood this...

--- linux/drivers/char/n_tty.c.orig	Fri May 11 21:45:48 2001
+++ linux/drivers/char/n_tty.c	Fri May 11 22:00:52 2001
@@ -352,7 +352,7 @@
 			spin_unlock_irqrestore(&tty->read_lock, flags);
 			return;
 		}
-		if (!L_ECHOK(tty) || !L_ECHOKE(tty) || !L_ECHOE(tty)) {
+		if (!L_ECHOKE(tty)) {
 			spin_lock_irqsave(&tty->read_lock, flags);
 			tty->read_cnt -= ((tty->read_head - tty->canon_head) &
 					  (N_TTY_BUF_SIZE - 1));

-- 
Taral <taral@taral.net>
Please use PGP/GPG encryption to send me mail.
"Any technology, no matter how primitive, is magic to those who don't
understand it." -- Florence Ambrose
