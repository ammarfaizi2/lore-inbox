Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262137AbSJVEdS>; Tue, 22 Oct 2002 00:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262147AbSJVEdS>; Tue, 22 Oct 2002 00:33:18 -0400
Received: from merlin.sccs.swarthmore.edu ([130.58.218.7]:34823 "HELO
	merlin.sccs.swarthmore.edu") by vger.kernel.org with SMTP
	id <S262137AbSJVEdR>; Tue, 22 Oct 2002 00:33:17 -0400
Date: Tue, 22 Oct 2002 00:39:25 -0400
From: sean finney <seanius@seanius.net>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem opening multiple pipes with pipe(2) in 2.4.1[78]
Message-ID: <20021022003925.A15745@sccs.swarthmore.edu>
References: <20021021213220.A26136@sccs.swarthmore.edu> <3DB4B517.1070906@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DB4B517.1070906@redhat.com>; from drepper@redhat.com on Mon, Oct 21, 2002 at 07:16:55PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 21, 2002 at 07:16:55PM -0700, Ulrich Drepper wrote:
> The fault is entirely yours.  You're not allowed to look at errno unless
> a function, which is defined to modify error on failure, is reporting it
> failed.  Both pipe() calls work just fine and errno has some random
> value which happens to be ESPIPE for you.  Read the standard.

right.  the perror() giving nonsensical results wasn't the cause of my
problem of course, i was just trying to use it to find out why the pipe
didn't seem to work.  turns out that i missed the forest for the trees;
the pipe was being opened for writing from the wrong end...

(as a side note, the code in question was written on a solaris box, and
it seems to Just Work in the wrong direction there, go fig.)

thanks
--sean

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9tNZ9ynjLPm522B0RAhEwAJ4p2HjZw73IvMO609pUE0HfgdxytACfXUeQ
vYBH0ZyqI2EUl2HQmIld6js=
=y72D
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
