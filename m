Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbRBHNX2>; Thu, 8 Feb 2001 08:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129149AbRBHNXS>; Thu, 8 Feb 2001 08:23:18 -0500
Received: from [195.63.194.11] ([195.63.194.11]:41232 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S129033AbRBHNXA>; Thu, 8 Feb 2001 08:23:00 -0500
Message-ID: <3A82A8FA.CB9B2F29@evision-ventures.com>
Date: Thu, 08 Feb 2001 15:11:06 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Ben LaHaise <bcrl@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.10.10102060959520.1257-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 6 Feb 2001, Ben LaHaise wrote:
> >
> > On Tue, 6 Feb 2001, Stephen C. Tweedie wrote:
> >
> > > The whole point of the post was that it is merging, not splitting,
> > > which is troublesome.  How are you going to merge requests without
> > > having chains of scatter-gather entities each with their own
> > > completion callbacks?
> >
> > Let me just emphasize what Stephen is pointing out: if requests are
> > properly merged at higher layers, then merging is neither required nor
> > desired.
> 
> I will claim that you CANNOT merge at higher levels and get good
> performance.
> 
> Sure, you can do read-ahead, and try to get big merges that way at a high
> level. Good for you.
> 
> But you'll have a bitch of a time trying to merge multiple
> threads/processes reading from the same area on disk at roughly the same
> time. Your higher levels won't even _know_ that there is merging to be
> done until the IO requests hit the wall in waiting for the disk.

Merging is a hardware tighted optimization, so it should happen, there
we you
really have full "knowlendge" and controll of the hardware -> namely the
device driver. 

> Qutie frankly, this whole discussion sounds worthless. We have solved this
> problem already: it's called a "buffer head". Deceptively simple at higher
> levels, and lower levels can easily merge them together into chains and do
> fancy scatter-gather structures of them that can be dynamically extended
> at any time.
> 
> The buffer heads together with "struct request" do a hell of a lot more
> than just a simple scatter-gather: it's able to create ordered lists of
> independent sg-events, together with full call-backs etc. They are
> low-cost, fairly efficient, and they have worked beautifully for years.
> 
> The fact that kiobufs can't be made to do the same thing is somebody elses
> problem. I _know_ that merging has to happen late, and if others are
> hitting their heads against this issue until they turn silly, then that's
> their problem. You'll eventually learn, or you'll hit your heads into a
> pulp.

Amen.

-- 
- phone: +49 214 8656 283
- job:   STOCK-WORLD Media AG, LEV .de (MY OPPINNIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort:
ru_RU.KOI8-R
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
