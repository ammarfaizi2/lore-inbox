Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288775AbSAELmY>; Sat, 5 Jan 2002 06:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288776AbSAELmO>; Sat, 5 Jan 2002 06:42:14 -0500
Received: from fungus.teststation.com ([212.32.186.211]:54285 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S288775AbSAELmC>; Sat, 5 Jan 2002 06:42:02 -0500
Date: Sat, 5 Jan 2002 12:41:40 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [FIX] missing piece from fs/super.c in -pre8
In-Reply-To: <Pine.LNX.4.33.0201042017410.1371-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0201051218560.3900-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Linus Torvalds wrote:

> 
> On Fri, 4 Jan 2002, Alexander Viro wrote:
> >
> > Linus, I doubt that making the thing inline was a good idea.  Reason: for
> > filesystems like NFS we almost definitely want something like server name
> > + root path to identify the superblock.  And that can easily grow past
> > 32 bytes.
> 
> Since it is only used for printouts, I'd much rather have simpler code.

FWIW, smbfs will want to know the servername + "share" used to mount it.
It will use that info to get smbconnect to do the proper magic to get a
new connection. So it doesn't have to be just printouts.

If this field is meant to be accessed by the fs code then I could put that
info there. Or someone could set it to dev_name in get_sb_nodev (if that
string is what I think it is).

Or I can do what I do now and pass it as a separate option and keep it in
a smbfs private area.

/Urban

