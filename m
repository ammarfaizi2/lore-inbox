Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264215AbUDSAIx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 20:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbUDSAIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 20:08:53 -0400
Received: from mail.shareable.org ([81.29.64.88]:49315 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264215AbUDSAIw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 20:08:52 -0400
Date: Mon, 19 Apr 2004 01:08:47 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "H. J. Lu" <hjl@lucon.org>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to make stack executable on demand?
Message-ID: <20040419000847.GB11064@mail.shareable.org>
References: <20040416170915.GA20260@lucon.org> <1082145778.9600.6.camel@laptop.fenrus.com> <20040416204651.GA24194@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040416204651.GA24194@lucon.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. J. Lu wrote:
> On Fri, Apr 16, 2004 at 10:02:58PM +0200, Arjan van de Ven wrote:
> > >  But it will either fail if
> > > kernel is set with non-executable stack,
> > 
> > eh no. mprotect with prot_exec is still supposed to work. The stacks
> > still have MAY_EXEC attribute, just not the actual EXEC attribute
> 
> [...]
> The VM_MAYEXEC bit is untouched. Now the question is if it is a good
> idea for user to change stack permission.

You can create a new executable data area with mmap(), copy the stack
to it, unmap the stack, and mremap() to move the copy to where the
stack was.  The run time linker can do this if you're on a kernel
where mprotect() fails.

In other words, even those kernels which disable VM_MAYEXEC don't
protect against this alternative way of simulating mprotect().  There
is no point in them prohibiting it.

-- Jamie
