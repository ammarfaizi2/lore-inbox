Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265056AbUEKXas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265056AbUEKXas (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 19:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265057AbUEKXaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 19:30:21 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:21471 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265056AbUEKX2k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 19:28:40 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Date: Wed, 12 May 2004 01:27:33 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.3.96.1040511121328.16430C-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1040511121328.16430C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405120127.33391.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 of May 2004 18:24, Bill Davidsen wrote:
> On Sun, 9 May 2004, Bartlomiej Zolnierkiewicz wrote:
> > On Sunday 09 of May 2004 19:00, Bill Davidsen wrote:
> > > No it's not that simple, this has nothing to do with binary modules,
> > > and everything to do with not making 4k stack the only available
> > > configuration in 2.6. Options are fine, but in a stable kernel series I
> > > don't think think that the default should change part way into the
> > > series, and certainly the availability of the original functionality
> > > shouldn't go away, which is what I read AKPMs original post to state as
> > > the goal.
> >
> > What functionality are you talking about?
> > We don't care about out of tree kernel code (be it GPL or Proprietary).
>
> Let me say this one more time, since you keep changing the topic so you
> can say that you don't care about something I never mentioned. I am
> **NOT** talking about binary modules, I am **NOT** talking about out of
> tree code, I am talking about applications which make calls that cause the
> **IN TREE** code to use more than 4k.

No need to flame, I really didn't know what you were talking about.

I agree that this is a very good argument against pushing this
change to mainline quickly (proposed originally by AKPM).

> > > Making changes to the kernel which will break existing applications
> > > seems to be the opposite of "stable." People who want a new kernel for
> > > fixes don't usually want to have to upgrade and/or rewrite their
> > > applications. The "we change the system interface everything we fix a
> >
> > You don't understand what the patch is really about.
> >
> > This is kernel stack not the user-space one so
> > this change can't brake any application.
>
> Right, the kernel code does not contain any places where the data passed
> in a system call isn't reflected in stack usage.

It won't break applications it will break kernel first. ;-)

You need to fix kernel code not the user space.

> > > bug" approach comes from a well-known software company, but shouldn't
> > > be the way *good* software is done.
> >
> > It doesn't change any kernel interface visible to user-space
> > and stack hungry kernel code needs fixing anyway.
>
> And what better way to detect it than to release it in a stable kernel.
> Don't bother to say "don't use -mm" AKPM has said it is intended for the
> stable kernel, work or not.

I see no problem with this approach (this patch in -mm then in linus')
but issues mentioned by you need fixing first.  I'm not proposing to
push it to mainline NOW - it needs to be done CAREFULLY but CAN be
done in 2.6 (i.e. 2.6.15).

I guess this is what we can't agree on.

> ===
> Third request for info
> ===
> I still haven't seen any objective data showing that there is any
> measureable benefit from this, although I agree that smaller is good
> practice, I don't think that throwing in a feature in a stable kernel,
> which has been reported by others to corrupt data, is the best way to do
> it.

There was some evidence from AKPM (and Arjan AFAIR).
[ BTW wasn't the corruption only seen with nvidia module? ]
I think we can prevent it by adding something ala 4kstack flag
to the module.

Regards,
Bartlomiej

