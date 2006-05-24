Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932571AbWEXEki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbWEXEki (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 00:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbWEXEkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 00:40:37 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:12990 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932571AbWEXEkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 00:40:37 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus@valinux.co.jp>, vgoyal@in.ibm.com,
       ebiederm@xmission.com
Message-Id: <20060524044237.14219.15615.sendpatchset@cherry.local>
In-Reply-To: <20060524044232.14219.68240.sendpatchset@cherry.local>
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
Subject: [PATCH 01/03] kexec: Avoid overwriting the current pgd (V2, stubs)
Date: Wed, 24 May 2006 13:40:36 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kexec: Avoid overwriting the current pgd (V2, stubs)

This patch adds an architecture specific structure "struct kimage_arch" to 
struct kimage. This structure is filled in with members by the architecture
specific patches followed by this one.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 Applies on top of 2.6.16 and 2.6.17-rc4.

 asm-i386/kexec.h    |    2 ++
 asm-powerpc/kexec.h |    2 ++
 asm-s390/kexec.h    |    2 ++
 asm-sh/kexec.h      |    2 ++
 asm-x86_64/kexec.h  |    2 ++
 linux/kexec.h       |    2 ++
 6 files changed, 12 insertions(+)

--- 0001/include/asm-i386/kexec.h
+++ work/include/asm-i386/kexec.h	2006-05-19 11:54:07.000000000 +0900
@@ -29,6 +29,8 @@
 
 #define MAX_NOTE_BYTES 1024
 
+struct kimage_arch {};
+
 /* CPU does not save ss and esp on stack if execution is already
  * running in kernel mode at the time of NMI occurrence. This code
  * fixes it.
--- 0001/include/asm-powerpc/kexec.h
+++ work/include/asm-powerpc/kexec.h	2006-05-18 11:13:13.000000000 +0900
@@ -108,6 +108,8 @@ static inline void crash_setup_regs(stru
 
 #define MAX_NOTE_BYTES 1024
 
+struct kimage_arch {};
+
 #ifdef __powerpc64__
 extern void kexec_smp_wait(void);	/* get and clear naca physid, wait for
 					  master to copy new code to 0 */
--- 0001/include/asm-s390/kexec.h
+++ work/include/asm-s390/kexec.h	2006-05-18 11:13:13.000000000 +0900
@@ -36,6 +36,8 @@
 
 #define MAX_NOTE_BYTES 1024
 
+struct kimage_arch {};
+
 /* Provide a dummy definition to avoid build failures. */
 static inline void crash_setup_regs(struct pt_regs *newregs,
 					struct pt_regs *oldregs) { }
--- 0001/include/asm-sh/kexec.h
+++ work/include/asm-sh/kexec.h	2006-05-18 11:13:13.000000000 +0900
@@ -25,6 +25,8 @@
 
 #ifndef __ASSEMBLY__
 
+struct kimage_arch {};
+
 extern void machine_shutdown(void);
 extern void *crash_notes;
 
--- 0001/include/asm-x86_64/kexec.h
+++ work/include/asm-x86_64/kexec.h	2006-05-18 11:13:13.000000000 +0900
@@ -29,6 +29,8 @@
 
 #define MAX_NOTE_BYTES 1024
 
+struct kimage_arch {};
+
 /*
  * Saving the registers of the cpu on which panic occured in
  * crash_kexec to save a valid sp. The registers of other cpus
--- 0001/include/linux/kexec.h
+++ work/include/linux/kexec.h	2006-05-18 11:13:13.000000000 +0900
@@ -69,6 +69,8 @@ struct kimage {
 	unsigned long start;
 	struct page *control_code_page;
 
+	struct kimage_arch arch_data;
+
 	unsigned long nr_segments;
 	struct kexec_segment segment[KEXEC_SEGMENT_MAX];
 
