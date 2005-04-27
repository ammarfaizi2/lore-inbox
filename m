Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVD0M7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVD0M7h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 08:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVD0M73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 08:59:29 -0400
Received: from mail.suse.de ([195.135.220.2]:11407 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261571AbVD0M7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 08:59:16 -0400
Date: Wed, 27 Apr 2005 14:59:10 +0200
From: Andi Kleen <ak@suse.de>
To: Patrick McHardy <kaber@trash.net>
Cc: Andi Kleen <ak@suse.de>, Ed Tomlinson <tomlins@cam.org>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: X86_64: 2.6.12-rc3 spontaneous reboot
Message-ID: <20050427125910.GH13305@wotan.suse.de>
References: <426CADF1.2000100@trash.net> <20050425153541.GC16828@wotan.suse.de> <426E3C6F.6010001@trash.net> <20050426135312.GI5098@wotan.suse.de> <426E48C0.9090503@trash.net> <426E4DD2.8060808@trash.net> <20050426142252.GJ5098@wotan.suse.de> <426E5571.8000101@trash.net> <20050426145351.GD13305@wotan.suse.de> <426E5889.8060108@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426E5889.8060108@trash.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can you please test this patch?

It should fix the problem.

Add missing clis

Signed-off-by: Andi Kleen <ak@suse.de>

diff -u linux-2.6.12rc3/arch/x86_64/kernel/entry.S-o linux-2.6.12rc3/arch/x86_64/kernel/entry.S
--- linux-2.6.12rc3/arch/x86_64/kernel/entry.S-o	2005-04-22 12:48:11.000000000 +0200
+++ linux-2.6.12rc3/arch/x86_64/kernel/entry.S	2005-04-27 14:52:41.998972964 +0200
@@ -296,6 +296,7 @@
 	call syscall_trace_leave
 	popq %rdi
 	andl $~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP),%edi
+	cli	
 	jmp int_restore_rest
 	
 int_signal:
@@ -307,6 +308,7 @@
 1:	movl $_TIF_NEED_RESCHED,%edi	
 int_restore_rest:
 	RESTORE_REST
+	cli	
 	jmp int_with_check
 	CFI_ENDPROC
 		
