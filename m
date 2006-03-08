Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932577AbWCHUQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbWCHUQe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 15:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbWCHUQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 15:16:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3996 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932566AbWCHUQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 15:16:32 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060308161829.GC3669@elf.ucw.cz> 
References: <20060308161829.GC3669@elf.ucw.cz>  <31492.1141753245@warthog.cambridge.redhat.com> 
To: Pavel Machek <pavel@ucw.cz>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Wed, 08 Mar 2006 20:16:11 +0000
Message-ID: <24309.1141848971@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:

> > + (*) set_mb(var, value)
> > + (*) set_wmb(var, value)
> > +
> > +     These assign the value to the variable and then insert at least a write
> > +     barrier after it, depending on the function.
> > +
> 
> I... don't understand what these do. Better explanation would
> help.. .what is function?

I can only guess, and hope someone corrects me if I'm wrong.

> Does it try to say that set_mb(var, value) is equivalent to var =
> value; mb();

Yes.

> but here mb() affects that one variable, only?

No. set_*mb() is simply a canned sequence of assignment, memory barrier.

The type of barrier inserted depends on which function you choose. set_mb()
inserts an mb() and set_wmb() inserts a wmb().

> "LOCK access"?

The LOCK and UNLOCK functions presumably make at least one memory write apiece
to manipulate the target lock (on SMP at least).

> Does it try to say that ...will be completed after any access inside lock
> region is completed?

No. What you get in effect is something like:

	LOCK { *lock = q; }
	*A = a;
	*B = b;
	UNLOCK { *lock = u; }

Except that the accesses to the lock memory are made using special procedures
(LOCK prefixed instructions, XCHG, CAS/CMPXCHG, LL/SC, etc).

> This makes it sound like pentium-III+ is incompatible with previous
> CPUs. Is it really the case?

Yes - hence the alternative instruction stuff.

David
