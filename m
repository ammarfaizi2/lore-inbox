Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUAJDPZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 22:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264545AbUAJDPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 22:15:25 -0500
Received: from dp.samba.org ([66.70.73.150]:63884 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264538AbUAJDPY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 22:15:24 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Fw: Re: 2.6.1-mm1 - OOPs and hangs during modprobe 
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
In-reply-to: Your message of "Fri, 09 Jan 2004 14:56:59 -0800."
             <20040109145659.5e18419b.akpm@osdl.org> 
Date: Sat, 10 Jan 2004 14:11:17 +1100
Message-Id: <20040110031521.309282C050@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040109145659.5e18419b.akpm@osdl.org> you write:
> dude,

Oops, you have an older version.

How did that happen... oh, because I sent it to you.  Fuck.

But either way, it shouldn't be triggering.  Andrew, please revert it,
and I'll work with Vladis to figure out what's happening.

Vladis, relative patch, actually sets error code.  What happens now?

Please send module which fails if it still fails...

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.1-rc2-bk2/kernel/module.c working-2.6.1-rc2-bk2-truncated_module/kernel/module.c
--- linux-2.6.1-rc2-bk2/kernel/module.c	2003-11-24 15:42:33.000000000 +1100
+++ working-2.6.1-rc2-bk2-truncated_module/kernel/module.c	2004-01-08 16:19:01.000000000 +1100
@@ -1682,5 +1688,6 @@ static struct module *load_module(void _
 
  truncated:
 	printk(KERN_ERR "Module len %lu truncated\n", len);
+	err = -ENOEXEC;
 	goto free_hdr;
 }
