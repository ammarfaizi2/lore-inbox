Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVAMPdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVAMPdI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 10:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVAMPbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 10:31:41 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:58628 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261655AbVAMPbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 10:31:07 -0500
Subject: [patch 1/8] uml: avoid NULL dereference in line.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it,
       frank@tuxrocks.com
From: blaisorblade_spam@yahoo.it
Date: Thu, 13 Jan 2005 06:13:24 +0100
Message-Id: <20050113051325.63FB163245@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Frank Sorenson <frank@tuxrocks.com>

This patch reorders two lines to check a variable for NULL before using 
the variable.

Signed-off-by: Frank Sorenson <frank@tuxrocks.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/drivers/line.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/drivers/line.c~uml-reorder_null_check arch/um/drivers/line.c
--- linux-2.6.11/arch/um/drivers/line.c~uml-reorder_null_check	2005-01-13 01:54:17.163057872 +0100
+++ linux-2.6.11-paolo/arch/um/drivers/line.c	2005-01-13 01:54:17.166057416 +0100
@@ -593,8 +593,8 @@ irqreturn_t winch_interrupt(int irq, voi
 		}
 	}
 	tty  = winch->tty;
-	line = tty->driver_data;
 	if (tty != NULL) {
+		line = tty->driver_data;
 		chan_window_size(&line->chan_list,
 				 &tty->winsize.ws_row, 
 				 &tty->winsize.ws_col);
_
