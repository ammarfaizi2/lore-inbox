Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbWIIXjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbWIIXjt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 19:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWIIXjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 19:39:48 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:51882 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S965018AbWIIXjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 19:39:48 -0400
Message-ID: <45034FFA.8000605@goop.org>
Date: Sat, 09 Sep 2006 16:36:26 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix asm-i386/desc.h:pack_descriptor()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix pack_descriptor:
 1. flags are bits 20-23 in the high word
 2. limit's 4 msb are bits 16-19 in the high word

These haven't mattered so far, because all users have had small limits
and a flags setting of 0.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

===================================================================
--- a/include/asm-i386/desc.h
+++ b/include/asm-i386/desc.h
@@ -41,7 +41,7 @@ static inline void pack_descriptor(__u32
 {
 	*a = ((base & 0xffff) << 16) | (limit & 0xffff);
 	*b = (base & 0xff000000) | ((base & 0xff0000) >> 16) |
-	     ((type & 0xff) << 8) | ((flags & 0xf) << 12);
+		(limit & 0x000f0000) | ((type & 0xff) << 8) | ((flags & 0xf) << 20);
 }
 
 static inline void pack_gate(__u32 *a, __u32 *b,


