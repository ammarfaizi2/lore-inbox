Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbVCUODi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVCUODi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 09:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVCUODh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 09:03:37 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:28347 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261854AbVCUOCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 09:02:25 -0500
Message-ID: <423EE354.ACFF446A@tv-sign.ru>
Date: Mon, 21 Mar 2005 18:08:04 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stas Sergeev <stsp@aknet.ru>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc1-mm1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not related to this mm release directly, but

> All 609 patches:
> ...
> x86-fix-esp-corruption-cpu-bug-take-2.patch
>   x86: fix ESP corruption CPU bug (take 2)

I think that Stas tries to steal 1024 bytes from kernel's memory ...
On top of his patch.

--- 2.6.12/arch/i386/kernel/cpu/common.c~stas	2005-03-21 19:43:11.000000000 +0300
+++ 2.6.12/arch/i386/kernel/cpu/common.c	2005-03-21 19:48:30.000000000 +0300
@@ -21,7 +21,6 @@
 DEFINE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
 EXPORT_PER_CPU_SYMBOL(cpu_gdt_table);
 
-unsigned char cpu_16bit_stack[CPU_16BIT_STACK_SIZE];
 DEFINE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
 EXPORT_PER_CPU_SYMBOL(cpu_16bit_stack);
 
--- 2.6.12-rc1/include/asm-i386/desc.h~stas	2005-03-21 19:43:11.000000000 +0300
+++ 2.6.12-rc1/include/asm-i386/desc.h	2005-03-21 19:49:16.000000000 +0300
@@ -17,7 +17,6 @@
 extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
 DECLARE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
 
-extern unsigned char cpu_16bit_stack[CPU_16BIT_STACK_SIZE];
 DECLARE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
 
 struct Xgt_desc_struct {
