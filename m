Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268935AbRG0TYA>; Fri, 27 Jul 2001 15:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268930AbRG0TXk>; Fri, 27 Jul 2001 15:23:40 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:3086 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268935AbRG0TXc>; Fri, 27 Jul 2001 15:23:32 -0400
Message-ID: <3B61BF7D.306AAB45@namesys.com>
Date: Fri, 27 Jul 2001 23:22:37 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: bvermeul@devel.blackstar.nl
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <Pine.LNX.4.33.0107272037380.16051-100000@devel.blackstar.nl>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

bvermeul@devel.blackstar.nl wrote:
> 
> On 27 Jul 2001, Eric W. Biederman wrote:
> 
> > Hans Reiser <reiser@namesys.com> writes:
> >
> > > This "feature" of not guaranteeing that a write that is in progress when the
> > > machine crashes will
> > >
> > > not write garbage, has been present in most Unix filesystems for about 25 years
> > > of Unix history.
> >
> > A write in progress causing garabage when the power is lost is a
> > driver, and drive thing.
> >
> > stock unix behavior is that it delays writes for up to 30 seconds,
> > which in case of a crash could mean you have old data on disk.   Not
> > wrong data.  This is helped because in stock unix filesystems blocks
> > are rarely reallocated or moved.  In reiserfs with the btree at least
> > some kinds of data are moved all over the disk.
> >
> > I want to suspect a btree problem on the block jumping around (it's
> > a good canidate).  But unless you have messed up metadata journalling
> > btree writes are journaled.  The reason I am suspecting the btree is
> > that most source code files are small so probably don't have complete
> > filesystem blocks of their own.
> 
> Possibly. We're talking 130 kByte in total. The above is the reason why
> I don't like using reiserfs on my development system. My files get
> completely garbled, with the data randomly distributed over the files last
> touched. (Object files, dependency files, source files and header files)
> I don't mind loosing data I've just written, but I *hate* it when it
> garbles all my files.
> 
> > If you can give me an explanation of what would cause the described
> > behavior of small files swapping their contents I would believe I
> > would feel more secure than just a reflex ``we don't garantee all of the
> > data written before power failure''.
> 
> Bas Vermeulen
> 
> --
> "God, root, what is difference?"
>         -- Pitr, User Friendly
> 
> "God is more forgiving."
>         -- Dave Aronson
You should not see old data being corrupted.  If you are seeing it with a recent ReiserFS version,
we'd like your help in reproducing it.

Hans
