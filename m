Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265464AbUBPIyV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 03:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265476AbUBPIyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 03:54:21 -0500
Received: from h80ad2465.async.vt.edu ([128.173.36.101]:32667 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265464AbUBPIyT (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 03:54:19 -0500
Message-Id: <200402160854.i1G8s8cp030889@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Cc: Jan Knutar <jk-lkml@sci.fi>, linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior 
In-Reply-To: Your message of "Mon, 16 Feb 2004 09:30:41 +0100."
             <1076920241.11055.4.camel@ulysse.olympe.o2t> 
From: Valdis.Kletnieks@vt.edu
References: <1076886183.18571.14.camel@m222.net81-64-248.noos.fr> <200402160545.04175.jk-lkml@sci.fi>
            <1076920241.11055.4.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1161594719P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Feb 2004 03:54:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1161594719P
Content-Type: text/plain; charset=us-ascii

On Mon, 16 Feb 2004 09:30:41 +0100, Nicolas Mailhot said:

> You're assuming the situation is merely a iso8859-1 to utf-8 migration.
> Far from it. The core problem is everyone damn wrote what it pleased him
> without considering future readers.

Given the fact that there isn't in general any way for the kernel to know what
was intended, I don't see how any kernel policy other than "NUL and / are
special, but if you use anything other than UTF-8 it will eventually come back
to haunt you" can possibly be made to work.

For that matter, I have seen actual production code that intentionally created
fairly deep directory trees and terminal file names that were basically hashes
written in radix-254 and blatted out in binary.  Lots of them.  The original
problem report I got was along the lines of "We installed XYZ, and the file
system appears corrupted - ls -R weird the screen out, and 'find | wc -l' is
127,000 different than what 'df -i' reports".

I was ready to strangle the guilty party - radix-64 wouldn't have been a big
efficiency hit and at least the uuencode/base-64 charset doesn't weird your
terminal out. :)

So it's not even always possible to make the assumption that the filename is
supposed to make sense in *any* charset. This one requires fixing in some
combination of userspace and meatspace....


--==_Exmh_-1161594719P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAMIUvcC3lWbTT17ARAvwhAKDsJqfcnwoHjUvqh8sdoIG6ZFWbWQCeLa/o
uUY1680faiJDGXz1fIUhtoM=
=kMFI
-----END PGP SIGNATURE-----

--==_Exmh_-1161594719P--
