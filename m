Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269594AbUJLK2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269594AbUJLK2C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 06:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269596AbUJLK2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 06:28:02 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:14991 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S269594AbUJLK1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 06:27:55 -0400
Date: Tue, 12 Oct 2004 12:27:31 +0200
From: Jan Hudec <bulb@ucw.cz>
To: aq <aquynh@gmail.com>
Cc: suthambhara nagaraj <suthambhara@gmail.com>,
       "Dhiman, Gaurav" <gaurav.dhiman@ca.com>,
       main kernel <linux-kernel@vger.kernel.org>,
       kernel <kernelnewbies@nl.linux.org>
Subject: Re: Kernel stack
Message-ID: <20041012102731.GQ703@vagabond>
References: <577528CFDFEFA643B3324B88812B57FE3055B9@inhyms21.ca.com> <46561a790410112351942e735@mail.gmail.com> <20041012094104.GM703@vagabond> <9cde8bff04101203052a711063@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mzmkN2k+aDjaU9Rr"
Content-Disposition: inline
In-Reply-To: <9cde8bff04101203052a711063@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mzmkN2k+aDjaU9Rr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 12, 2004 at 19:05:52 +0900, aq wrote:
> > There is no SS entry, because SS does not specify the stack. It is siply
> > a segment in which the stack lives. Any segment, that covers all address
> > space will do! IIRC in kernel SS =3D=3D DS.
> yes, if I am right, in Linux SS, DS and CS all point to the same base
> address ( =3D 0 ?). To be exact, SS !=3DDS, since the segment registers in
> protected mode point to segment selectors (in GDT ?), and we should
> compare the value stored GDT entries, not the value of SS and DS in
> this case.

Of course. Though since DS and SS need the same parameters, they might
actualy point to the same GDT entry. I don't know if they actualy do,
though.

By the way, C compilers usualy set SS and DS with same base. They would
have to do conversion when taking pointers to local variables otherwise.

> > The kernel stack is allocated together with the task_struct. Two pages
> > are allocated and task_struct is placed at the start while the stack is
> > placed at the end and grows down towards the task_struct.
> 2 pages of kernel stack or not is optional. Recently version of kernel
> allow you to choose to use 4K or 8K size for kernel stack.

Yes, it does. Few people touch the "Kernel Hacking" though...

> >From what you all discuss, I can say: kernel memory is devided into 2
> part, and the upper part are shared between processes. The below part
> (the kernel stack, or 8K traditionally) is specifict for each process.
>=20
> Is that right?

No, it's not. There is just one kernel memory. In it each process has
it's own task_struct + kernel stack (by default 8K). There is no special
address mapping for these, nor are they allocated from a special area.

When a context of some process is entered, esp is pointed to the top of
it's stack. That's exactly all it takes to exchange stacks.

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--mzmkN2k+aDjaU9Rr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBa7GTRel1vVwhjGURAqn0AKDjRhPCtV7uDD9xjRmOB8FRLioUzQCcDmMH
XDRedeKoy/+IGnUdLo0Di84=
=adpt
-----END PGP SIGNATURE-----

--mzmkN2k+aDjaU9Rr--
