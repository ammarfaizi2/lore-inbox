Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280101AbRKHOli>; Thu, 8 Nov 2001 09:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280032AbRKHOl3>; Thu, 8 Nov 2001 09:41:29 -0500
Received: from mail.mtroyal.ab.ca ([142.109.10.24]:43282 "EHLO
	mail.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S280015AbRKHOlM>; Thu, 8 Nov 2001 09:41:12 -0500
Date: Thu, 08 Nov 2001 07:41:08 -0700 (MST)
From: James Bourne <jbourne@MtRoyal.AB.CA>
Subject: Re: Memory accounting problem in 2.4.13, 2.4.14pre, and possibly 2.4.14
In-Reply-To: <3BEA116A.646B9159@zip.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.33.0111080727100.32443-100000@jbourne2.mtroyal.ab.ca>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
X-Comment: This communication is intended for the use of the recipient to which
 it is
X-Comment: addressed, and may contain confidential, personal, and or privileged
X-Comment: information.  Please contact the sender immediately if you are not
 the
X-Comment: intended recipient of this communication, and do not copy,
 distribute, or
X-Comment: take action relying on it.  Any communication received in error, or
X-Comment: subsequent reply, should be deleted or destroyed.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2001, Andrew Morton wrote:

> Mike Fedyk wrote:
> >
> > >
> >
> > I am running unpatched 2.4.14 now.
> >
> > Do you still want me to try this patch now that you know I have been able to
> > see the problem with 2.2.14+ext3?
> >
>
> It's OK - I can reproduce it easily anyway.
>
> There are two things here.  Recent -ac kernels had a merge
> bug down in the /proc code which caused `Cached:' to go
> negative.  It was recently fixed.
>
> And quite independently, current ext3 for Linus kernels now has a
> bug which causes the `buffermem_pages' number to get too large.
> This has the exact same effect: `Cached:' goes negative.

I can confirm this, with the ext3 0.9.14p8 and 0.9.15 patches for 2.4.14 our
buffer and cache values become very off the wall.  Without ext3 the system
is fine (we are currently running 2.4.14 without ext3).

>
> The buffermem_pages counter is purely for reporting - no VM decisions are
> based on its value.  But if it worries you, just remove line 1933 of
> fs/jbd/transaction.c.

This is good to hear.

Regards
Jim

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************

