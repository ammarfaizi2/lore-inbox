Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261915AbREVPko>; Tue, 22 May 2001 11:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261898AbREVPkY>; Tue, 22 May 2001 11:40:24 -0400
Received: from waste.org ([209.173.204.2]:55402 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S261889AbREVPkT>;
	Tue, 22 May 2001 11:40:19 -0400
Date: Tue, 22 May 2001 10:41:48 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <Pine.GSO.4.21.0105211814130.12245-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.30.0105221030230.19818-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2001, Alexander Viro wrote:

> On Mon, 21 May 2001, Linus Torvalds wrote:
>
> > It shouldn't be impossible to do the same thing to ioctl numbers. Nastier,
> > yes. No question about it. But we don't necessarily have to redesign the
> > whole approach - we only want to re-design the internal kernel interfaces.
> >
> > That, in turn, might be as simple as changing the ioctl incoming arguments
> > of <cmd,arg> into a structure like <type,cmd,inbuf,inlen,outbuf,outlen>.
>
> drivers/net/ppp_generic.c:
>
> And that's far from being uncommon. They _do_ follow pointers. Some - more
> than once.

Doesn't matter. If we make doing it right substantially easier than doing
it wrong, then people will quit doing it wrong. And it'll be much easier
to spot the ugly hacks in patches.

I actually wrote the above a while back.. lessee.. where's that thread..

http://mlarchive.ima.com/linux-kernel/1999/Jan/4932.html

The end result was using the resource trees to hold pointers to functions
with prototypes like the above (plus file handle info). No more giant
grotty switch statements (though you could keep those if you wanted - just
point all your ioctls to the same old function). Why trees? To implement
inheritance of ioctls through the device hierarchy.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

