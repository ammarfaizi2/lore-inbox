Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133039AbRAQSDt>; Wed, 17 Jan 2001 13:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133015AbRAQSD3>; Wed, 17 Jan 2001 13:03:29 -0500
Received: from wpk-smtp-relay2.cwci.net ([195.44.63.19]:15130 "EHLO
	wpk-smtp-relay.cwci.net") by vger.kernel.org with ESMTP
	id <S132955AbRAQSDQ>; Wed, 17 Jan 2001 13:03:16 -0500
Date: Wed, 17 Jan 2001 00:37:49 +0000 (UTC)
From: Mo McKinlay <mmckinlay@gnu.org>
To: Peter Samuelson <peter@cadcamlab.org>
cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        "James H. Cloos Jr." <cloos@jhcloos.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: named streams, extended attributes, and posix
In-Reply-To: <20010116182806.B6364@cadcamlab.org>
Message-ID: <Pine.LNX.4.30.0101170035340.364-100000@nvws005.nv.london>
Organization: inter/open Labs
X-URL: http://www.interopen.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Yesterday, Peter Samuelson (peter@cadcamlab.org) wrote:

  >
  > [Michael Rothwell]
  > > It seems that if you move a file with a colon -- "file:colon" -- in
  > > the name from Ext2 to "StreamFS," you would end up with a file named
  > > "file" with a stream named "colon". When copying back, you would get
  > > "file:colon" back.
  >
  > What if you copy both 'filename' and 'filename:ext' onto the same fs?
  > Do they get combined into one file?  That to me violates principle of
  > least surprise.  The fs should just mangle filenames it doesn't agree
  > with, like the existing legacy filesystems already do.

  > Any semantics by which 'filename:stream' and 'filename' refer to the
  > same file would be b0rken.  If instead you use 'filename/stream'
  > syntax, at least that is an illegal filename on *all* Linux
  > filesystems, so this particular point of confusion does not come up.

Urgh.

We went through this last time around. What happens to directories  with
streams? If they are also dirname/stream, what happens when you have  a
file called 'stream' within 'dirname'?

Also, it makes it appear that files with streams are directories, which
they are not, so applying the directory accessor to them violates the
principle of least suprise and is misleading. Apply a new accessor (which
the colon would be great for, as it is already used for this purpose --
apart from the  fact that POSIX already allows applications to use it in
filenames).

- -- 
Mo McKinlay
mmckinlay@gnu.org
- -------------------------------------------------------------------------
GnuPG/PGP Key: pub  1024D/76A275F9 2000-07-22





-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjpk6V8ACgkQRcGgB3aidfkLgACfZZ1+5klZUB/NKTDK9PoRlV2H
ddcAoKBJSYA5/02Y8+dV9zyZHi5hUCeK
=ptqG
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
