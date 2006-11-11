Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947317AbWKKVtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947317AbWKKVtJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 16:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947311AbWKKVtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 16:49:08 -0500
Received: from cacti2.profiwh.com ([85.93.165.64]:5290 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1947313AbWKKVtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 16:49:01 -0500
Message-id: <15630210681376711290@wsc.cz>
In-reply-to: <196416110522272@wsc.cz>
Subject: [PATCH 5/5] Char: istallion, use mod_timer
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat, 11 Nov 2006 22:49:12 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

istallion, use mod_timer

do not set expires by hand, use kernel helper, which also calls add_timer.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit fc0e3ad83dbfac6d4b245319faff5f726974a3cf
tree 00cda6f05eb6e27a5e5043b0ce7e4fb512ea7287
parent 010cb3032661418012dd0949ff3566927ed430cd
author Jiri Slaby <jirislaby@gmail.com> Sat, 11 Nov 2006 02:32:18 +0100
committer Jiri Slaby <jirislaby@gmail.com> Sat, 11 Nov 2006 22:23:37 +0100

 drivers/char/istallion.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
index cbbc3cd..7f5b8d8 100644
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -2545,8 +2545,7 @@ static void stli_poll(unsigned long arg)
 	struct stlibrd *brdp;
 	unsigned int brdnr;
 
-	stli_timerlist.expires = STLI_TIMEOUT;
-	add_timer(&stli_timerlist);
+	mod_timer(&stli_timerlist, STLI_TIMEOUT);
 
 /*
  *	Check each board and do any servicing required.
@@ -3610,8 +3609,7 @@ stli_donestartup:
 
 	if (! stli_timeron) {
 		stli_timeron++;
-		stli_timerlist.expires = STLI_TIMEOUT;
-		add_timer(&stli_timerlist);
+		mod_timer(&stli_timerlist, STLI_TIMEOUT);
 	}
 
 	return rc;
