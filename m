Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319017AbSIDCbC>; Tue, 3 Sep 2002 22:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319015AbSIDCbC>; Tue, 3 Sep 2002 22:31:02 -0400
Received: from dp.samba.org ([66.70.73.150]:22463 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319014AbSIDCbB>;
	Tue, 3 Sep 2002 22:31:01 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, davem@vger.kernel.org, akpm@zip.com.au
Subject: [PATCH] Important per-cpu fix.
Date: Wed, 04 Sep 2002 12:35:41 +1000
Message-Id: <20020904023535.73D922C12D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frankly, I'm amazed the kernel worked for long without this.

Every linker script thinks the section is called .data.percpu.
Without this patch, every CPU ends up sharing the same "per-cpu"
variable.

This might explain the wierd per-cpu problem reports from Andrew and
Dave, and also that nagging feeling that I'm an idiot...

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

--- working-2.5.33-hotcpu-cpudown-i386/include/asm-generic/percpu.h.~1~	Wed Aug 28 09:29:50 2002
+++ working-2.5.33-hotcpu-cpudown-i386/include/asm-generic/percpu.h	Wed Sep  4 12:32:34 2002
@@ -10,7 +10,7 @@
 /* Separate out the type, so (int[3], foo) works. */
 #ifndef MODULE
 #define DEFINE_PER_CPU(type, name) \
-    __attribute__((__section__(".percpu"))) __typeof__(type) name##__per_cpu
+    __attribute__((__section__(".data.percpu"))) __typeof__(type) name##__per_cpu
 #endif
 
 /* var is in discarded region: offset to particular copy we want */
