Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282690AbRLUXOE>; Fri, 21 Dec 2001 18:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283717AbRLUXNy>; Fri, 21 Dec 2001 18:13:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47370 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282690AbRLUXNg>; Fri, 21 Dec 2001 18:13:36 -0500
Date: Fri, 21 Dec 2001 15:11:35 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <torrey.hoffman@myrio.com>, <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd 
 kern el panic woes
In-Reply-To: <Pine.GSO.4.21.0112210151020.15555-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0112211510370.2370-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 21 Dec 2001, Alexander Viro wrote:
>
>
> On Thu, 20 Dec 2001, Linus Torvalds wrote:
>
> >
> > On Thu, 20 Dec 2001, Alexander Viro wrote:
> > >
> > > AFAICS, it's nastier than that.  What's to stop buffer_heads to be
> > > freed under memory pressure?
> >
> > They'll be dirty if they are modified, and if they aren't modified they
> > are zero.
> >
> > In the first case they won't be free'd, in the second care we don't care.
> > So we're ok.
>
> Umm...  _Page_ will be dirty, all right.  buffer_heads are cleaned when
> you submit IO and I don't see anything that would mark them dirty again...

But the "submit IO" will _mark_ the page dirty and uptodate, so once it is
so marked, it should never be overwritten.

Now, as I already sent out to Andrea, I think out actual IO routines look
suspiciously complex and bogus.

		Linus

