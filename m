Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267590AbTGLE4q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 00:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbTGLE4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 00:56:46 -0400
Received: from h80ad26c8.async.vt.edu ([128.173.38.200]:38784 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267590AbTGLE4h (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 00:56:37 -0400
Message-Id: <200307120511.h6C5BCSe017963@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: jcwren@jcwren.com, linux-kernel@vger.kernel.org
Subject: Re: Bug in open() function (?) 
In-Reply-To: Your message of "Fri, 11 Jul 2003 20:38:09 PDT."
             <20030711203809.3c320823.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20030712011716.GB4694@bouh.unh.edu> <16143.25800.785348.314274@cargo.ozlabs.ibm.com> <20030712024216.GA399@bouh.unh.edu> <200307112309.08542.jcwren@jcwren.com>
            <20030711203809.3c320823.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1059107493P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 12 Jul 2003 01:11:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1059107493P
Content-Type: text/plain; charset=us-ascii

On Fri, 11 Jul 2003 20:38:09 PDT, Andrew Morton said:
> "J.C. Wren" <jcwren@jcwren.com> wrote:
> >
> > I was playing around today and found that if an existing file is opened wit
h 
> >  O_TRUNC | O_RDONLY, the existing file is truncated.
> 
> Well that's fairly idiotic, isn't it?

Not idiotic at all, and even if it was, it's still contrary to specific
language in the manpage.

I could *easily* see some program having a line of code:

	if (do_ro_testing) openflags |= O_RDONLY;

I'd not be surprised if J.C. was playing around because a file unexpectedly
shrank to zero size because of code like this.  There's a LOT of programs that
implement some sort of "don't really do it" option, from "/bin/bash -n" to
"cdrecord -dummy".  So you do something like the above to make your
file R/O - and O_TRUNC *STILL* zaps the file, in *direct violation* of
the language in the manpage.

Whoops.  Ouch. Where's the backup tapes?

> The Open Group go on to say "The result of using O_TRUNC with O_RDONLY is
> undefined" which is also rather silly.
> 
> I'd be inclined to leave it as-is, really.

I hate to think how many programmers are relying on the *documented* behavior to
prevent data loss during debugging/test runs....

/Valdis

--==_Exmh_1059107493P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/D5hvcC3lWbTT17ARAvh6AJwLQ+y9s28aiDECevt9dIj7Rg/+rwCgvD2u
aOH5r9dx9Jx77yvEjQoJnYE=
=LOWr
-----END PGP SIGNATURE-----

--==_Exmh_1059107493P--
