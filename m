Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264424AbUEJAbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264424AbUEJAbV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 20:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264425AbUEJAbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 20:31:21 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:25280 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S264424AbUEJAbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 20:31:19 -0400
Date: Sun, 9 May 2004 20:31:44 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Un-inline spinlocks on ppc64
In-Reply-To: <20040509172038.55319fbd.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0405092025070.1896@montezuma.fsmlabs.com>
References: <16542.51381.215308.485006@cargo.ozlabs.ibm.com>
 <20040509172038.55319fbd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yOn Sun, 9 May 2004, Andrew Morton wrote:

> Paul Mackerras <paulus@samba.org> wrote:
> >
> > The patch below moves the ppc64 spinlocks and rwlocks out of line and
> >  into arch/ppc64/lib/locks.c, and implements _raw_spin_lock_flags for
> >  ppc64.
> >
>
> It included a hunk against include/asm-ppc64/offsets.h, which I dropped.

Regarding CONFIG_INLINE_SPINLOCKS, could we call it CONFIG_SPINLINE as is
the current option supported on i386?

> > ...
> >  This patch depends on the patch from Keith Owens to add
> >  _raw_spin_lock_flags.  If you decide to drop that patch, let me know
> >  and I can do a new version without _raw_spin_lock_flags.
>
> Keith's patch and Zwane's x86 implemeentation are queued up and seem to
> work OK, so all is well, thanks.

I'd like to also make spin_lock_irq also enable interrupts on contention,
but the current generic headers don't make this really easy since it wants
the arch specific code to define _raw_spin_lock in terms of
_raw_spin_lock_flags in order to override the current behaviour. I may
have to resort to __builtin_constant games.

