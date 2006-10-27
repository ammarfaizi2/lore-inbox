Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752139AbWJ0Lo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbWJ0Lo2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 07:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWJ0Lo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 07:44:28 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:35806 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1752139AbWJ0Lo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 07:44:27 -0400
X-Originating-Ip: 72.57.81.197
Date: Fri, 27 Oct 2006 07:42:31 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Roman Zippel <zippel@linux-m68k.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: so what's so special about sema_init() for alpha?
In-Reply-To: <Pine.LNX.4.64.0610271323020.6762@scrub.home>
Message-ID: <Pine.LNX.4.64.0610270730540.1899@localhost.localdomain>
References: <Pine.LNX.4.64.0610242150460.28319@localhost.localdomain>
 <Pine.LNX.4.64.0610271323020.6762@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006, Roman Zippel wrote:

> Hi,
>
> On Tue, 24 Oct 2006, Robert P. J. Day wrote:
>
> >   i'm still curious as to why the implementation for sema_init()
> > for the alpha can't be simplified as (allegedly) could all of the
> > other architecture sema_init() calls.
>
> Did you even look at the code it generates? It's not specific to
> alpha at all. Unless the structure is small enough, gcc will first
> generate a copy on the stack and then copy it to its final location.

i'm sorry, i'm not familiar with the alpha architecture but now i'm
more confused than before.  to recap, i was asking if there was an
actual *reason* why the alpha sema_init() *required* the following
implementation:

======================
static inline void sema_init(struct semaphore *sem, int val)
{
        /*
         * Logically,
         *   *sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
         * except that gcc produces better initializing by parts yet.
         */

        atomic_set(&sem->count, val);
        init_waitqueue_head(&sem->wait);
}
======================

  on the one hand, as i recall, randy dunlap referred to the comment
that "gcc produces better initializing by parts yet" as if that, by
itself, explained the necessity, although it's not clear what that
even means or what relevance it has.

  on the other hand, you seem to be suggesting that there's nothing
alpha-specific about this after all.  and the only reason i'm flogging
this is because, once upon a time, i proposed just simplifying
sema_init() across the board by having all of them just invoke
__SEMAPHORE_INITIALIZER().  i didn't think this was such a big deal,
but that idea has provoked some disagreement, although i'm still
trying to figure out what the technical obstacle is, that's all.

  so to keep things simple, the question remains, can that call be
simplified for the alpha?  yes or no?  that's all i'm looking for.

rday
