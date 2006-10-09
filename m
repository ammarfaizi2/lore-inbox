Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751574AbWJIBgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbWJIBgY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 21:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbWJIBgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 21:36:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:50236 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751237AbWJIBgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 21:36:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=UVKY2w2Fr/KAySTpAOWeEpR+Pp+8FQiUPdjyG+7o8GeeBt8+Z5dI6Pted0iH4tjgENiJI4qxEx2jT4gBref/D+2qY6KFwSgksFpbeIzAbdbysVPF7ZWgS8mflk282AWapb6nTiH7Tev7JJT3TOegznJh2hlsSTDg6btq9ThaRXY=
Date: Mon, 9 Oct 2006 05:36:09 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] lockdep: use BUILD_BUG_ON
Message-ID: <20061009013609.GA5346@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 kernel/lockdep.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/kernel/lockdep.c
+++ b/kernel/lockdep.c
@@ -1114,8 +1114,6 @@ static int count_matching_names(struct l
 	return count + 1;
 }
 
-extern void __error_too_big_MAX_LOCKDEP_SUBCLASSES(void);
-
 /*
  * Register a lock's class in the hash-table, if the class is not present
  * yet. Otherwise we look it up. We cache the result in the lock object
@@ -1153,8 +1151,7 @@ #endif
 	 * (or spin_lock_init()) call - which acts as the key. For static
 	 * locks we use the lock object itself as the key.
 	 */
-	if (sizeof(struct lock_class_key) > sizeof(struct lock_class))
-		__error_too_big_MAX_LOCKDEP_SUBCLASSES();
+	BUILD_BUG_ON(sizeof(struct lock_class_key) > sizeof(struct lock_class));
 
 	key = lock->key->subkeys + subclass;
 

