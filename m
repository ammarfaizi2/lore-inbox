Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164234AbWLHAlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164234AbWLHAlj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 19:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164239AbWLHAlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 19:41:39 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:52521 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1164234AbWLHAli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 19:41:38 -0500
Date: Fri, 8 Dec 2006 00:41:30 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove useless memory barrier.
Message-ID: <20061208004129.GA17754@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see why there is a memory barrier in copy_from_read_buf() at all.
Even if it was useful spin_unlock_irqrestore implies a barrier.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/drivers/char/n_tty.c b/drivers/char/n_tty.c
index 603b9ad..8df7ff3 100644
--- a/drivers/char/n_tty.c
+++ b/drivers/char/n_tty.c
@@ -1151,7 +1151,6 @@ static int copy_from_read_buf(struct tty
 	n = min(*nr, n);
 	spin_unlock_irqrestore(&tty->read_lock, flags);
 	if (n) {
-		mb();
 		retval = copy_to_user(*b, &tty->read_buf[tty->read_tail], n);
 		n -= retval;
 		spin_lock_irqsave(&tty->read_lock, flags);
