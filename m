Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317483AbSFMHBM>; Thu, 13 Jun 2002 03:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317484AbSFMHBM>; Thu, 13 Jun 2002 03:01:12 -0400
Received: from adsl-63-205-245-1.dsl.snfc21.pacbell.net ([63.205.245.1]:32216
	"EHLO amboise.dolphin") by vger.kernel.org with ESMTP
	id <S317483AbSFMHBK> convert rfc822-to-8bit; Thu, 13 Jun 2002 03:01:10 -0400
Date: Thu, 13 Jun 2002 00:00:39 -0700 (PDT)
From: Francois Gouget <fgouget@free.fr>
X-X-Sender: fgouget@amboise.dolphin
To: Alexander Viro <viro@math.psu.edu>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
In-Reply-To: <Pine.GSO.4.21.0206130114350.18281-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.43.0206122352100.21739-100000@amboise.dolphin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2002, Alexander Viro wrote:

>
>
> On Thu, 13 Jun 2002, Stevie O wrote:
>
> > At 12:09 AM 6/13/2002 -0400, Alexander Viro wrote:
> > >Vetoed.  Consider what happens if you rename such file, for one thing.
> >
> > I don't understand
> > What do you mean, if I rename such a file?
>
> rename("foo.lnk", "foo");

Let's not use .lnk as the extension, ok? It's an area that is still
quite sensitive <g>

So let's say that we use .!nk as the extension of our brand new symlink
implementation (assuming using '!' is ok).

Then here is how it would work:
 * if the user creates a symlink called "foo", we create a file called
"foo.!nk" on the underlying filesystem.
 * opendir+readdir does not return "foo.!nk" but instead returns "foo"
 * open("foo") opens the symlink, i.e. the VFS reads "foo.!nk"  and open
the filename contained therein
 * create("bar.!nk") is not allowed: on such a filesystem, you are not
allowed to create any file ending with ".!nk"
 * symlink(...,"...very long name") fails if the filename is too long
for VFS to append ".!nk"
 * etc.

So there are definitely limitations but I believe it could work. I am
not going to argue that it should be done though as I am happy enough
with the current situation (and it's not like I have the time to work on
it either).


--
Francois Gouget         fgouget@free.fr        http://fgouget.free.fr/
                           La terre est une bêta...

