Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTDVTtZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263414AbTDVTtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:49:25 -0400
Received: from CPE00c0f0141dc1-CM014160001801.cpe.net.cable.rogers.com ([24.42.47.5]:52918
	"EHLO muon.jukie.net") by vger.kernel.org with ESMTP
	id S263407AbTDVTtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:49:23 -0400
Date: Tue, 22 Apr 2003 16:01:28 -0400
From: Bart Trojanowski <bart@jukie.net>
To: linux-kernel@vger.kernel.org
Cc: kernel-janitor-discuss@lists.sourceforge.net, trivial@rustcorp.com.au
Subject: [PATCH 2.4.20] added missing functions to include/asm-arm/atomic.h
Message-ID: <20030422160128.G1364@jukie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While porting a piece of code from i386 to arm, I've noticed that two
atomic operations are missing from the asm-arm/atomic.h interface.

The patch below adds these two missing functions with an aim of filling
in the compatibility hole.

Regards,
Bart.

--- linux-2.4.20/include/asm-arm/atomic.h.orig	Tue Apr 22 15:37:48 2003
+++ linux-2.4.20/include/asm-arm/atomic.h	Tue Apr 22 15:42:23 2003
@@ -68,6 +68,32 @@
 	__restore_flags(flags);
 }
 
+static __inline__ int atomic_sub_and_test(int i, volatile atomic_t *v)
+{
+	unsigned long flags;
+	int result;
+
+	__save_flags_cli(flags);
+	v->counter -= i;
+	result = (v->counter == 0);
+	__restore_flags(flags);
+
+	return result;
+}
+
+static __inline__ int atomic_inc_and_test(volatile atomic_t *v)
+{
+	unsigned long flags;
+	int result;
+
+	__save_flags_cli(flags);
+	v->counter += 1;
+	result = (v->counter == 0);
+	__restore_flags(flags);
+
+	return result;
+}
+
 static __inline__ int atomic_dec_and_test(volatile atomic_t *v)
 {
 	unsigned long flags;

