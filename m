Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291750AbSBNQN4>; Thu, 14 Feb 2002 11:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291743AbSBNQNp>; Thu, 14 Feb 2002 11:13:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32519 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291750AbSBNQN3>;
	Thu, 14 Feb 2002 11:13:29 -0500
Message-ID: <3C6BE221.7F824863@mandrakesoft.com>
Date: Thu, 14 Feb 2002 11:13:21 -0500
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
In-Reply-To: <11830.1013700380@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> 
> Hi Linus,
> 
> This patch moves task_struct allocation from kernel/fork.c into
> arch/*/kernel/process.c.
> 
> David Mosberger wrote:
> 
> >   David.H> What might be worth doing is to move the task_struct slab
> >   David.H> cache and (de-)allocator out of fork.c and to stick it in
> >   David.H> the arch somewhere. Then archs aren't bound to have the two
> >   David.H> separate. So for a system that can handle lots of memory,
> >   David.H> you can allocate the thread_info, task_struct and
> >   David.H> supervisor stack all on one very large chunk if you so
> >   David.H> wish.
> >
> > Could you do this?  I'd prefer if task_info could be completely hidden
> > inside the x86/sparc arch-specific code, but if things are set up such
> > that we at least have the option to keep the stack, task_info, and
> > task_struct in a single chunk of memory (and without pointers between
> > them), I'd have much less of an issue with it.

Is this the first in a multi-step patch series, or something like that?

You just duplicated code in a generic location and pasted it into the
arch.  Where's the gain in that?  I do see the gain in letting the arch
allocate the task struct, but surely your patch should provide a generic
mechanism for an arch to call by default, instead of duplicating code??

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
