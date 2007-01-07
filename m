Return-Path: <linux-kernel-owner+w=401wt.eu-S965048AbXAGUF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbXAGUF3 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 15:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbXAGUF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 15:05:29 -0500
Received: from smtp.osdl.org ([65.172.181.24]:44453 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965048AbXAGUF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 15:05:27 -0500
Date: Sun, 7 Jan 2007 12:05:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, kiran@scalex86.org, ak@suse.de,
       md@google.com, mingo@elte.hu, pravin.shelar@calsoftinc.com,
       shai@scalex86.org
Subject: Re: +
 spin_lock_irq-enable-interrupts-while-spinning-i386-implementation.patch
 added to -mm tree
Message-Id: <20070107120503.ceadb6ed.akpm@osdl.org>
In-Reply-To: <1168176285.26086.241.camel@imap.mvista.com>
References: <200701032112.l03LCnVb031386@shell0.pdx.osdl.net>
	<1168122953.26086.230.camel@imap.mvista.com>
	<20070106232641.68511f15.akpm@osdl.org>
	<1168176285.26086.241.camel@imap.mvista.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Jan 2007 05:24:45 -0800
Daniel Walker <dwalker@mvista.com> wrote:

> Now it fails with CONFIG_PARAVIRT off .
> 
> scripts/kconfig/conf -s arch/i386/Kconfig
>   CHK     include/linux/version.h
>   CHK     include/linux/compile.h
>   CHK     include/linux/utsrelease.h
>   UPD     include/linux/compile.h
>   CC      arch/i386/kernel/asm-offsets.s
> In file included from include/linux/spinlock.h:88,
>                  from include/linux/module.h:10,
>                  from include/linux/crypto.h:22,
>                  from arch/i386/kernel/asm-offsets.c:8:
> include/asm/spinlock.h: In function '__raw_spin_lock_irq':
> include/asm/spinlock.h:100: error: expected string literal before '__CLI_STI_INPUT_ARGS'

bah.

--- a/include/asm-i386/spinlock.h~spin_lock_irq-enable-interrupts-while-spinning-i386-implementation-fix-fix
+++ a/include/asm-i386/spinlock.h
@@ -14,6 +14,7 @@
 #define STI_STRING	"sti"
 #define CLI_STI_CLOBBERS
 #define CLI_STI_INPUT_ARGS
+#define __CLI_STI_INPUT_ARGS
 #endif /* CONFIG_PARAVIRT */
 
 /*
_

