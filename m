Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVDKI47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVDKI47 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 04:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVDKI47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 04:56:59 -0400
Received: from smtp04.auna.com ([62.81.186.14]:20425 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S261738AbVDKI44 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 04:56:56 -0400
Date: Mon, 11 Apr 2005 08:56:33 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.12-rc2-mm3
To: linux-kernel@vger.kernel.org
References: <20050411012532.58593bc1.akpm@osdl.org>
In-Reply-To: <20050411012532.58593bc1.akpm@osdl.org> (from akpm@osdl.org on
	Mon Apr 11 10:25:32 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1113209793l.7664l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.11, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
> 
> 

Is this not needed anymore ?

--- 25/arch/i386/kernel/entry.S~nmi_stack_correct-fix	2005-04-05 00:02:48.000000000 -0700
+++ 25-akpm/arch/i386/kernel/entry.S	2005-04-05 00:02:48.000000000 -0700
@@ -178,9 +178,9 @@ ENTRY(resume_kernel)
 need_resched:
 	movl TI_flags(%ebp), %ecx	# need_resched set ?
 	testb $_TIF_NEED_RESCHED, %cl
-	jz restore_all
+	jz restore_nocheck
 	testl $IF_MASK,EFLAGS(%esp)     # interrupts off (exception path) ?
-	jz restore_all
+	jz restore_nocheck
 	call preempt_schedule_irq
 	jmp need_resched
 #endif
@@ -587,7 +587,7 @@ nmi_stack_correct:
 	xorl %edx,%edx		# zero error code
 	movl %esp,%eax		# pt_regs pointer
 	call do_nmi
-	jmp restore_all
+	jmp restore_nocheck
 
 nmi_stack_fixup:
 	FIX_STACK(12,nmi_stack_correct, 1)

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Limited Edition 2005) for i586
Linux 2.6.11-jam12 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-7mdk)) #1


