Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbWJRCjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWJRCjx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 22:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWJRCjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 22:39:53 -0400
Received: from gw.goop.org ([64.81.55.164]:27089 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750898AbWJRCjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 22:39:52 -0400
Message-ID: <45358FB2.5000606@goop.org>
Date: Tue, 17 Oct 2006 19:21:38 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.19-rc2-mm1] Fix fake return address
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The fake return address was being set to __KERNEL_PDA, rather than 0.
Push it earlier while %eax still equals 0.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>

diff -r b8e58159855c arch/i386/kernel/head.S
--- a/arch/i386/kernel/head.S	Tue Oct 17 19:04:59 2006 -0700
+++ b/arch/i386/kernel/head.S	Tue Oct 17 19:05:46 2006 -0700
@@ -316,12 +316,12 @@ 1:	movl $(__KERNEL_DS),%eax	# reload all
 	xorl %eax,%eax			# Clear FS and LDT
 	movl %eax,%fs
 	lldt %ax
+	pushl %eax		# fake return address
 
 	movl $(__KERNEL_PDA),%eax
 	mov  %eax,%gs
 
 	cld			# gcc2 wants the direction flag cleared at all times
-	pushl %eax		# fake return address
 #ifdef CONFIG_SMP
 	movb ready, %cl
 	movb $1, ready



