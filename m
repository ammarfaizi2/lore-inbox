Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264930AbUAJDyF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 22:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264935AbUAJDyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 22:54:05 -0500
Received: from waste.org ([209.173.204.2]:27582 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264930AbUAJDyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 22:54:03 -0500
Date: Fri, 9 Jan 2004 21:53:50 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: [patch] arch-specific cond_syscall usage issues
Message-ID: <20040110035350.GX18208@waste.org>
References: <20040110032915.GW18208@waste.org> <20040109193753.3c158b3b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040109193753.3c158b3b.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 07:37:53PM -0800, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> >  Experimenting with trying to use cond_syscall for a few arch-specific
> >  syscalls, I discovered that it can't actually be used outside the file
> >  in which sys_ni_syscall is declared because the assembler doesn't feel
> >  obliged to output the symbol in that case:
> > 
> >  weak.c:
> > 
> >  #define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
> >  cond_syscall(sys_foo);
> > 
> >  $ nm weak.o
> >           U sys_ni_syscall
> > 
> >  One arch (PPC) is apparently trying to use cond_syscall this way
> >  anyway, though it's probably never been actually tested as the above
> >  test was done on a PPC.
> 
> So why does the PPC kernel successfully link?

Presumably because no one's tried it without CONFIG_PCI since this
change went in?

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
