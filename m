Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132318AbRC1Bg4>; Tue, 27 Mar 2001 20:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132327AbRC1Bgr>; Tue, 27 Mar 2001 20:36:47 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:62188 "EHLO math.psu.edu") by vger.kernel.org with ESMTP id <S132318AbRC1Bgi>; Tue, 27 Mar 2001 20:36:38 -0500
Date: Tue, 27 Mar 2001 20:35:55 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Paul Jakma <paul@jakma.org>
cc: Dan Hollis <goemon@anime.net>, "H. Peter Anvin" <hpa@transmeta.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
In-Reply-To: <Pine.LNX.4.33.0103280126170.11627-100000@fogarty.jakma.org>
Message-ID: <Pine.GSO.4.21.0103272024340.24341-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Mar 2001, Paul Jakma wrote:

> On Tue, 27 Mar 2001, Dan Hollis wrote:
> 
> > On Tue, 27 Mar 2001, H. Peter Anvin wrote:
> > > c) Make sure chown/chmod/link/symlink/rename/rm etc does the right thing,
> > > without the need for "tar hacks" or anything equivalently gross.
> >
> > write-through filesystem, like overlaying a r/w ext2 on top of an iso9660
> > fs.
> 
> functionality to do this is in devfs and devfsd already.

Guys, before you get all hot and excited about devfsd - had _anyone_
audit the protocol implementation for races?  Or test it for heavy
(un)loading drivers, for that matter. We had a long history of autofs
races and devfsd is not simpler.

Coll toys are cool toys, but I wouldn't bet a dime on devfsd ability to
deal with adding/removing entries 100% correct in all cases. And /dev
has slightly larger user base than autofs, so it _is_ a sensitive area.

In its current form devfs itself _still_ contains known races. Known
since last Summer. Adding devfsd into the mix doesn't make the picture
prettier. Unless some devfs proponent is willing to do such analysis
all references to devfsd are nothing but wishful thinking.

