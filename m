Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264053AbUDFXVE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 19:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbUDFXVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 19:21:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:13036 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264053AbUDFXVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 19:21:00 -0400
Date: Tue, 6 Apr 2004 16:23:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH] NUMA API for Linux 3/ Add i386 support
Message-Id: <20040406162314.2cb1f45d.akpm@osdl.org>
In-Reply-To: <20040406153555.06d2f948.ak@suse.de>
References: <20040406153322.5d6e986e.ak@suse.de>
	<20040406153555.06d2f948.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> @@ -279,8 +279,11 @@
>  #define __NR_utimes		271
>  #define __NR_fadvise64_64	272
>  #define __NR_vserver		273
> +#define __NR_mbind		273
> +#define __NR_get_mempolicy	274
> +#define __NR_set_mempolicy	275

hm, those are all wrong.  I fixed it up.

Manfred, I'm going to bump the mq syscall numbers.  numa API has been
around a bit longer and I suspect more people are relying on the syscall
numbers not changing.   Whatever they were ;)


 
diff -puN arch/i386/kernel/entry.S~numa-api-i386 arch/i386/kernel/entry.S
--- 25/arch/i386/kernel/entry.S~numa-api-i386	Tue Apr  6 16:19:40 2004
+++ 25-akpm/arch/i386/kernel/entry.S	Tue Apr  6 16:20:40 2004
@@ -908,9 +908,9 @@ ENTRY(sys_call_table)
 	.long sys_utimes
  	.long sys_fadvise64_64
 	.long sys_ni_syscall	/* sys_vserver */
-	.long sys_ni_syscall	/* sys_mbind */
-	.long sys_ni_syscall	/* 275 sys_get_mempolicy */
-	.long sys_ni_syscall	/* sys_set_mempolicy */
+	.long sys_mbind
+	.long sys_get_mempolicy	/* 275 */
+	.long sys_set_mempolicy
 	.long sys_mq_open
 	.long sys_mq_unlink
 	.long sys_mq_timedsend
diff -puN include/asm-i386/unistd.h~numa-api-i386 include/asm-i386/unistd.h

_

