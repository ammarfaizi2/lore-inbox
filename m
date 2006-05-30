Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWE3LLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWE3LLS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 07:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWE3LLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 07:11:18 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:32473 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932254AbWE3LLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 07:11:17 -0400
Date: Tue, 30 May 2006 13:11:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>
Subject: [patch, -rc5-mm1] lock validator, fix NULL type->name bug
Message-ID: <20060530111138.GA5078@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530022925.8a67b613.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: lock validator, fix NULL type->name bug
From: Ingo Molnar <mingo@elte.hu>

this should fix the bug reported Mike Galbraith: pass in a non-NULL 
mutex name string even if DEBUG_MUTEXES is turned off.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/mutex.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/include/linux/mutex.h
===================================================================
--- linux.orig/include/linux/mutex.h
+++ linux/include/linux/mutex.h
@@ -80,7 +80,7 @@ struct mutex_waiter {
 do {							\
 	static struct lockdep_type_key __key;		\
 							\
-	__mutex_init((mutex), NULL, &__key);		\
+	__mutex_init((mutex), #mutex, &__key);		\
 } while (0)
 # define mutex_destroy(mutex)				do { } while (0)
 #endif
