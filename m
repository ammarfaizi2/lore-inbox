Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267839AbTBRPPT>; Tue, 18 Feb 2003 10:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267840AbTBRPPT>; Tue, 18 Feb 2003 10:15:19 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:31493 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S267839AbTBRPPR>; Tue, 18 Feb 2003 10:15:17 -0500
Date: Tue, 18 Feb 2003 16:25:10 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: gskiran@bgl.vsnl.net.in
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Message Queue Implementation
Message-ID: <20030218152510.GB1399@arthur.ubicom.tudelft.nl>
References: <20030218141257.1475574B6@blr.vsnl.net.in>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20030218141257.1475574B6@blr.vsnl.net.in>
User-Agent: Mutt/1.4i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2003 at 02:22:13PM +0000, gskiran@bgl.vsnl.net.in wrote:
> [1] msgsnd (int, struct msgbuf *, int, int) INTERFACE ERROR !!

No, user error.

> [2] msgsnd() has "struct msgbuf*" as its 2nd parameter. When I tried
> to write an application which uses message queues for IPC i declared
> my message queue buffer as -
>=20
> struct my_msgq_buf
> {
>     long mtype;
>     char *name;
>     double amount;
> };

Nothing wrong over here, except that your pointer is ONLY valid in the
sending process, and NOT in the receiving process.

> I allocated the memory of name dynamically using "malloc" and wrote
> into the message Queue using msgsnd. And the msgsnd returns
> successfully. When I do an msgrcv with the above structure type, I
> always recieve NULL values in my structure buffer !!
>=20
> But, When I use the structure as declared below -
>=20
> struct my_msgq_buf
> {
>     long mtype;
>     char name[30];
>     double amount;
> };
>=20
> Every thing interstingly seems to be working fine.!

Yes, which was to be expected cause "name" is now in the the message
structure.

>  The interface for
> msgsnd and msgrcv should have "void *" pointers rather than having a
> "struct msgbuf *" as parameters.

No, it's right the way it is right now. You are making the mistake that
you think pointers are valid memory references among all processes,
which clearly is not the case.

Get the book "Advanced programming in the Unix environment" by W.
Richard Stevens. It's more than worth its price and explains SysV IPC
in a very thorough way.


Erik

--=20
J.A.K. (Erik) Mouw
Email: J.A.K.Mouw@its.tudelft.nl  mouw@nl.linux.org

--DocE+STaALJfprDB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+UlBW/PlVHJtIto0RAjMDAJ9ZY6O7vNA4SQNhS5+yq9KFXxc2kACgghv/
XqreqJlaeAKi+417ioZl24E=
=Dc5F
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
