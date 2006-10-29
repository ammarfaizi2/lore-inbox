Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbWJ2VFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWJ2VFG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 16:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWJ2VFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 16:05:06 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:34077 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030262AbWJ2VFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 16:05:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=H8rjcsvceqOFlMBTrDQtv4M5vn/qRwfY1ZH93Q/pT9gF/1KrTQmDzAex2acn871BVcHoW58fq+UI7PHK5jqoDYPKEiAAflKEbQc0QTX7scleV+RKi5du5kZwxwfYQe9SgAaSpYXI8zII6Uu9KQJEqopNg1FNAi4lt3jkh3tf6F4=
Date: Sun, 29 Oct 2006 23:03:16 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       Eric Sesterhenn <snakebyte@gmx.de>
Subject: [PATCH] security/keys/*: user kmemdup()
Message-ID: <20061029200316.GD4900@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sesterhenn <snakebyte@gmx.de>

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 security/keys/key.c     |    4 +---
 security/keys/keyring.c |    4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -290,11 +290,9 @@ struct key *key_alloc(struct key_type *t
 		goto no_memory_2;
 
 	if (desc) {
-		key->description = kmalloc(desclen, GFP_KERNEL);
+		key->description = kmemdup(desc, desclen, GFP_KERNEL);
 		if (!key->description)
 			goto no_memory_3;
-
-		memcpy(key->description, desc, desclen);
 	}
 
 	atomic_set(&key->usage, 1);
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -706,12 +706,10 @@ int __key_link(struct key *keyring, stru
 				BUG_ON(size > PAGE_SIZE);
 
 				ret = -ENOMEM;
-				nklist = kmalloc(size, GFP_KERNEL);
+				nklist = kmemdup(klist, size, GFP_KERNEL);
 				if (!nklist)
 					goto error2;
 
-				memcpy(nklist, klist, size);
-
 				/* replace matched key */
 				atomic_inc(&key->usage);
 				nklist->keys[loop] = key;

