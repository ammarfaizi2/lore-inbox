Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVKAORE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVKAORE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 09:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbVKAORE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 09:17:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23016 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750806AbVKAORC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 09:17:02 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <11615.1128694058@warthog.cambridge.redhat.com> 
References: <11615.1128694058@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org, pageexec@freemail.hu
Cc: keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Keys: Remove incorrect and obsolete '!' operators
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 01 Nov 2005 14:16:39 +0000
Message-ID: <23655.1130854599@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch removes a couple of incorrect and obsolete '!' operators
left over from the conversion of the key permission functions from true/false
returns to zero/error returns.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 keys-debang-2614rc5mm1.diff
 security/keys/keyring.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -uNrp linux-2.6.14-rc5-mm1/security/keys/keyring.c linux-2.6.14-rc5-mm1-keys/security/keys/keyring.c
--- linux-2.6.14-rc5-mm1/security/keys/keyring.c	2005-11-01 13:22:53.000000000 +0000
+++ linux-2.6.14-rc5-mm1-keys/security/keys/keyring.c	2005-11-01 13:40:52.000000000 +0000
@@ -434,8 +434,8 @@ ascend:
 		if (sp >= KEYRING_SEARCH_MAX_DEPTH)
 			continue;
 
-		if (!key_task_permission(make_key_ref(key, possessed),
-					 context, KEY_SEARCH) < 0)
+		if (key_task_permission(make_key_ref(key, possessed),
+					context, KEY_SEARCH) < 0)
 			continue;
 
 		/* stack the current position */
@@ -621,8 +621,8 @@ struct key *find_keyring_by_name(const c
 			if (strcmp(keyring->description, name) != 0)
 				continue;
 
-			if (!key_permission(make_key_ref(keyring, 0),
-					    KEY_SEARCH) < 0)
+			if (key_permission(make_key_ref(keyring, 0),
+					   KEY_SEARCH) < 0)
 				continue;
 
 			/* found a potential candidate, but we still need to
