Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLFKrl>; Wed, 6 Dec 2000 05:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129423AbQLFKra>; Wed, 6 Dec 2000 05:47:30 -0500
Received: from xerxes.thphy.uni-duesseldorf.de ([134.99.64.10]:31981 "EHLO
	xerxes.thphy.uni-duesseldorf.de") by vger.kernel.org with ESMTP
	id <S129183AbQLFKrX>; Wed, 6 Dec 2000 05:47:23 -0500
Date: Wed, 6 Dec 2000 11:16:54 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "H. Peter Anvin" <hpa@transmeta.com>, Alan Cox <alan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: That horrible hack from hell called A20
In-Reply-To: <Pine.LNX.4.10.10012051703080.811-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10012061109210.6275-100000@chaos.thphy.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Dec 2000, Linus Torvalds wrote:

> On Wed, 6 Dec 2000, Kai Germaschewski wrote:
> 
> > 
> > On Tue, 5 Dec 2000, H. Peter Anvin wrote:
> > 
> > > If you have had A20M# problems with any kernel -- recent or not --
> > > *please* try this patch, against 2.4.0-test12-pre5:
> > 
> > Just a datapoint: This patch doesn't fix the problem here (Sony
> > PCG-Z600NE). Still the spontaneous reboot exactly the moment I expect to
> > get my console back from resumeing.

First of all, I tested removing the "or $2" in hpa's patch.
That made resume work. Then, putting back the "or" but removing the
"and $0xfe" had no effect at all (i.e. resume -> reboot).

I suppose not setting bit 1 made fast A20 enable not succeed, so kbc A20
was used -> resume works fine.

With setting bit 1 and with or w/o clearing bit 0, fast A20 enable seems
to succeed -> kbc A20 is not used -> resume reboots.


> Want to bet $5 USD that suspend/resume saves the keyboard A20 state, but
> does NOT save the fast-A20 gate information?

I suppose I'ld loose that bet.

> So anything that enables A20 with only the fast A20 gate will find that
> A20 is disabled again on resume.
> 
> Which would make Linux _really_ unhappy, needless to say. Instant death in
> the form of a triple fault (all of the Linux kernel code is in the 1-2MB
> area, which would be invisible), resulting in an instant reboot.

Makes sense to me.

test12-pre6 now works perfectly :-)

--Kai


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
