Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbUAJDhO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 22:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264565AbUAJDhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 22:37:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:14809 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264546AbUAJDhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 22:37:12 -0500
Date: Fri, 9 Jan 2004 19:37:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: [patch] arch-specific cond_syscall usage issues
Message-Id: <20040109193753.3c158b3b.akpm@osdl.org>
In-Reply-To: <20040110032915.GW18208@waste.org>
References: <20040110032915.GW18208@waste.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
>  Experimenting with trying to use cond_syscall for a few arch-specific
>  syscalls, I discovered that it can't actually be used outside the file
>  in which sys_ni_syscall is declared because the assembler doesn't feel
>  obliged to output the symbol in that case:
> 
>  weak.c:
> 
>  #define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
>  cond_syscall(sys_foo);
> 
>  $ nm weak.o
>           U sys_ni_syscall
> 
>  One arch (PPC) is apparently trying to use cond_syscall this way
>  anyway, though it's probably never been actually tested as the above
>  test was done on a PPC.

So why does the PPC kernel successfully link?
