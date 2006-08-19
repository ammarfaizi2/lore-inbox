Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWHSRiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWHSRiD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 13:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbWHSRiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 13:38:01 -0400
Received: from mail.gmx.de ([213.165.64.20]:11227 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751500AbWHSRiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 13:38:01 -0400
X-Authenticated: #704063
Subject: [Patch] Signedness issue in drivers/net/3c515.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: becker@scyld.com
Content-Type: text/plain
Date: Sat, 19 Aug 2006 19:37:57 +0200
Message-Id: <1156009077.18374.1.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

while playing with gcc 4.1 -Wextra warnings, I came across this one:

drivers/net/3c515.c:1027: warning: comparison of unsigned expression >= 0 is always true

Since i is unsigned the >= 0 check in the for loop is always true,
so we might spin there forever unless the if condition triggers.
Since i is only used in this loop, this patch changes it to
an integer.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-rc4/drivers/net/3c515.c.orig	2006-08-19 19:35:04.000000000 +0200
+++ linux-2.6.18-rc4/drivers/net/3c515.c	2006-08-19 19:35:14.000000000 +0200
@@ -1003,7 +1003,8 @@ static int corkscrew_start_xmit(struct s
 		/* Calculate the next Tx descriptor entry. */
 		int entry = vp->cur_tx % TX_RING_SIZE;
 		struct boom_tx_desc *prev_entry;
-		unsigned long flags, i;
+		unsigned long flags;
+		int i;
 
 		if (vp->tx_full)	/* No room to transmit with */
 			return 1;


