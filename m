Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262793AbREVUV5>; Tue, 22 May 2001 16:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262791AbREVUVs>; Tue, 22 May 2001 16:21:48 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:65030 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S262778AbREVUVh>; Tue, 22 May 2001 16:21:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Oliver Xymoron <oxymoron@waste.org>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device arguments from lookup)
Date: Tue, 22 May 2001 22:22:35 +0200
X-Mailer: KMail [version 1.2]
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0105221231370.19818-100000@waste.org>
In-Reply-To: <Pine.LNX.4.30.0105221231370.19818-100000@waste.org>
MIME-Version: 1.0
Message-Id: <0105222222350F.06233@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 May 2001 19:49, Oliver Xymoron wrote:
> On Tue, 22 May 2001, Daniel Phillips wrote:
> > > I don't think it's likely to be even workable. Just consider the
> > > directory entry for a moment - is it going to be marked d or
> > > [cb]?
> >
> > It's going to be marked 'd', it's a directory, not a file.
>
> Are we talking about the same proposal?  The one where I can open
> /dev/dsp and /dev/dsp/ctl? But I can still do 'cat /dev/hda >
> /dev/dsp'?

We already support read/write on directories in the VFS, that's not a
problem.

> It's still a file. If it's not a file anymore, it ain't UNIX.

It's a file with the directory bit set, I believe that's UNIX.

> > > If it doesn't have the directory bit set, Midnight commander
> > > won't let me look at it, and I wouldn't blame cd or ls for
> > > complaining. If it does have the 'd' bit set, I wouldn't blame
> > > cp, tar, find, or a million other programs if they did the wrong
> > > thing. They've had 30 years to expect that files aren't
> > > directories. They're going to act weird.
> >
> > No problem, it's a directory.
> >
> > > Linus has been kicking this idea around for a couple years now
> > > and it's still a cute solution looking for a problem. It just
> > > doesn't belong in UNIX.
> >
> > Hmm, ok, do we still have any *technical* reasons?
>
> If you define *technical* to not include design, sure.

Sorry, I don't see what you mean, do you mean the design is
difficult?

> Oh, did I mention unnecessary, solvable in userspace?

That's exactly the point: the generic filesystem allows all the
funny-shaped stuff to be dealt with in user space.  The
filesystem itself is lovely and clean.

BTW, I didn't realize I was reinventing Linus's wheel, this just
seemed very obvious and natural to me.  So I had to believe
there's a technical obstacle somewhere.

Has anyone written code to demonstrate the idea?

--
Daniel
