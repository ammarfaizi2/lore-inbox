Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262578AbVEMWkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbVEMWkw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 18:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbVEMWkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 18:40:11 -0400
Received: from coderock.org ([193.77.147.115]:54677 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262589AbVEMWZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 18:25:02 -0400
Message-Id: <20050513222405.913399000@nd47.coderock.org>
Date: Sat, 14 May 2005 00:24:06 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Christophe Lucas <clucas@rotomalug.org>,
       domen@coderock.org
Subject: [patch 1/3] drivers/char/ip2/i2lib.c: replace direct assignment with set_current_state()
Content-Disposition: inline; filename=set_current_state-drivers_char_ip2_i2lib
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Lucas <clucas@rotomalug.org>



Use set_current_state() instead of direct assignment of
current->state.

Signed-off-by: Christophe Lucas <clucas@rotomalug.org>
Signed-off-by: Domen Puncer <domen@coderock.org>


---
 i2lib.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: quilt/drivers/char/ip2/i2lib.c
===================================================================
--- quilt.orig/drivers/char/ip2/i2lib.c
+++ quilt/drivers/char/ip2/i2lib.c
@@ -655,7 +655,7 @@ i2QueueCommands(int type, i2ChanStrPtr p
 			timeout--;   // So negative values == forever
 		
 		if (!in_interrupt()) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(1);	// short nap 
 		} else {
 			// we cannot sched/sleep in interrrupt silly
@@ -1132,7 +1132,7 @@ i2Output(i2ChanStrPtr pCh, const char *p
 
 					ip2trace (CHANN, ITRC_OUTPUT, 61, 0 );
 
-					current->state = TASK_INTERRUPTIBLE;
+					set_current_state(TASK_INTERRUPTIBLE);
 					schedule_timeout(2);
 					if (signal_pending(current)) {
 						break;

--
