Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130108AbQLFBiN>; Tue, 5 Dec 2000 20:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130139AbQLFBiC>; Tue, 5 Dec 2000 20:38:02 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:16139 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130108AbQLFBiA>; Tue, 5 Dec 2000 20:38:00 -0500
Date: Tue, 5 Dec 2000 17:07:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
cc: "H. Peter Anvin" <hpa@transmeta.com>, Alan Cox <alan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: That horrible hack from hell called A20
In-Reply-To: <Pine.LNX.4.10.10012060118580.5125-100000@chaos.thphy.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.10.10012051703080.811-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2000, Kai Germaschewski wrote:

> 
> On Tue, 5 Dec 2000, H. Peter Anvin wrote:
> 
> > If you have had A20M# problems with any kernel -- recent or not --
> > *please* try this patch, against 2.4.0-test12-pre5:
> 
> Just a datapoint: This patch doesn't fix the problem here (Sony
> PCG-Z600NE). Still the spontaneous reboot exactly the moment I expect to
> get my console back from resumeing.

Actually, I bet I know what's up.

Want to bet $5 USD that suspend/resume saves the keyboard A20 state, but
does NOT save the fast-A20 gate information?

So anything that enables A20 with only the fast A20 gate will find that
A20 is disabled again on resume.

Which would make Linux _really_ unhappy, needless to say. Instant death in
the form of a triple fault (all of the Linux kernel code is in the 1-2MB
area, which would be invisible), resulting in an instant reboot.

Peter, we definitely need to do the keyboard A20, even if fast-A20 works
fine. 

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
