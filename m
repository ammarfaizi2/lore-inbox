Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262031AbREUTHI>; Mon, 21 May 2001 15:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262075AbREUTG7>; Mon, 21 May 2001 15:06:59 -0400
Received: from waste.org ([209.173.204.2]:7536 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262068AbREUTGs>;
	Mon, 21 May 2001 15:06:48 -0400
Date: Mon, 21 May 2001 14:08:15 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending DeviceNum
In-Reply-To: <Pine.GSO.4.21.0105211437040.12245-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.30.0105211352540.17263-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2001, Alexander Viro wrote:

> On Mon, 21 May 2001, Oliver Xymoron wrote:
>
> > K - so what? I'm guessing what you want me to see is that these
> > implement multiple channels. Is there a reason that eia001stat couldn't be
> > implemented as
> >
> >  f=open("/dev/eia001ctl",O_RDWR);
> >  write(f,"stat\n");
> >  status=read(f); /* returns "stat foo\n" */
>
> Less convenient.

True enough.

> > We don't want to implement a separate device node for every OOB ioctl that
> > returns data, do we? Why should stat be any different?
>
> For every? Probably not. Forcing all of them together? I bet that in many
> cases it will be damn inconvenient. You are forcing the policy on all
> drivers. For no good reason, AFAICS.

No - I'm merely pointing out that it's sufficient. And I'm pretty sure we
want to make additional control or stream interfaces the exception rather
than the rule. And having a standard read and write protocol of some sort
for ctl devices is more or less mandatory, otherwise they will all work
differently. This is not to say driver writers aren't allowed to depart
from it, just that it'll be more work if they do.

> > /dev/draw is interesting but largely irrelevant. And again, colormap and
> > refresh - why are they not part of ctl? You've got to select on refresh
> > anyway, might as well accept asynchronous messages through ctl.
>
> You've got to do _what_ on refresh?

I'm guessing some sort of poll or select on the refresh device, assuming a
single-threaded app. But no, I've never used 9 nor am I especially
interested in exploring it in depth, given its license and lack of
community.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

