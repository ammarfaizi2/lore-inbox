Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937628AbWLFUqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937628AbWLFUqp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 15:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937630AbWLFUqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 15:46:45 -0500
Received: from wmail-2.airmail.net ([209.196.70.85]:58188 "EHLO
	wmail-2.airmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937628AbWLFUqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 15:46:45 -0500
From: "Art Haas" <ahaas@airmail.net>
Date: Wed, 6 Dec 2006 14:45:53 -0600
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] Remove 'volatile' from spinlock_types
Message-ID: <20061206204553.GC3107@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This is a resubmission of patches originally created by Ingo Molnar.
The link below is the initial (?) posting of the patch.

http://marc.theaimsgroup.com/?l=linux-kernel&m=115217423929806&w=2

Remove 'volatile' from spinlock_types as it causes GCC to generate
bad code (see link) and locking should be used on kernel data.

Signed-off-by: Art Haas <ahaas@airmail.net>
---
diff --git a/include/asm-i386/spinlock_types.h b/include/asm-i386/spinlock_types.h
index 59efe84..4da9345 100644
--- a/include/asm-i386/spinlock_types.h
+++ b/include/asm-i386/spinlock_types.h
@@ -6,13 +6,13 @@
 #endif
 
 typedef struct {
-	volatile unsigned int slock;
+	unsigned int slock;
 } raw_spinlock_t;
 
 #define __RAW_SPIN_LOCK_UNLOCKED	{ 1 }
 
 typedef struct {
-	volatile unsigned int lock;
+	unsigned int lock;
 } raw_rwlock_t;
 
 #define __RAW_RW_LOCK_UNLOCKED		{ RW_LOCK_BIAS }
diff --git a/include/asm-x86_64/spinlock_types.h b/include/asm-x86_64/spinlock_types.h
index 59efe84..4da9345 100644
--- a/include/asm-x86_64/spinlock_types.h
+++ b/include/asm-x86_64/spinlock_types.h
@@ -6,13 +6,13 @@
 #endif
 
 typedef struct {
-	volatile unsigned int slock;
+	unsigned int slock;
 } raw_spinlock_t;
 
 #define __RAW_SPIN_LOCK_UNLOCKED	{ 1 }
 
 typedef struct {
-	volatile unsigned int lock;
+	unsigned int lock;
 } raw_rwlock_t;
 
 #define __RAW_RW_LOCK_UNLOCKED		{ RW_LOCK_BIAS }
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
