Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278657AbRJXQq1>; Wed, 24 Oct 2001 12:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278659AbRJXQqL>; Wed, 24 Oct 2001 12:46:11 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64524 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278657AbRJXQqG>; Wed, 24 Oct 2001 12:46:06 -0400
Date: Wed, 24 Oct 2001 09:45:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Michael H. Warfield" <mhw@wittsend.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>,
        Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <20011024123619.A21416@alcove.wittsend.com>
Message-ID: <Pine.LNX.4.33.0110240935510.8049-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Oct 2001, Michael H. Warfield wrote:
>
> > I will _refuse_ to have a kernel suspend that synchronizes the raid etc.
> > That would make suspend/resume potentially take a _loong_ time.
>
> 	If you have Magic SysRq enabled, would that do the job prior
> to suspend?  Typically with Pavel's swsusp package, I hit the Alt-SysRq-s
> before hitting Alt-SysRq-d to suspend him.  Does Alt-SysRq-s synchronize
> a raid?  Of course, at that point, the choice to take the "_loong_ time"
> is in user space - meat space, user space - since I chose to hit that
> key combination.

Sure. I only refuse to have it be "integrated" into the suspend - but it's
certainly perfectly fine to have "combination events", whether by having
special keystrokes that starts them or by having scripts or programs that
first do the sync and then do "echo 3 > /proc/acpi/sleep" or whatever.

> 	What does the Alt-SysRq-s combination do about networks then?

I think it just does a "fsync_dev()", which will do the right thing for
network filesystems too.

But let's make an example: let's assume that I'm working on my laptop, and
the NFS server goes down so I decide to take a break. Should I not be able
to suspend, only because the sync won't finish?

That's the wrong answer. By _default_ I should just suspend, and when I
come back it will continue to try to write back the data (not by any
magical suspend/resume means, but just because that's what NFS does anyway
when the server hasn't answered)

			Linus

