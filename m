Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSEVSnP>; Wed, 22 May 2002 14:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316678AbSEVSnO>; Wed, 22 May 2002 14:43:14 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:15877 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S316674AbSEVSnL>; Wed, 22 May 2002 14:43:11 -0400
Date: Wed, 22 May 2002 20:43:09 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Pavel Machek <pavel@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap.
In-Reply-To: <20020521211727.GG22878@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.44.0205222029260.29194-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc: cleared]

On Tue, 21 May 2002, Pavel Machek wrote:

> Hi!
> 
> > > I thought POSIX made it explicit that you may SIGSEGV or EFAULT at your
> > > option. If that SUS rule is stupid, we should just drop it.
> > > 
> > > Performance advantage from MMX-copy-to-user is probably well worth it.
> > 
> > Stop this STUPID "it speeds things up" argument.
> > 
> > It's not TRUE.
> > 
> > We still have to do exactly the same things we do right now, because even
> > if we SIGSEGV we still have to return the right number of bytes
> > read/written. 
> > 
> > SIGSEGV doesn't mean that the system call wouldn't complete. It removes 
> > _none_ of the kernel fixup handling, because the SIGSEGV won't be 
> > delivered until we return to user mode anyway. So please stop mixing these 
> > two issues up.
> 
> If you pass bad pointer to memcpy(), you don't expect any reasonable
> return value, right?
> 
> So if you pass bad pointer to read(), why would you expect "number of
> bytes read" return? Its true that kernel can't simply not return
^^^^^^^^^^^^^^^^^^^^

Because read() may *consume* its input, while memcpy() it's only a copy and
leaves the source intact (if you care not to overlap src and dst).
If you're read()ing from a serial line with 1-byte fifo you want to
know how many chars you read successfully in the first place, since
once read, they're gone. SIGSEGVing won't help in re-reading the chars.

> anything, but giving SIGSEGV and returning -EFAULT seems pretty
> reasonable to me. If they really want to, they might extract number of
> bytes read from address SIGSEGV occured at [but that's dirty hack, and
> people will hopefully realise that and not rely on it].
> 								Pavel

.TM.

