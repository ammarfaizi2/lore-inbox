Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264245AbUANQNU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 11:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbUANQNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 11:13:20 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:61172 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S264245AbUANQNR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 11:13:17 -0500
Date: Wed, 14 Jan 2004 09:13:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com
Subject: Re: [patch] arch-specific cond_syscall usage issues
Message-ID: <20040114161306.GA16950@stop.crashing.org>
References: <20040110032915.GW18208@waste.org> <20040109193753.3c158b3b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040109193753.3c158b3b.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
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

Since this looks to have missed -mm3, I'm going to follow up here (I
hate playing catch-up sometimes).

As has been previously noted, the cond_syscall is only ever cared about
on PPC when you try for !PCI.  And this only happens realistically now,
on MPC8xx (it's usually present on IBM 4xx, and lets ignore APUS).
MPC8xx support has been broken for a while, but hopefully will get fixed
'soon'.

So can we please move this cond_syscall into kernel/sys.c ?

-- 
Tom Rini
http://gate.crashing.org/~trini/
