Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264291AbTCXRPR>; Mon, 24 Mar 2003 12:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264290AbTCXQtc>; Mon, 24 Mar 2003 11:49:32 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:52970 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264289AbTCXQbA>; Mon, 24 Mar 2003 11:31:00 -0500
Message-Id: <200303241642.h2OGgA35008324@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:57 +0000
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: mark context switch wrmsr path unlikely
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/include/asm-i386/processor.h linux-2.5/include/asm-i386/processor.h
--- bk-linus/include/asm-i386/processor.h	2003-03-21 12:53:30.000000000 +0000
+++ linux-2.5/include/asm-i386/processor.h	2003-03-21 13:45:20.000000000 +0000
@@ -419,7 +419,7 @@ static inline void load_esp0(struct tss_
 {
 	tss->esp0 = esp0;
 	/* This can only happen when SEP is enabled, no need to test "SEP"arately */
-	if (tss->ss1 != __KERNEL_CS) {
+	if ((unlikely(tss->ss1 != __KERNEL_CS))) {
 		tss->ss1 = __KERNEL_CS;
 		wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
 	}
