Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030432AbWBQOto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030432AbWBQOto (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 09:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWBQOto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 09:49:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39570 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964913AbWBQOtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 09:49:43 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Keys: Fix key quota management on key allocation
X-Mailer: MH-E 7.91+cvs; nmh 1.1; GNU Emacs 22.0.50.1
Date: Fri, 17 Feb 2006 14:49:33 +0000
Message-ID: <8141.1140187773@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch makes key quota detection generate an error if either quota
is exceeded rather than only if both quotas are exceeded.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 keys-quota-2616rc3.diff 
 security/keys/key.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -uNrp linux-2.6.16-rc3/security/keys/key.c linux-2.6.16-rc3-key-quota/security/keys/key.c
--- linux-2.6.16-rc3/security/keys/key.c	2006-02-15 11:17:01.000000000 +0000
+++ linux-2.6.16-rc3-key-quota/security/keys/key.c	2006-02-17 14:26:27.000000000 +0000
@@ -1,6 +1,6 @@
 /* key.c: basic authentication token and access key management
  *
- * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2004-6 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
  * This program is free software; you can redistribute it and/or
@@ -271,7 +271,7 @@ struct key *key_alloc(struct key_type *t
 	 * its description */
 	if (!not_in_quota) {
 		spin_lock(&user->lock);
-		if (user->qnkeys + 1 >= KEYQUOTA_MAX_KEYS &&
+		if (user->qnkeys + 1 >= KEYQUOTA_MAX_KEYS ||
 		    user->qnbytes + quotalen >= KEYQUOTA_MAX_BYTES
 		    )
 			goto no_quota;
