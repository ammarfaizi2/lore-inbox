Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTLEFNT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 00:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbTLEFNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 00:13:19 -0500
Received: from h80ad251e.async.vt.edu ([128.173.37.30]:61065 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262328AbTLEFNR (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 00:13:17 -0500
Message-Id: <200312050513.hB55D1ps030713@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause? 
In-Reply-To: Your message of "Fri, 05 Dec 2003 15:23:10 +1100."
             <16336.2094.950232.375620@wombat.chubb.wattle.id.au> 
From: Valdis.Kletnieks@vt.edu
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com> <3FCFCC3E.8050008@cyberone.com.au>
            <16336.2094.950232.375620@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-707884216P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 05 Dec 2003 00:13:01 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-707884216P
Content-Type: text/plain; charset=us-ascii

On Fri, 05 Dec 2003 15:23:10 +1100, Peter Chubb said:

> As far as I know, interfacing to a published API doesn't infringe
> copyright.

Well, if the only thing in the .h files was #defines and structure definitions,
it would probably be a slam dunk to decide that, yes.

Here's the part where people's eyes glaze over:

% cd /usr/src/linux-2.6.0-test10-mm1
% find include -name '*.h' | xargs egrep 'static.*inline' | wc -l
   6288

That's 6,288 chances for you to #include GPL code and end up
with executable derived from it in *your* .o file, not the kernel's.

More to the point, look at include/linux/rwsem.h, and ask yourself
how to call down_read(), down_write(), up_read(), and up_write()
without getting little snippets of GPL all over your .o.  

And even if your module doesn't get screwed by that, there's a
few other equally dangerous inlines waiting to bite you on the posterior.

I seem to recall one of the little buggers was particularly nasty, because it
simply Would Not Work if not inlined, so compiling with -fno-inline wasn't an
option.  Unfortunately, I can't remember which it was - it was mentioned on
here a while ago when somebody's kernel failed to boot because a gcc 3.mumble
had broken inlining.....


--==_Exmh_-707884216P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/0BPdcC3lWbTT17ARAu+ZAKCxW4XDbalbvfe3ZSvnmQPf5ZK2WQCeMaL2
+qqGvumSfiA361ccZ+X48jQ=
=Rofe
-----END PGP SIGNATURE-----

--==_Exmh_-707884216P--
