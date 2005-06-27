Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVF0AoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVF0AoM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 20:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVF0AoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 20:44:12 -0400
Received: from h80ad25fc.async.vt.edu ([128.173.37.252]:43715 "EHLO
	h80ad25fc.async.vt.edu") by vger.kernel.org with ESMTP
	id S261684AbVF0AoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 20:44:02 -0400
Message-Id: <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: David Masover <ninja@slaphack.com>
Cc: Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Your message of "Sun, 26 Jun 2005 17:35:48 CDT."
             <42BF2DC4.8030901@slaphack.com> 
From: Valdis.Kletnieks@vt.edu
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu>
            <42BF2DC4.8030901@slaphack.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119832829_3659P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 26 Jun 2005 20:40:29 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119832829_3659P
Content-Type: text/plain; charset=us-ascii

On Sun, 26 Jun 2005 17:35:48 CDT, David Masover said:

> > Right. So please explain what crypto/raw/foo and crypto/inflated/foo.gz give you.
> 
> In that example (shouldn't have used the name "crypto", but oh well), it
> should be crypto/raw/foo.gz and crypto/inflated/foo -- where foo.gz is
> the gzip'ed file and foo is the transparently compressed/decompressed
> file.  Basically, these are equivalent:
> 
> $ zcat crypto/raw/foo.gz
> $ cat crypto/inflated/foo

I'm *quite* aware of what your preconceived notions think it *should* be.

Maybe the two examples I asked for have *real-world* meanings that you should
be allowing for.  Like, for instance, on a mail server, where the A/V software
may need to unzip a file 5 or 6 times to find out if there's malicious content.

Or seeing if it's a ".zip bomb", where a small .zip will decompress to gigabytes.

Or I'm testing a new compression algorithm, to see if multiple compressions help
(yes, I know that it *shouldn't* help - but I've seen real-world cases where the
algorithm could only look at a 4K or 8K window at a time, and if you hit a *very*
long run of duplicate 4K segments, a second compression would compress all the
identical or near-identical "this is a 4K chunk" tokens...)


> > It's got a *LOT* to do with it if I created a *DIRECTORY*, to use *AS A DIRECTORY*,
> > the way Unix-style systems have done for 3 decades, and suddenly my system is
> > running like a pig because the kernel decided that it's a .zip file.
> 
> The kernel does not decide that.  You do.  And it doesn't automatically
> decide that every time you create a file.  You have to use some
> interface to trigger the plugins.

Oh, I'm waiting for the fun the first time somebody deploys a plugin that
has similar semantics to 'chmod g+s dirname/' ;)

> I guess I need a new name for this approach.  That's three possible ways
> of doing this?

I *said* you need to think this through in detail, didn't I? ;)
 
> I remember discussing that, actually.  It wouldn't automatically do this
> if you didn't want it to, but it would be nice if, say, it was something
> truly seekable like linux-2.6.12.zip, and linux-2.6.12 was a
> user-created symlink to linux-2.6.12.zip/.../contents, and we had a nice
> caching system...

I think you're highly deluded as to just how much or little performance gain
this will get you. Model what happens with a kernel 'make' on a 256M machine
with and without all that zipping and compressing, and assume that a constant
48M is available for caching of the linux-2.6.12/ tree.

> This is nice because then you get exactly the same performance during
> "make" as you would with "unzip && make", only better, because files you
> don't ever use (lots of arch, for instance) are not unpacked.

Go read http://www.tux.org/lkml/#s7-7 and ponder until enlightenment arrives.


--==_Exmh_1119832829_3659P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCv0r9cC3lWbTT17ARAioEAKD6ujpDz4cvD+IpIhG5mr8NM8ZTcwCgxSJs
v3GCV/KJ+iNuWP+i0YCLQYA=
=uzbN
-----END PGP SIGNATURE-----

--==_Exmh_1119832829_3659P--
