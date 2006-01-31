Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWAaWcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWAaWcV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 17:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbWAaWcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 17:32:21 -0500
Received: from acid.ch.pw.edu.pl ([194.29.156.2]:59556 "EHLO acid.ch.pw.edu.pl")
	by vger.kernel.org with ESMTP id S1751698AbWAaWcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 17:32:20 -0500
Date: Tue, 31 Jan 2006 23:29:05 +0100 (CET)
From: Jacek Lipkowski <sq5bpf@acid.ch.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: patch to make 2.4.32 work on i486 again
Message-ID: <Pine.LNX.4.58.0601312313050.6477@acid.ch.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Booting the 2.4.32 kernel compiled for a i486 on an i486 box fails,
because "Kernel compiled for Pentium+, requires TSC feature!" (printed
from check_config() include/asm-i386/bugs.h). To reproduce, select 486 in
the kernel configuration and grep CONFIG_X86_TSC .config

Seems strange that no one noticed this, am i the only one still using 486
boxes? :)

Jacek

Simple patch against vanilla 2.4.32:

--- arch/i386/config.in.old	2006-01-30 22:57:21.000000000 +0100
+++ arch/i386/config.in	2006-01-30 23:00:55.000000000 +0100
@@ -65,6 +65,7 @@
    define_bool CONFIG_X86_POPAD_OK y
    define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
    define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
+   define_bool CONFIG_X86_TSC n
 fi
 if [ "$CONFIG_M486" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
@@ -72,6 +73,7 @@
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_WORKS_OK n
+   define_bool CONFIG_X86_TSC n
 fi
 if [ "$CONFIG_M586" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
