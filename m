Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbUCHLsh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 06:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbUCHLsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 06:48:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:20623 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262471AbUCHLsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 06:48:36 -0500
Date: Mon, 8 Mar 2004 03:48:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org, george@mvista.com,
       pavel@ucw.cz
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Message-Id: <20040308034838.2ce64732.akpm@osdl.org>
In-Reply-To: <200403081650.18641.amitkale@emsyssoft.com>
References: <200403081504.30840.amitkale@emsyssoft.com>
	<200403081619.16771.amitkale@emsyssoft.com>
	<20040308030722.01948c93.akpm@osdl.org>
	<200403081650.18641.amitkale@emsyssoft.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Amit S. Kale" <amitkale@emsyssoft.com> wrote:
>
> > Let me just make sure we're taking about the same thing here.  Are you
> > saying that with kgdb-lite, `info threads' is completely missing, or does
> > it just not work correctly with threads (as opposed to heavyweight
> > processes)?
> 
> info threads shows a list of threads. Heavy/light weight processes doesn't 
> matter. Thread frame shown is incorrect.

It is?  I haven't noticed any problems with it here.  George recently
changed it to also display the process name in the gdb output, which is
valuable.

> I looked at i386 dependent code again. Following code in it is incorrect. I 
> never noticed it because this code is rarely used in full version of kgdb:
> 
> +void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct 
> *p)

There is no such function in the stub in -mm kernels.

> 
> Present threads support code changes calling convention of do_IRQ. Most 
> believe that to be an absolute no.

I see no such change in George's stub, unless I'm missing something again.

> Since you consider it a must-have, I'll check whether above changes suggested 
> by me make info threads listing correct in most cases.

The only problem I have with it is that sometimes after listing all threads
the debugger can lose control of the target and will start complaining
about communication errors.  I assume the target has died.  This happens
very rarely.  Usually when you're about to find the bug ;)
