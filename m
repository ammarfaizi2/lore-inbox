Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264284AbUASDh2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 22:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264285AbUASDh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 22:37:27 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:18584 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264284AbUASDhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 22:37:25 -0500
Subject: Re: Help port swsusp to ppc.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugang <hugang@soulinfo.com>
Cc: ncunningham@clear.net.nz, Linux Kernel list <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
In-Reply-To: <20040119105237.62a43f65@localhost>
References: <20040119105237.62a43f65@localhost>
Content-Type: text/plain
Message-Id: <1074483354.10595.5.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 19 Jan 2004 14:35:55 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Some comments...

>Index: arch/ppc/kernel/swsusp2-asm.S
>===================================================================
>--- arch/ppc/kernel/swsusp2-asm.S	(revision 0)
>+++ arch/ppc/kernel/swsusp2-asm.S	(revision 0)


What is this file ? It's absolutely horrible....


>Index: arch/ppc/kernel/Makefile
>===================================================================
>--- arch/ppc/kernel/Makefile	(revision 192)
>+++ arch/ppc/kernel/Makefile	(working copy)
>@@ -34,3 +34,5 @@
> obj-$(CONFIG_8xx)		+= softemu8xx.o
> endif
>
>+obj-$(CONFIG_SOFTWARE_SUSPEND2) += swsusp2-asm.o
>+obj-$(CONFIG_SOFTWARE_SUSPEND2) += ppc_reg.o

You could have put both of these on the same line.


>Index: arch/ppc/kernel/vmlinux.lds.S
>===================================================================
>--- arch/ppc/kernel/vmlinux.lds.S	(revision 192)
>+++ arch/ppc/kernel/vmlinux.lds.S	(working copy)
>@@ -72,6 +72,12 @@
>     CONSTRUCTORS
>   }
> 
>+  . = ALIGN(4096);
>+  __nosave_begin = .;
>+  .data_nosave : { *(.data.nosave) }
>+  . = ALIGN(4096);
>+  __nosave_end = .;
>+
>   . = ALIGN(32);
>   .data.cacheline_aligned : { *(.data.cacheline_aligned) }

Why do you need the above for ?



