Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbUABXHS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 18:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265692AbUABXHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 18:07:18 -0500
Received: from gprs214-81.eurotel.cz ([160.218.214.81]:8846 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265691AbUABXHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 18:07:17 -0500
Date: Fri, 2 Jan 2004 23:46:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       Andrew Morton <akpm@zip.com.au>, Patrick Mochel <mochel@osdl.org>
Subject: s3 sleep: Kill obsolete debugging code
Message-ID: <20040102224644.GA466@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

wakeup.S includes some rather nasty, and unneccessary debugging
code. (It used to try to flush caches/tlbs; now its totally
useless). Please apply,
							Pavel

Index: linux.new/arch/i386/kernel/acpi/wakeup.S
===================================================================
--- linux.new.orig/arch/i386/kernel/acpi/wakeup.S	2003-12-25 13:28:50.000000000 +0100
+++ linux.new/arch/i386/kernel/acpi/wakeup.S	2003-12-25 13:29:06.000000000 +0100
@@ -193,11 +193,6 @@
 	# and restore the stack ... but you need gdt for this to work
 	movl	saved_context_esp, %esp
 
-	movw	$0x0e00 + 'W', 0xb8018
-	outl	%eax, $0x80
-	outl	%eax, $0x80
-	movw	$0x0e00 + 'O', 0xb8018
-
 	movl	%cs:saved_magic, %eax
 	cmpl	$0x12345678, %eax
 	jne	bogus_magic
@@ -205,9 +200,6 @@
 	# jump to place where we left off
 	movl	saved_eip,%eax
 	movw	$0x0e00 + 'x', 0xb8018
-	outl	%eax, $0x80
-	outl	%eax, $0x80
-	movw	$0x0e00 + '!', 0xb801a
 	jmp	*%eax
 
 bogus_magic:

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
