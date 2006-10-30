Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161432AbWJ3UFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161432AbWJ3UFw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030587AbWJ3UFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:05:12 -0500
Received: from [198.99.130.12] ([198.99.130.12]:14478 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1030586AbWJ3UFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:05:06 -0500
Message-Id: <200610302102.k9UL2xX8006234@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/3] UML - Add _text definition to linker scripts
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Oct 2006 16:02:59 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kallsyms now refers to addresses as '_text + 0xADDRESS', rather than
just '0xADDRESS', so we need to define _text.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/kernel/dyn.lds.S
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/dyn.lds.S	2006-10-30 13:11:25.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/dyn.lds.S	2006-10-30 13:52:26.000000000 -0500
@@ -14,6 +14,7 @@ SECTIONS
    * is remapped.*/
   __binary_start = .;
   . = ALIGN(4096);		/* Init code and data */
+  _text = .;
   _stext = .;
   __init_begin = .;
   .init.text : {
Index: linux-2.6.18-mm/arch/um/kernel/uml.lds.S
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/uml.lds.S	2006-10-30 13:11:25.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/uml.lds.S	2006-10-30 13:52:10.000000000 -0500
@@ -25,6 +25,7 @@ SECTIONS
   . = ALIGN(4096);		/* Init code and data */
 #endif
 
+  _text = .;
   _stext = .;
   __init_begin = .;
   .init.text : {

