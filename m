Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbUAJFVO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 00:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUAJFVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 00:21:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46473 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264916AbUAJFVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 00:21:13 -0500
Date: Fri, 9 Jan 2004 21:21:08 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] arch-specific cond_syscall usage issues
Message-Id: <20040109212108.3d8f5e54.zaitcev@redhat.com>
In-Reply-To: <20040109193753.3c158b3b.akpm@osdl.org>
References: <20040110032915.GW18208@waste.org>
	<20040109193753.3c158b3b.akpm@osdl.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jan 2004 19:37:53 -0800
Andrew Morton <akpm@osdl.org> wrote:

> >  Experimenting with trying to use cond_syscall for a few arch-specific
> >  syscalls, I discovered that it can't actually be used outside the file
> >  in which sys_ni_syscall is declared because the assembler doesn't feel
> >  obliged to output the symbol in that case:

> >  One arch (PPC) is apparently trying to use cond_syscall this way
> >  anyway, though it's probably never been actually tested as the above
> >  test was done on a PPC.
> 
> So why does the PPC kernel successfully link?

Perhaps it never was tested right when the change went in.
I saw the same failure when hch did it to sparc, I later did the same:
moved the syscall into kernel/sys.c. Mine wasn't arch specific.
Maybe 3 arches used it (pci_config_read_word or such).

I saw the way ppc did it at that time (2.5.75),
and thought that their toolchain must have been smarter than mine.

The patch is easy. The hard road would be to take it to binutils people
like H.J.Lu and see what they say.

-- Pete
