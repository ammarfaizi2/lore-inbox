Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315939AbSEGSqs>; Tue, 7 May 2002 14:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315938AbSEGSqq>; Tue, 7 May 2002 14:46:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22788 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315937AbSEGSqo>; Tue, 7 May 2002 14:46:44 -0400
Date: Tue, 7 May 2002 11:46:06 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <benh@kernel.crashing.org>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <200205071840.g47Ie1m32403@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.44.0205071142001.1067-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 May 2002, Richard Gooch wrote:
> > Which may certainly be acceptable, of course.
>
> I wasn't suggesting a magic readlink(2). I was suggesting a *real*
> one. Device nodes get stored in the physical tree (what you call
> driverfs), and the entries in the logical tree are symlinks.

NO.

This is one backwards compatibility thing that I'm _not_ removing.

We have tons of existign /dev trees, and I'm not making them into
symlinks.

Also, you obviously haven't thought it through AT ALL. Hint: partitions.

If you have /dev/hda1, that _cannot_ be a symlink to the physical tree,
because on a physical level that partition DOES NOT EXIST. It's purely a
virtual mapping.

Yet clearly there _is_ a mapping from /dev/hda1 onto the physical device
in question, and clearly it _is_ a meaninful operation to operate on the
physical device underlying /dev/hda1.

So if you want to have a sane interface, you need to have a way to look up
the physical device that underlies /dev/hda1.

Yet it clearly cannot be a symlink.

QED.

So stop mixing up physical devices and /dev. They should NOT be handled by
the same mechanism.

		Linus

