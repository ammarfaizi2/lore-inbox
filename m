Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbTFORfb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 13:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbTFORfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 13:35:31 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:23825 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S262426AbTFORf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 13:35:26 -0400
Date: Sun, 15 Jun 2003 19:48:56 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andi Kleen <ak@colin.muc.de>
cc: Linus Torvalds <torvalds@transmeta.com>, Andi Kleen <ak@muc.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix undefined/miscompiled construct in kernel parameters
In-Reply-To: <20030615193256.29257@colin.muc.de>
Message-ID: <Pine.LNX.4.44.0306151943100.12110-100000@serv>
References: <m3of0zdzuz.fsf@averell.firstfloor.org>
 <Pine.LNX.4.44.0306151021440.8088-100000@home.transmeta.com>
 <20030615193256.29257@colin.muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15 Jun 2003, Andi Kleen wrote:

> I tend to agree, feel free to flame them. But it doesn't help me right now 
> when I want to get a booting kernel. Could you merge that change or if you 
> prefer I can rewrite it to anonymous asm (but it will be probably more ugly). 
> I just need some workaround.

Does the patch below work better?

bye, Roman

--- linux/init/main.c	14 Jun 2003 23:01:48 -0000	1.1.1.41
+++ linux/init/main.c	15 Jun 2003 17:46:16 -0000
@@ -383,7 +383,7 @@ asmlinkage void __init start_kernel(void
 {
 	char * command_line;
 	extern char saved_command_line[];
-	extern struct kernel_param __start___param, __stop___param;
+	extern struct kernel_param __start___param[], __stop___param[];
 /*
  * Interrupts are still disabled. Do necessary setups, then
  * enable them
@@ -403,8 +403,8 @@ asmlinkage void __init start_kernel(void
 	build_all_zonelists();
 	page_alloc_init();
 	printk("Kernel command line: %s\n", saved_command_line);
-	parse_args("Booting kernel", command_line, &__start___param,
-		   &__stop___param - &__start___param,
+	parse_args("Booting kernel", command_line, __start___param,
+		   __stop___param - __start___param,
 		   &unknown_bootoption);
 	trap_init();
 	rcu_init();


