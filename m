Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264885AbTBJKM3>; Mon, 10 Feb 2003 05:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbTBJKM3>; Mon, 10 Feb 2003 05:12:29 -0500
Received: from [195.39.17.254] ([195.39.17.254]:1540 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S264885AbTBJKM2>;
	Mon, 10 Feb 2003 05:12:28 -0500
Date: Sun, 9 Feb 2003 21:31:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Fix random memory corruption during suspend-to-RAM resume
Message-ID: <20030209203141.GA2223@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

We really want to use wakeup_stack as stack, not as pointer to
stack... Please apply,
								Pavel

--- clean/arch/i386/kernel/acpi_wakeup.S	2002-12-18 22:20:47.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/acpi_wakeup.S	2003-02-09 21:13:19.000000000 +0100
@@ -31,7 +31,7 @@
 	movw	%cs, %ax
 	movw	%ax, %ds					# Make ds:0 point to wakeup_start
 	movw	%ax, %ss
-	mov	wakeup_stack - wakeup_code, %sp			# Private stack is needed for ASUS board
+	mov	$(wakeup_stack - wakeup_code), %sp		# Private stack is needed for ASUS board
 	movw	$0x0e00 + 'S', %fs:(0x12)
 
 	pushl	$0						# Kill any dangerous flags

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
