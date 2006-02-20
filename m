Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbWBTVja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbWBTVja (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 16:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbWBTVja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 16:39:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53972 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932603AbWBTVj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 16:39:29 -0500
Date: Mon, 20 Feb 2006 13:37:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -mm HOT-FIX] fix build on ia64 (modpost.c)
Message-Id: <20060220133736.2df448c8.akpm@osdl.org>
In-Reply-To: <20060220192500.GA17003@mars.ravnborg.org>
References: <20060220042615.5af1bddc.akpm@osdl.org>
	<20060220192500.GA17003@mars.ravnborg.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> wrote:
>
> > 
> > - This kernel won't compile on ia64 (and possibly other architectures)
> >   because the kbuild tree is using Elf_Rela in scripts/mod/modpost.c.  Is OK
> >   on x86, x86_64 and powerpc.  Sam might send a hotfix?
> 
> Attached is a real hot-fix. It disables the new check entirely.

Well that bit compiles.

> I like to learn:
> 1) Why IA64 is missing Elf64_Rela. Can someone drop me a copy of elf.h -
> and include gcc + binutils version in the mail - thanks.

This thing's running RHAS2.1 which I think dates from before the invention
of the transistor.  Running home-made gcc-3.3.2 and binutils-2.14.90.0.6-1.

I'll send along the three elf.h's under /usr/include.

> 2) I also like to know if other architectures broke - so I can figure
> out how to fix this.

Dunno yet - I didn't do the normal batch of cross-compiles due to spending
six hours chasing down new bugs.

> I have tested this on X86_64/amd64 (gentoo based) only.

That fixes the modpost.c compile, but the new futex stuff fails because
ia64 doesn't implement ptr_to_compat().  In fact only three architectures
appear to do so.

