Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263154AbUDUOvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbUDUOvY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 10:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUDUOun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 10:50:43 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:23474 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S263125AbUDUOrC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 10:47:02 -0400
Date: Wed, 21 Apr 2004 16:46:47 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (3/9): 3270 device driver.
Message-ID: <20040421144647.GD2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: 3270 device driver.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

3270 device driver changes:
 - Add NULL pointer checks.

diffstat:
 drivers/s390/char/raw3270.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -urN linux-2.6/drivers/s390/char/raw3270.c linux-2.6-s390/drivers/s390/char/raw3270.c
--- linux-2.6/drivers/s390/char/raw3270.c	Sun Apr  4 05:37:45 2004
+++ linux-2.6-s390/drivers/s390/char/raw3270.c	Wed Apr 21 16:29:36 2004
@@ -381,6 +381,8 @@
 			return;	/* Sucessfully restarted. */
 		break;
 	case RAW3270_IO_STOP:
+		if (!rq)
+			break;
 		raw3270_halt_io_nolock(rp, rq);
 		rq->rc = -EIO;
 		break;
@@ -881,7 +883,7 @@
 		if (rc) {
 			/* Didn't work. Try to reactivate the old view. */
 			rp->view = oldview;
-			if (oldview->fn->activate(oldview) != 0) {
+			if (!oldview || oldview->fn->activate(oldview) != 0) {
 				/* Didn't work as well. Try any other view. */
 				list_for_each_entry(nv, &rp->view_list, list)
 					if (nv != view && nv != oldview) {
