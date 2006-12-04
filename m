Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936577AbWLDSDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936577AbWLDSDq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 13:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936604AbWLDSDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 13:03:46 -0500
Received: from wmail-1.airmail.net ([209.196.70.86]:50064 "EHLO
	wmail-1.airmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936593AbWLDSDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 13:03:45 -0500
From: "Art Haas" <ahaas@airmail.net>
Date: Mon, 4 Dec 2006 12:03:11 -0600
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] Remove 'volatile' from spinlocks
Message-ID: <20061204180311.GD22454@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Months ago two patches were posted by Ingo Molnar that removed
the 'volatile' keyword from the 'raw_spinlock_t' and 'raw_rwlock_t'
structures in the i386 and x86-64 ports. The link below takes you to
the initial (?) posting of the patches:

http://marc.theaimsgroup.com/?l=linux-kernel&m=115217423929806&w=2

I've been build and running SMP kernels on a dual PIII machine with
the i386 version of the patch since then and the kernels have worked
well. Perhaps the patch(es) can make it into the 2.6.20 kernel?

The i386 version of the patch is below, the x86-64 patch is identical.

Art Haas

diff --git a/include/asm-i386/spinlock_types.h b/include/asm-i386/spinlock_types.h
index 59efe84..4da9345 100644
--- a/include/asm-i386/spinlock_types.h
+++ b/include/asm-i386/spinlock_types.h
@@ -6,13 +6,13 @@ # error "please don't include this file 
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
