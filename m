Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262164AbRETT22>; Sun, 20 May 2001 15:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262168AbRETT2S>; Sun, 20 May 2001 15:28:18 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:54541 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262165AbRETT2M>; Sun, 20 May 2001 15:28:12 -0400
Date: Sun, 20 May 2001 12:27:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code 
In-Reply-To: <Pine.GSO.4.21.0105201509060.8940-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0105201217320.7712-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 20 May 2001, Alexander Viro wrote:
> 
> Pheeew... Could you spell "about megabyte of stuff in ioctl.c"?

I agree. But it would certainly force people to think about this. And it
may turn out that a lot of it can be streamlined, and not that much ends
up being used very much.

It would also allow a single place of catching the generic ones, and as
such be a place to try to make things like the network ioctl's more
regular: setting things like network device duplex with _real_ interfaces
instead of hiding it in ioctl routines.

Also, note that many ioctl's actually do have fairly regular meaning, and
that it _is_ possible to catch a number of them with those regular
things:

	switch (_IOC_TYPE(number)) {
	case 'x':
		xfs_ioctl(..);

and actually try to enforce the things that Documentation/ioctl-number.txt
tries to document. And make the clashes _explicit_ and thus make people
have more incentive to really try to fix it.

> How about moratorium on new ioctls in the meanwhile? Whatever we do in
> fs/ioctl.c, it _will_ take time.

Ehh.. Telling people "don't do that" simply doesn't work. Not if they can
do it easily anyway. Things really don't get fixed unless people have a
certain pain-level to induce it to get fixed.

		Linus

