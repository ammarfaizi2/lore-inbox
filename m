Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVGGWRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVGGWRl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 18:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVGGVd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:33:28 -0400
Received: from coderock.org ([193.77.147.115]:46988 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262316AbVGGVcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:32:09 -0400
Message-Id: <20050707213138.184888000@homer>
Date: Thu, 07 Jul 2005 23:31:38 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Christophe Lucas <clucas@rotomalug.org>,
       domen@coderock.org
Subject: [patch 1/4] drivers/char/ip2/i2lib.c: replace direct assignment with set_current_state()
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
