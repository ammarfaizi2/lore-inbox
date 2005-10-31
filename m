Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbVJaAdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbVJaAdc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 19:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVJaAdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 19:33:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22290 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932415AbVJaAdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 19:33:32 -0500
Date: Mon, 31 Oct 2005 01:33:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: chrisw@osdl.org
Cc: linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] security/: possible cleanups
Message-ID: <20051031003331.GA8009@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- #if 0 the following unused global function:
  - keys/key.c: key_duplicate

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 security/keys/internal.h |    1 -
 security/keys/key.c      |    4 +++-
 security/keys/keyring.c  |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

--- linux-2.6.12-rc4-mm1-full/security/keys/internal.h.old	2005-05-15 17:11:19.000000000 +0200
+++ linux-2.6.12-rc4-mm1-full/security/keys/internal.h	2005-05-15 17:11:23.000000000 +0200
@@ -25,7 +25,6 @@
 #define kdebug(FMT, a...)	do {} while(0)
 #endif
 
-extern struct key_type key_type_dead;
 extern struct key_type key_type_user;
 
 /*****************************************************************************/
--- linux-2.6.12-rc4-mm1-full/security/keys/key.c.old	2005-05-15 17:09:56.000000000 +0200
+++ linux-2.6.12-rc4-mm1-full/security/keys/key.c	2005-05-15 17:11:11.000000000 +0200
@@ -35,7 +35,7 @@
 DECLARE_RWSEM(key_construction_sem);
 
 /* any key who's type gets unegistered will be re-typed to this */
-struct key_type key_type_dead = {
+static struct key_type key_type_dead = {
 	.name		= "dead",
 };
 
@@ -860,6 +860,7 @@
  * duplicate a key, potentially with a revised description
  * - must be supported by the keytype (keyrings for instance can be duplicated)
  */
+#if 0
 struct key *key_duplicate(struct key *source, const char *desc)
 {
 	struct key *key;
@@ -904,6 +905,7 @@
 	goto out;
 
 } /* end key_duplicate() */
+#endif  /*  0  */
 
 /*****************************************************************************/
 /*
--- linux-2.6.12-rc4-mm1-full/security/keys/keyring.c.old	2005-05-15 17:12:43.000000000 +0200
+++ linux-2.6.12-rc4-mm1-full/security/keys/keyring.c	2005-05-15 17:12:53.000000000 +0200
@@ -69,7 +69,7 @@
  * semaphore to serialise link/link calls to prevent two link calls in parallel
  * introducing a cycle
  */
-DECLARE_RWSEM(keyring_serialise_link_sem);
+static DECLARE_RWSEM(keyring_serialise_link_sem);
 
 /*****************************************************************************/
 /*
