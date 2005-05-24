Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVEXXaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVEXXaV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 19:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVEXXaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 19:30:21 -0400
Received: from [151.97.230.9] ([151.97.230.9]:5388 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S262162AbVEXXaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 19:30:15 -0400
Subject: [patch 1/1] Cleanup DEFINE_WAIT
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Wed, 25 May 2005 01:31:42 +0200
Message-Id: <20050524233142.E7F59A8683@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use LIST_HEAD_INIT rather than doing it by hand in DEFINE_WAIT.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/linux/wait.h |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff -puN include/linux/wait.h~clean-use-list-init include/linux/wait.h
--- linux-2.6.git/include/linux/wait.h~clean-use-list-init	2005-05-25 01:28:20.000000000 +0200
+++ linux-2.6.git-paolo/include/linux/wait.h	2005-05-25 01:28:20.000000000 +0200
@@ -386,9 +386,7 @@ int wake_bit_function(wait_queue_t *wait
 	wait_queue_t name = {						\
 		.task		= current,				\
 		.func		= autoremove_wake_function,		\
-		.task_list	= {	.next = &(name).task_list,	\
-					.prev = &(name).task_list,	\
-				},					\
+		.task_list	= LIST_HEAD_INIT((name).task_list),	\
 	}
 
 #define DEFINE_WAIT_BIT(name, word, bit)				\
_
