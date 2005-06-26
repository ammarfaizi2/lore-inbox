Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVFZSTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVFZSTG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 14:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVFZSTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 14:19:06 -0400
Received: from h80ad261f.async.vt.edu ([128.173.38.31]:65178 "EHLO
	h80ad261f.async.vt.edu") by vger.kernel.org with ESMTP
	id S261547AbVFZSSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 14:18:02 -0400
Message-Id: <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: David Masover <ninja@slaphack.com>
Cc: Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Your message of "Sun, 26 Jun 2005 02:48:06 CDT."
             <42BE5DB6.8040103@slaphack.com> 
From: Valdis.Kletnieks@vt.edu
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com>
            <42BE5DB6.8040103@slaphack.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119809781_3659P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 26 Jun 2005 14:16:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119809781_3659P
Content-Type: text/plain; charset=us-ascii

On Sun, 26 Jun 2005 02:48:06 CDT, David Masover said:

> Lincoln Dale wrote:

> > this is the WHOLE point of standardization .. i don't think its that
> > Reiser4's EAs offer any more or less capabilities than standard EAs -
> 
> They do.  Reiser4's EAs can look like any other object -- files,
> folders, symlinks, whatever.  This is important, especially for
> transparency.

No, you want them to look like the same objects that {get|set}xattr() manage
currently.  You don't want programs to have to guess what an EA looks like
this week, with this user's combination of plugins that's different from
everybody else's.

> > lets take this a step further.  what about compression?  do we accept
> > that each filesystem can implement its own proprietary compression via
> > its own API - and now we need individual user-space tools to understand
> 
> No, that's the beauty of these "EAs" in Reiser4.  The API is standard
> write(2) commands.  sys_reiser4 supposedly implements an interface to
> make this scale better, but otherwise have the same semantics.  And who
> said anything about proprietary compression?  I think we were planning
> on the kernel's zlib, though we might have been planning to make it a
> bit more seekable...
> 
> > each of these APIs?
> 
> So, the API becomes something like:
> 
> cat crypto/inflated/foo		# transparently decompressed
> cat crypto/raw/foo.gz		# raw, gzip-compressed

And 'cat crypto/raw/foo' or 'crypto/inflated/foo.gz' gets you what, exactly?

Now throw some .bz2 and .zip files into the mix... ;)

> Another possibility, if you like file-as-a-directory:
> 
> cat foo.gz			# raw
> cat foo.gz/inflated		# decompressed
> 
> One could easily imagine things like these two potentially equivalent
> commands:
> 
> cp foo bar.zip/
> zip bar foo

Unless of course the user had done 'mkdir sorted.by.city.zip' to make
a directory of files containing data sorted by USPS Zip code.

And what happens if the user has a file 'bar' that's not a ZIP file,
and a directory 'bar.zip' isn't a view into 'bar'?

Most of the time, if I have a file 'linux-2.6.12.tar.bz2' and a
directory 'linux-2.6.12', what is under the directory is *NOT* the same
data as what's in the .bz2 - I've done 'make oldconfig' and a few builds
and some variable amount of patching, usually with rejects, and I *don't*
want that .bz2 being updated during all this (hint - what's my next command
after 'rm -rf linux-2.6.12' likely to be, and why, and  what expectations
do I have when I do it?)

You want to think this sort of thing through *really* thoroughly, because
there's a *lot* of things, both users and programs, that have expectations
about The Way Things Work.

> The whole point is to have less userland tools, not more.  I'm not
> saying we move zip into the kernel, just that the user now has one less
> command to remember.

But now instead of having to remember the one meme "I can manage any
compressed-archive format that's stored in a file, and put other files in it,
and all I need is the appropriate userspace tool", they have to remember "the
cp trick works for .zip and .tar, but I'll get a "not a directory" error if I
try it with a .hqx file, and that other file format may or may not work,
because I can't remember if this kernel has a working out-of-tree module for
this kernel...."


--==_Exmh_1119809781_3659P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCvvD1cC3lWbTT17ARAsd7AKDFfaRMu7syu+Mfp7vDbwGLxPFgYgCggVI1
eWZRdBbusKt0+c/Y6Vyj04c=
=LXfT
-----END PGP SIGNATURE-----

--==_Exmh_1119809781_3659P--
