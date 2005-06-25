Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVFYOWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVFYOWe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 10:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVFYOWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 10:22:34 -0400
Received: from h80ad2695.async.vt.edu ([128.173.38.149]:58603 "EHLO
	h80ad2695.async.vt.edu") by vger.kernel.org with ESMTP
	id S261231AbVFYOWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 10:22:22 -0400
Message-Id: <200506251420.j5PEKce4006891@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: David Masover <ninja@slaphack.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Your message of "Fri, 24 Jun 2005 23:10:35 CDT."
             <42BCD93B.7030608@slaphack.com> 
From: Valdis.Kletnieks@vt.edu
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>
            <42BCD93B.7030608@slaphack.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119709238_3698P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 25 Jun 2005 10:20:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119709238_3698P
Content-Type: text/plain; charset=us-ascii

On Fri, 24 Jun 2005 23:10:35 CDT, David Masover said:

> But Linux is better.  DOS ain't broke, but Linux is better.  So maybe
> VFS ain't broke, but plugins would be better.  I guess we'll only know
> if we let Reiser4 merge...

No, we'll only know if we merge something that does plugins at the VFS
level in a well-designed way.

> This was about a hypothetical ext3 format as a reiser4 storage plugin.
> I'm not sure how this ties into the VFS stuff.

Very poorly.  There's only two interpretations of "ext3 as a reiser4 plugin"
that make *any* sense.  The first is that reiser4 is totally violating the VFS
layer boundary, and the second is that reiser4 is trying to be an all-singing
all-dancing wankfest.  Later on, you say:

> A lot of what people like about ext3 is its stability and fairly
> universally accepted format.  A lot of what people like about XFS is its
> stability and speed, mainly with large files.  A lot of what people like
> about Reiser4 (as it is today) is its speed, with large and especially
> with small files.

Now *think* for a moment - how does a hypothetical Reiser4 using ext3 format
gain any speed advantage with small files, when the speed advantage is based
on using a format other than ext3?

As I said, either it's violating the VFS boundary, or it's busy wanking.

The Reiser4 proponents would be well served to disavow that particular
hypothetical example - I have yet to see *anything* that does more damage
to the Reiser4 cause.

> So, in this hypothetical situation where ext3 is a reiser4 plugin,
> suddenly all the ext3 developers are trying to improve the speed and
> reliability of reiser4, which benefits both ext3 and reiser4, instead of
> just ext3.

Or we can do what *should* be done, which is:

a) Put the crack pipe down.

b) Tell reiser4 to get its grubby little paws off the VFS if it ever intends
to have a chance of being merged in mainline.

c) Have a *separate* project to improve the speed/reliability/function of
the VFS layer, which is the only way that your vision of having the ext3 and
reiser developers cooperating will ever happen.

Yes, the VFS could probably use an overhaul.  But that *will* happen like this:

1) A patch is submitted and passes review to change the VFS.
2) If appropriate, a patch for reiser4 (if it gets merged) is also submitted
(possibly by the same people) to be the first user of the new API/functionality.

There's a *reason* why we see patch streams that look like:

Patch 1/3: Add moby_foo_init function to nautical core.
Patch 2/3: Modify white_whale driver to use moby_foo_init
Patch 3/3: Modify captain_ahab driver to use moby_foo_init

> Aside from what someone else already said about this, why not just have
> support for accessing, say, a .gpg file as transparently decrypted?  You
> don't even need file-as-directory, just create a file called foo which
> is really the decrypted version of foo.gpg.  No need to change the
> format, just the filesystem.

I don't think this is what they mean by "Linux gives you enough rope to
shoot yourself in the foot with"...

> Plus, as someone else said, it's much easier to do
> $ vim /some/encrypted/file
> than
> $ gpg --decrypt /some/encrypted/file > /some/decrypted/file
> $ vim /some/decrypted/file
> $ gpg --encrypt /some/decrypted/file > /some/encrypted/file
> $ shred /some/decrypted/file

You've totally failed to understand that the whole *point* of PGP is that 'vim
/some/encrypted/file' *isnt* easy to do.  A better example might be the various
crypto-loop-ish variants or Microsoft's EFS, where the key management model is
more tractable to this sort of automation.


--==_Exmh_1119709238_3698P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCvWg1cC3lWbTT17ARAqE4AJwKKsz/KeL2vNfsEJOe9piqK8eMAQCdFCPL
rTf73AOC1LRF3Y1NUKvyJNg=
=mHH5
-----END PGP SIGNATURE-----

--==_Exmh_1119709238_3698P--
