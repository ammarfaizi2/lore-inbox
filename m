Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131095AbRCGP5t>; Wed, 7 Mar 2001 10:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131099AbRCGP5j>; Wed, 7 Mar 2001 10:57:39 -0500
Received: from colorfullife.com ([216.156.138.34]:44811 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131095AbRCGP53>;
	Wed, 7 Mar 2001 10:57:29 -0500
Message-ID: <000201c0a71f$3a48fae0$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Jamie Lokier" <lk@tantalophile.demon.co.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Hashing and directories
Date: Wed, 7 Mar 2001 16:56:36 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie wrote:

> Linus Torvalds wrote:
> > The long-term solution for this is to create the new VM space for
the
> > new process early, and add it to the list of mm_struct's that the
> > swapper knows about, and then just get rid of the
pages[MAX_ARG_PAGES]
> > array completely and instead just populate the new VM directly. That
> > way the destination is swappable etc, and you can also remove the
> > "put_dirty_page()" loop later on, as the pages will already be in
their
> > right places.
> >
> > It's definitely not a one-liner, but if somebody really feels
strongly
> > about this, then I can tell already that the above is the only way
to do
> > it sanely.

>  Yup. We discussed this years ago, and it nobody thought it important

> enough. mm->mmlist didn't exist then, and creating it it _just_ for

> this feature seemed too intrusive. I agree it's the only sane way to

> completely remove the limit.

I'm not sure that this is the right way: It means that every exec() must
call dup_mmap(), and usually only to copy a few hundert bytes. But I
don't see a sane alternative. I won't propose to create a temporary file
in a kernel tmpfs mount ;-)

--

    Manfred




