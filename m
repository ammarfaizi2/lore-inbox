Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbVJYPAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVJYPAL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 11:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVJYPAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 11:00:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24106 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932168AbVJYPAK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 11:00:10 -0400
Date: Tue, 25 Oct 2005 11:00:09 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/9] mm: arm ready for split ptlock
In-reply-to: <20051025075555.GA25020@flint.arm.linux.org.uk>
X-X-Sender: nico@localhost.localdomain
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.64.0510251056380.5288@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0510221719370.18047@goblin.wat.veritas.com>
 <20051022170240.GA10631@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0510241922040.5288@localhost.localdomain>
 <20051025075555.GA25020@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2005, Russell King wrote:

> On Mon, Oct 24, 2005 at 10:45:04PM -0400, Nicolas Pitre wrote:
> > On Sat, 22 Oct 2005, Russell King wrote:
> > > Please contact Nicolas Pitre about that - that was my suggestion,
> > > but ISTR apparantly the overhead is too high.
> > 
> > Going through a kernel buffer will simply double the overhead.  Let's 
> > suppose it should not be a big enough issue to stop the patch from being 
> > merged though (and it looks cleaner that way). However I'd like for the 
> > WARN_ON((unsigned long)frame & 7) to remain as both the kernel and user 
> > buffers should be 64-bit aligned.
> 
> The WARN_ON is pointless because we guarantee that the stack is always
> 64-bit aligned on signal handler setup and return.

Sure, but the iWMMXt context is stored after the standard sigcontext 
which also must be 64 bits in size (which might not be always the case 
if things change in the structure or in its padding).

> > I don't see how standard COW could not happen.  The only difference with 
> > a true write fault as if we used put_user() is that we bypassed the data 
> > abort vector and the code to get the FAR value.  Or am I missing 
> > something?
> 
> pte_write() just says that the page _may_ be writable.  It doesn't say
> that the MMU is programmed to allow writes.  If pte_dirty() doesn't
> return true, that means that the page is _not_ writable from userspace.

Argh...  So only suffice to s/pte_write/pte_dirty/ I'd guess?


Nicolas
