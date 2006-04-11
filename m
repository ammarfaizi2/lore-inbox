Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWDKQak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWDKQak (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 12:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWDKQak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 12:30:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:5789 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751040AbWDKQai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 12:30:38 -0400
Date: Tue, 11 Apr 2006 09:26:56 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: stable@kernel.org, torvalds@osdl.org
Subject: Re: Linux 2.6.16.3
Message-ID: <20060411162656.GB10332@kroah.com>
References: <20060411162620.GA10332@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060411162620.GA10332@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 3933cfc..1450dfe 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 16
-EXTRAVERSION = .2
+EXTRAVERSION = .3
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/security/keys/key.c b/security/keys/key.c
index 99781b7..0e2584e 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -785,6 +785,10 @@ key_ref_t key_create_or_update(key_ref_t
 
 	key_check(keyring);
 
+	key_ref = ERR_PTR(-ENOTDIR);
+	if (keyring->type != &key_type_keyring)
+		goto error_2;
+
 	down_write(&keyring->sem);
 
 	/* if we're going to allocate a new key, we're going to have
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index d65a180..bffa924 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -437,6 +437,7 @@ EXPORT_SYMBOL(keyring_search);
 /*
  * search the given keyring only (no recursion)
  * - keyring must be locked by caller
+ * - caller must guarantee that the keyring is a keyring
  */
 key_ref_t __keyring_search_one(key_ref_t keyring_ref,
 			       const struct key_type *ktype,
