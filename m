Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261636AbSIXKUJ>; Tue, 24 Sep 2002 06:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261638AbSIXKUJ>; Tue, 24 Sep 2002 06:20:09 -0400
Received: from angband.namesys.com ([212.16.7.85]:21130 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261636AbSIXKUI>; Tue, 24 Sep 2002 06:20:08 -0400
Date: Tue, 24 Sep 2002 14:25:21 +0400
From: Oleg Drokin <green@namesys.com>
To: Jakob Oestergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org,
       Hans Reiser <reiser@namesys.com>
Subject: Re: ReiserFS buglet
Message-ID: <20020924142521.C23185@namesys.com>
References: <20020924072455.GE2442@unthought.net> <20020924132110.A22362@namesys.com> <20020924092720.GF2442@unthought.net> <20020924134816.A23185@namesys.com> <20020924100338.GH2442@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020924100338.GH2442@unthought.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Sep 24, 2002 at 12:03:38PM +0200, Jakob Oestergaard wrote:

> It's a question of which errors one wishes to handle, and which you
> simply choose to ignore.

Yes, that's true. Reiserfs chose to not handle any HW errors, this is even
written somewhere in our FAQ.

> > > this issue.  I had a disk that worked on 128 byte atomic writes - a
> > > standard IDE disk.
> > 
> > Hm. This is still much larger than 20 bytes we use.
> Assuming your 20 bytes do not span a 128 byte boundary  ;)

True. But they are located at the beginning of a block.

> And perhaps there is no disk out there with less than 128 byte atomic
> writes.  Maybe.   Do you know?  I certanly don't.

Actually I read your email and I do not see why do you think your disk
does 128 bytes atomic writes. I think this is just impossible on IDE
(for UDMA at least).

> > Actually we submit data to disk in 512 byte chunks (4k blocksize case),
> > and disk should not write any data before it receives all of it and
> > checks the integrity (hm, this is only true for UDMA, though.)
> > Still I do not see why any sane disk would start to write a sector before fully
> > receiving new sector's content (thinking of disk drives of course, solid state
> > stuff should take its own measures in this direction too).
> Please read the original mails about the IDE disk writing.
> The date is 5th of August this year, the subject was "Disk (block) write
> strangeness".

Ok, I did.
You math was wrong, you forgot to account that your number should be divided
by 128, not 512, since integer itself is 4 bytes long on x86.
(See message from Itai Nahshon <nahshon@actcom.co.il>, August 7th
Message-Id: <200208071443.30551.nahshon@actcom.co.il> if you missed that originally.)

> The conclusion really was that there is no such thing as a 512 byte
> sector.  Not in the real world.  The disk interface may emulate it, but

Probably I mssed that part of converstion, then.
As I see the IDE thing, you tell the hardware that you want to write some amount
of _sectors_ to the hard drive, and then feed the controller with necessary
amount of data. If it writes these sectors from the start of the data flow,
what will it do on data transefer timeout?
So I still think that data is written on disk in 512 bytes atomic blocks
until I see IDE device that does otherwise (and then I will probably
dig some IDE datasheet and find out they are violating some spec ;) )

> that doesn't mean that the disk is internally working with a concept
> even remotely close to that.

If they still maintain atomic sector writing, that's their right.

Bye,
    Oleg 
