Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVGLJRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVGLJRO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 05:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVGLJOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 05:14:48 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51094 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261271AbVGLJOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 05:14:08 -0400
Date: Tue, 12 Jul 2005 11:14:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] Fix GDT loading during resume from suspend-to-RAM
Message-ID: <20050712091400.GI1854@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix GDT loading during resume from suspend-to-RAM.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 523c9470749c558e002f3041f5af620acf7f3e0c
tree 92b643196cbaa89fa54ff141bc94fee8664009b3
parent 79b675b6cc9268d178b3c0a2af2e4f944c5fdf9b
author <pavel@amd.(none)> Tue, 12 Jul 2005 11:13:30 +0200
committer <pavel@amd.(none)> Tue, 12 Jul 2005 11:13:30 +0200

 arch/i386/kernel/acpi/wakeup.S |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/i386/kernel/acpi/wakeup.S b/arch/i386/kernel/acpi/wakeup.S
--- a/arch/i386/kernel/acpi/wakeup.S
+++ b/arch/i386/kernel/acpi/wakeup.S
@@ -74,8 +74,9 @@ wakeup_code:
 	movw	%ax,%fs
 	movw	$0x0e00 + 'i', %fs:(0x12)
 	
-	# need a gdt
-	lgdt	real_save_gdt - wakeup_code
+	# need a gdt -- use lgdtl to force 32-bit operands, in case
+	# the GDT is located past 16 megabytes
+	lgdtl	real_save_gdt - wakeup_code
 
 	movl	real_save_cr0 - wakeup_code, %eax
 	movl	%eax, %cr0

-- 
teflon -- maybe it is a trademark, but it should not be.
