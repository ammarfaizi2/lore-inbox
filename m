Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266895AbUIFHfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266895AbUIFHfM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 03:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266611AbUIFHfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 03:35:12 -0400
Received: from cantor.suse.de ([195.135.220.2]:38284 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267554AbUIFHdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 03:33:17 -0400
Date: Mon, 6 Sep 2004 09:28:59 +0200
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matt Mackall <mpm@selenic.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH][8/8] Arch agnostic completely out of line locks / x86_64
Message-ID: <20040906072859.GB31343@wotan.suse.de>
References: <Pine.LNX.4.58.0409021241291.4481@montezuma.fsmlabs.com> <20040904111605.GA12165@wotan.suse.de> <Pine.LNX.4.58.0409041420590.11262@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409041420590.11262@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 02:26:12PM -0400, Zwane Mwaikambo wrote:
> On Sat, 4 Sep 2004, Andi Kleen wrote:
> 
> > On Thu, Sep 02, 2004 at 08:03:02PM -0400, Zwane Mwaikambo wrote:
> > >  arch/x86_64/kernel/time.c        |   13 +++++++++++++
> > >  arch/x86_64/kernel/vmlinux.lds.S |    1 +
> > >  include/asm-x86_64/ptrace.h      |    4 ++++
> > >  3 files changed, 18 insertions(+)
> > >
> > > Andi, i'm not so sure about that return address in profile_pc, i think i
> > > need to read a bit more.
> >
> > When frame pointers are enabled the code is correct. But you don't
> > even need frame pointers, because the spinlock code should not
> > spill any registers and in such a function the return address
> > is always *rsp. Same is true on i386 too.
> 
> How about the following?

That is with frame pointers enabled. Indeed with frame pointers
on it is not true you still have to special case that.

But the common case is without frame pointers anyways ... 

-Andi

