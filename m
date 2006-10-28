Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWJ1QyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWJ1QyK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 12:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWJ1QyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 12:54:09 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:58540 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1751079AbWJ1QyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 12:54:08 -0400
X-Originating-Ip: 72.57.81.197
Date: Sat, 28 Oct 2006 12:52:13 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: why "probe_kernel_address()", not "probe_user_address()"?
In-Reply-To: <20061028092906.6c1562e3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0610281246160.2537@localhost.localdomain>
References: <Pine.LNX.4.64.0610281153180.2091@localhost.localdomain>
 <20061028092906.6c1562e3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2006, Andrew Morton wrote:

> On Sat, 28 Oct 2006 11:56:24 -0400 (EDT)
> "Robert P. J. Day" <rpjday@mindspring.com> wrote:
>
> >
> >   it seems odd that the purpose of the "probe_kernel_address()" macro
> > is, in fact, to probe a *user* address (from linux/uaccess.h):
> >
> > #define probe_kernel_address(addr, retval)              \
> >         ({                                              \
> >                 long ret;                               \
> >                                                         \
> >                 inc_preempt_count();                    \
> >                 ret = __get_user(retval, addr);         \
> >                 dec_preempt_count();                    \
> >                 ret;                                    \
> >         })
> >
> >   given that that routine is referenced only 5 places in the
> > entire source tree, wouldn't it be more meaningful to use a more
> > appropriate name?
>
> You'll notice that all callers are indeed probing kernel addresses.
> The function _could_ be used for user addresses and could perhaps be
> called probe_address().
>
> One of the reasons this wrapper exists is to communicate that the
> __get_user() it is in fact not being used to access user memory.

um ... ok.  i think.  i agree that "probe_address()" would be a more
appropriate name, but i'm still a bit confused as to why
"__get_user()" would be used to access something *not* in user memory,
given this seemingly unambiguous explanation in
include/asm-i386/uaccess.h:

=====
 * get_user: - Get a simple variable from user space.
 * @x:   Variable to store result.
 * @ptr: Source address, in user space.
 *
 * Context: User context only.  This function may sleep.
 *
 * This macro copies a single simple variable from user space to kernel
 * space.  It supports simple types like char and int, but not larger
 * data types like structures or arrays.
  ...
=====

  so having probe_kernel_address() invoke __get_user() does seem to be
just a wee bit confusing for us newbies.  in any event, i'll leave the
clarification for someone much higher up the food chain.

rday
