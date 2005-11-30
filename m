Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbVK3SRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbVK3SRk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 13:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbVK3SRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 13:17:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48797 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751494AbVK3SRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 13:17:40 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Keys: Fix permissions check for update vs add
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Wed, 30 Nov 2005 18:17:27 +0000
Message-ID: <32609.1133374647@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch permits add_key() to once again update a matching key
rather than adding a new one if a matching key already exists in the target
keyring.

This bug causes add_key() to always add a new key, displacing the old from the
target keyring.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 keys-permfix-2615rc1.diff 
 security/keys/keyring.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -uNr linux-2.6.15-rc1-keys-reqkey/security/keys/keyring.c linux-2.6.15-rc1-keys-permfix/security/keys/keyring.c
--- linux-2.6.15-rc1-keys-reqkey/security/keys/keyring.c	2005-11-16 17:55:47.000000000 +0000
+++ linux-2.6.15-rc1-keys-permfix/security/keys/keyring.c	2005-11-30 16:24:33.000000000 +0000
@@ -526,7 +526,7 @@
 			    (!key->type->match ||
 			     key->type->match(key, description)) &&
 			    key_permission(make_key_ref(key, possessed),
-					   perm) < 0 &&
+					   perm) == 0 &&
 			    !test_bit(KEY_FLAG_REVOKED, &key->flags)
 			    )
 				goto found;
