Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268920AbRG0Soh>; Fri, 27 Jul 2001 14:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268921AbRG0So1>; Fri, 27 Jul 2001 14:44:27 -0400
Received: from d122251.upc-d.chello.nl ([213.46.122.251]:28686 "EHLO
	arnhem.blackstar.nl") by vger.kernel.org with ESMTP
	id <S268920AbRG0SoS>; Fri, 27 Jul 2001 14:44:18 -0400
From: bvermeul@devel.blackstar.nl
Date: Fri, 27 Jul 2001 20:47:05 +0200 (CEST)
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Hans Reiser <reiser@namesys.com>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <m1d76me0vq.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33.0107272037380.16051-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On 27 Jul 2001, Eric W. Biederman wrote:

> Hans Reiser <reiser@namesys.com> writes:
>
> > This "feature" of not guaranteeing that a write that is in progress when the
> > machine crashes will
> >
> > not write garbage, has been present in most Unix filesystems for about 25 years
> > of Unix history.
>
> A write in progress causing garabage when the power is lost is a
> driver, and drive thing.
>
> stock unix behavior is that it delays writes for up to 30 seconds,
> which in case of a crash could mean you have old data on disk.   Not
> wrong data.  This is helped because in stock unix filesystems blocks
> are rarely reallocated or moved.  In reiserfs with the btree at least
> some kinds of data are moved all over the disk.
>
> I want to suspect a btree problem on the block jumping around (it's
> a good canidate).  But unless you have messed up metadata journalling
> btree writes are journaled.  The reason I am suspecting the btree is
> that most source code files are small so probably don't have complete
> filesystem blocks of their own.

Possibly. We're talking 130 kByte in total. The above is the reason why
I don't like using reiserfs on my development system. My files get
completely garbled, with the data randomly distributed over the files last
touched. (Object files, dependency files, source files and header files)
I don't mind loosing data I've just written, but I *hate* it when it
garbles all my files.

> If you can give me an explanation of what would cause the described
> behavior of small files swapping their contents I would believe I
> would feel more secure than just a reflex ``we don't garantee all of the
> data written before power failure''.

Bas Vermeulen

-- 
"God, root, what is difference?"
	-- Pitr, User Friendly

"God is more forgiving."
	-- Dave Aronson

