Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292076AbSBOJ5C>; Fri, 15 Feb 2002 04:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292081AbSBOJ4p>; Fri, 15 Feb 2002 04:56:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32272 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292076AbSBOJ4c>;
	Fri, 15 Feb 2002 04:56:32 -0500
Message-ID: <3C6CDB4D.D072A7B4@mandrakesoft.com>
Date: Fri, 15 Feb 2002 04:56:29 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@transmeta.com, davidm@hpl.hp.com,
        "David S. Miller" <davem@redhat.com>, anton@samba.org,
        linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] move task_struct allocation to arch
In-Reply-To: <12214.1013706194@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> 
> Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> > David Howells wrote:
> > > > Is this the first in a multi-step patch series, or something like that?
> > >
> > > What makes you ask that?
> >
> > Because your patch just flat out duplicates code line for line into two
> > arches.
> 
> What I do to it next depends on the feedback I get back.

Here's my feedback, then ;-)

Your patch would be ok IMHO if you additionally changed the arches to
include task struct inside struct thread_info, getting things back down
to a single allocation for thread_info+task_struct, with 'current' once
again being a constant offset from the beginning of thread_info.  [this
might require resurrecting the old patches to move task struct
definitions out of sched.h proper]

Basically, I think you are going in the right direction, but the
implementation detail of flat out copying code was what caught my
attention, and looks pretty bad to me.  Two easy ways I can think of for
providing generic code would be #include <asm-generic/foo.h>, or
enabling generic code when feature macro HAVE_ARCH_FOO is not defined.


> > I am wondering where you want to go with this, short term and long
> > term.  Is the implementation of this on other arches gonna look the same
> > -- just line for line copy of code?  With maybe ia64 as the lone
> > exception?
> 
> Ask Linus, he asked for the task_struct/thread_info split. Various people 
[...]
> any extra clock cycles. This led to Linus requesting that everything that
> entry.S needs to access be separated out into another structure (so that
> entry.S never accesses task_struct).

Seems a sane enough direction...

	Jeff


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
