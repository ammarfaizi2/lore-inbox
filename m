Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967951AbWK3XBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967951AbWK3XBf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 18:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967949AbWK3XBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 18:01:08 -0500
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:63824 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S967953AbWK3XBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 18:01:05 -0500
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.19 06/10] Add kmemleak support for ARM
To: linux-kernel@vger.kernel.org
Date: Thu, 30 Nov 2006 23:01:01 +0000
Message-ID: <20061130230100.5469.55277.stgit@localhost.localdomain>
In-Reply-To: <20061130225219.5469.2453.stgit@localhost.localdomain>
References: <20061130225219.5469.2453.stgit@localhost.localdomain>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the vmlinux.lds.S script and adds the backtrace support
for ARM to be used with kmemleak.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 arch/arm/kernel/vmlinux.lds.S |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index a8fa75e..7ec22ad 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -61,6 +61,11 @@ SECTIONS
 		__per_cpu_start = .;
 			*(.data.percpu)
 		__per_cpu_end = .;
+#ifdef CONFIG_DEBUG_MEMLEAK
+		__memleak_offsets_start = .;
+			*(.init.memleak_offsets)
+		__memleak_offsets_end = .;
+#endif
 #ifndef CONFIG_XIP_KERNEL
 		__init_begin = _stext;
 		*(.init.data)
@@ -109,6 +114,7 @@ SECTIONS
 
 	.data : AT(__data_loc) {
 		__data_start = .;	/* address in memory */
+		_sdata = .;
 
 		/*
 		 * first, the init task union, aligned
@@ -159,6 +165,7 @@ SECTIONS
 		__bss_start = .;	/* BSS				*/
 		*(.bss)
 		*(COMMON)
+		__bss_stop = .;
 		_end = .;
 	}
 					/* Stabs debugging sections.	*/
