Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262676AbVBYLg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbVBYLg6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 06:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVBYLg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 06:36:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27838 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262676AbVBYLgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 06:36:55 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050225015755.14B611BAA9@citi.umich.edu> 
References: <20050225015755.14B611BAA9@citi.umich.edu> 
To: torvalds@osdl.org, akpm@osdl.org, kwc@citi.umich.edu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Make keyctl(KEYCTL_JOIN_SESSION_KEYRING) use the correct arg
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Fri, 25 Feb 2005 11:36:42 +0000
Message-ID: <15706.1109331402@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch makes keyctl() use the correct argument when invoking the
KEYCTL_JOIN_SESSION_KEYRING function.

I'm not sure how this evaded testing before, but I suspect the compiler was
kind and made both argument registers hold the same value.

Thanks to Kevin Coffman <kwc@citi.umich.edu> for spotting this.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 keys-joinsess-2611rc4.diff 
 security/keys/compat.c |    2 +-
 security/keys/keyctl.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -uNr linux-2.6.11-rc4/security/keys/compat.c linux-2.6.11-rc4-keys-task/security/keys/compat.c
--- linux-2.6.11-rc4/security/keys/compat.c	2005-01-04 11:14:01.000000000 +0000
+++ linux-2.6.11-rc4-keys-task/security/keys/compat.c	2005-02-25 11:02:33.853339509 +0000
@@ -31,7 +31,7 @@
 		return keyctl_get_keyring_ID(arg2, arg3);
 
 	case KEYCTL_JOIN_SESSION_KEYRING:
-		return keyctl_join_session_keyring(compat_ptr(arg3));
+		return keyctl_join_session_keyring(compat_ptr(arg2));
 
 	case KEYCTL_UPDATE:
 		return keyctl_update_key(arg2, compat_ptr(arg3), arg4);
diff -uNr linux-2.6.11-rc4/security/keys/keyctl.c linux-2.6.11-rc4-keys-task/security/keys/keyctl.c
--- linux-2.6.11-rc4/security/keys/keyctl.c	2005-01-04 11:14:01.000000000 +0000
+++ linux-2.6.11-rc4-keys-task/security/keys/keyctl.c	2005-02-25 11:02:24.134152856 +0000
@@ -923,7 +923,7 @@
 					     (int) arg3);
 
 	case KEYCTL_JOIN_SESSION_KEYRING:
-		return keyctl_join_session_keyring((const char __user *) arg3);
+		return keyctl_join_session_keyring((const char __user *) arg2);
 
 	case KEYCTL_UPDATE:
 		return keyctl_update_key((key_serial_t) arg2,
