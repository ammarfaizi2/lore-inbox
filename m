Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261597AbSJVB0O>; Mon, 21 Oct 2002 21:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261859AbSJVB0O>; Mon, 21 Oct 2002 21:26:14 -0400
Received: from merlin.sccs.swarthmore.edu ([130.58.218.7]:29194 "HELO
	merlin.sccs.swarthmore.edu") by vger.kernel.org with SMTP
	id <S261597AbSJVB0N>; Mon, 21 Oct 2002 21:26:13 -0400
Date: Mon, 21 Oct 2002 21:32:20 -0400
From: sean finney <seanius@seanius.net>
To: linux-kernel@vger.kernel.org
Subject: problem opening multiple pipes with pipe(2) in 2.4.1[78]
Message-ID: <20021021213220.A26136@sccs.swarthmore.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi everyone

i'm not sure whether i should be sending this here or to some libc
mailing list, but i couldn't seem to find the code for pipe(2) in libc
so i'm assuming it's in the kernel.

i have a simple program that illustrates a problem i'm having in a more
complex program.  if i try to open multiple pipes with calls to pipe(),
Really Wierd Stuff seems to start happening:

#include <unistd.h>

int main(){
	int p1[2], p2[2];
	pipe(p1);
	perror("p1");
	pipe(p2);
	perror("p2");
	return 0;
}

produces the following output:

oil[~]21:22:03$ ./a.out=20
p1b: Success
p2b: Illegal seek

i'm really confused here.  first of all, pipe's manpage doesn't say
anything about setting errno to ESPIPE (which is what it's doing), and
secondly, PIPE IS RETURNING 0.  i just spent the past 4 hours trying to
figure why my program was segfaulting before i got to this, which is
even more frustrating because i was checking for errors from the result
of pipe().

so i'm hoping i've just completely overlooked something and someone will
be able to point out the error of my ways.  any advice or pointers would
really be appreciated, thanks

--sean

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9tKqkynjLPm522B0RAuDpAJ9ct2Ly+IhbuYYmJ2WgZH/wO3gmmQCgg80y
lZLyGAuYbfBXSnJb3RpY5+M=
=fP21
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
