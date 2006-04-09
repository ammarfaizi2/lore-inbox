Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWDIRGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWDIRGL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 13:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWDIRGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 13:06:11 -0400
Received: from mail.gmx.de ([213.165.64.20]:3009 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750732AbWDIRGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 13:06:09 -0400
X-Authenticated: #704063
Subject: [Patch] Wrong out of range check in drivers/char/applicom.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: dwmw2@infradead.org
Content-Type: text/plain
Date: Sun, 09 Apr 2006 19:06:06 +0200
Message-Id: <1144602367.19348.3.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this fixes coverity bug id #469. The out of range check didnt
work as intended, as seen by the printk(), which states that 
boardno has to be 1 <= boardno <= MAX_BOARD.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-rc1/drivers/char/applicom.c.orig	2006-04-09 18:57:29.000000000 +0200
+++ linux-2.6.17-rc1/drivers/char/applicom.c	2006-04-09 18:57:55.000000000 +0200
@@ -142,7 +142,7 @@ static int ac_register_board(unsigned lo
 	if (!boardno)
 		boardno = readb(loc + NUMCARD_OWNER_TO_PC);
 
-	if (!boardno && boardno > MAX_BOARD) {
+	if (!boardno || boardno > MAX_BOARD) {
 		printk(KERN_WARNING "Board #%d (at 0x%lx) is out of range (1 <= x <= %d).\n",
 		       boardno, physloc, MAX_BOARD);
 		return 0;


