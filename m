Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVALKVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVALKVw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 05:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVALKVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 05:21:52 -0500
Received: from ozlabs.org ([203.10.76.45]:39836 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261311AbVALKVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 05:21:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16868.64050.640925.128469@cargo.ozlabs.ibm.com>
Date: Wed, 12 Jan 2005 21:21:38 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: anton@samba.org, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 had _raw_read_trylock already
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo presumably didn't notice that ppc64 already had a functional
_raw_read_trylock when he added the #define to use the generic
version.  This just removes the #define so we use the ppc64-specific
version again.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/include/asm-ppc64/spinlock.h test/include/asm-ppc64/spinlock.h
--- linux-2.5/include/asm-ppc64/spinlock.h	2005-01-10 07:54:29.000000000 +1100
+++ test/include/asm-ppc64/spinlock.h	2005-01-10 09:44:16.000000000 +1100
@@ -222,8 +222,6 @@
 	: "cr0", "memory");
 }
 
-#define _raw_read_trylock(lock) generic_raw_read_trylock(lock)
-
 /*
  * This returns the old value in the lock,
  * so we got the write lock if the return value is 0.
