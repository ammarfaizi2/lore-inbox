Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbUCOAwP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 19:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbUCOAwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 19:52:15 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:10439 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262154AbUCOAwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 19:52:12 -0500
Date: Sun, 14 Mar 2004 19:52:12 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch] proper alignment of init task in kernel image
In-Reply-To: <20040315000340.GZ20174@waste.org>
Message-ID: <Pine.LNX.4.58.0403141951340.28447@montezuma.fsmlabs.com>
References: <20040315000340.GZ20174@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Mar 2004, Matt Mackall wrote:

> This keeps the alignment of the init task matched with the stack size.
> Saves 4k for 4k stacks, keeps system from exploding with 16k. Please apply.

Don't forget the following minor patch;

Index: linux-2.6.4-mm1/arch/i386/kernel/init_task.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.4-mm1/arch/i386/kernel/init_task.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 init_task.c
--- linux-2.6.4-mm1/arch/i386/kernel/init_task.c	11 Mar 2004 15:26:38 -0000	1.1.1.1
+++ linux-2.6.4-mm1/arch/i386/kernel/init_task.c	15 Mar 2004 00:51:14 -0000
@@ -20,7 +20,7 @@ EXPORT_SYMBOL(init_mm);
 /*
  * Initial thread structure.
  *
- * We need to make sure that this is 8192-byte aligned due to the
+ * We need to make sure that this is THREAD_SIZE aligned due to the
  * way process stacks are handled. This is done by having a special
  * "init_task" linker map entry..
  */
