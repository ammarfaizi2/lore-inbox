Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271431AbRHPE2q>; Thu, 16 Aug 2001 00:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271433AbRHPE22>; Thu, 16 Aug 2001 00:28:28 -0400
Received: from trained-monkey.org ([209.217.122.11]:32504 "EHLO
	savage.trained-monkey.org") by vger.kernel.org with ESMTP
	id <S271431AbRHPE2S>; Thu, 16 Aug 2001 00:28:18 -0400
Date: Thu, 16 Aug 2001 00:26:36 -0400
Message-Id: <200108160426.f7G4QaA19434@savage.trained-monkey.org>
From: <jes@trained-monkey.org>
To: olivier.lebaillif@ifrsys.com
CC: alan@redhat.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] dz.c 64 bit locking issues
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

The dz.c driver has an instance where it does save_flags() to a 32 bit
type which isn't safe for 64 bit boxen.

Jes

--- drivers/char/dz.c~	Wed Jul  4 17:41:33 2001
+++ drivers/char/dz.c	Thu Aug 16 00:24:48 2001
@@ -1279,7 +1279,8 @@
 
 int __init dz_init(void)
 {
-  int i, flags;
+  int i;
+  unsigned long flags;
   struct dz_serial *info;
 
   /* Setup base handler, and timer table. */
