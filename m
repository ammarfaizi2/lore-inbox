Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263149AbUE1ODP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbUE1ODP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 10:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbUE1ODO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 10:03:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35970 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263149AbUE1OCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 10:02:53 -0400
Date: Fri, 28 May 2004 10:02:34 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: bert hubert <ahu@ds9a.nl>, Andrew Morton <akpm@osdl.org>, arnd@arndb.de,
       drepper@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
       schwidefsky@de.ibm.com
Subject: Re: DOCUMENTATION Re: [PATCH] Add FUTEX_CMP_REQUEUE futex op
Message-ID: <20040528140234.GH4736@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040520093817.GX30909@devserv.devel.redhat.com> <20040520233639.126125ef.akpm@osdl.org> <20040521074358.GG30909@devserv.devel.redhat.com> <200405221858.44752.arnd@arndb.de> <20040524073407.GC4736@devserv.devel.redhat.com> <20040524011203.3be81d0a.akpm@osdl.org> <20040524081958.GD4736@devserv.devel.redhat.com> <20040528130935.GA16819@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528130935.GA16819@outpost.ds9a.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 03:09:35PM +0200, bert hubert wrote:
> > > It's a bit of a shame that you need to be a rocket scientist to 
> > > understand the futex syscall interface.  Bert, are you still maintaining
> > > the manpage?  If so, is there enough info here to update it?
> > 
> > The latest futex(2) or futex(4) manpage I saw doesn't mention FUTEX_REQUEUE
> > at all.
> 
> Now fixed, please see http://ds9a.nl/futex-manpages - but please realise I'm
> somewhat out of my depth. Comments welcome.
> 
> Futexes have mutated into complicated things, I wonder if this was the last
> of the changes needed.
> 
> The big change in the manpages is the addition of FUTEX_REQUEUE and
> FUTEX_CMP_REQUEUE. Furthermore, I realised that the futex system call does
> not return EAGAIN etc, it returns -EAGAIN. I guesstimated that CMP_REQUEUE

futex behaves like most of the other syscalls, i.e. on error returns -1
and sets errno to the error value, like EAGAIN, EFAULT etc.
This is done in a userland wrapper around the syscall, how the kernel tells
userland an error happened and what errno value should be set is an
architecture specific implementation detail.
The man pages in the 2nd section document the behaviour of the userland
wrappers (see e.g. read(2)), not what the kernel actually returns.

> Ulrich, does/will glibc provide a futex(2) function? Or should people just
> call the syscall themselves? 

glibc doesn't provide a futex(2) function, so at least ATM people can use
#include <sys/syscall.h>
syscall (SYS_futex, &futex, FUTEX_xyz, ...) or come up with their own
assembly to invoke the syscall.

	Jakub
