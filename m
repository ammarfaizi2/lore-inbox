Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261618AbTCKVJw>; Tue, 11 Mar 2003 16:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261620AbTCKVJw>; Tue, 11 Mar 2003 16:09:52 -0500
Received: from oasis.frogfoot.net ([66.8.28.51]:40883 "HELO oasis.frogfoot.net")
	by vger.kernel.org with SMTP id <S261618AbTCKVJt>;
	Tue, 11 Mar 2003 16:09:49 -0500
Date: Tue, 11 Mar 2003 23:19:02 +0200
From: Abraham van der Merwe <abz@frogfoot.net>
To: kuznet@ms2.inr.ac.ru
Cc: devik@cdi.cz, ahu@ds9a.nl, linux-kernel@vger.kernel.org,
       david@uninetwork.co.za, netdev@oss.sgi.com
Subject: Re: kernel panic: bug in sch_sfq.c
Message-ID: <20030311211902.GA8699@oasis.frogfoot.net>
Mail-Followup-To: kuznet@ms2.inr.ac.ru, devik@cdi.cz, ahu@ds9a.nl,
	linux-kernel@vger.kernel.org, david@uninetwork.co.za,
	netdev@oss.sgi.com
References: <20030311155409.GB7641@oasis.frogfoot.net> <200303111608.TAA13074@sex.inr.ac.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <200303111608.TAA13074@sex.inr.ac.ru>
User-Agent: Mutt/1.3.28i
Organization: Frogfoot Networks
X-Operating-System: Debian GNU/Linux oasis 2.4.20-rc1 i686
X-GPG-Public-Key: http://oasis.frogfoot.net/pgpkeys/keys/frogfoot.gpg
X-Uptime: 22:58:38 up 69 days, 10:25,  8 users,  load average: 0.02, 0.01, 0.00
X-Edited-With-Muttmode: muttmail.sl - 2001-09-27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi kuznet!

> > Also, if I compile the kernel with all debugging enabled (CONFIG_DEBUG_=
SLAB,
> > etc) I can reliably trigger the BUG() on line 1263 in mm/slab.c
>=20
> How does backtrace oops look?

I didn't write down most of the BUG() panics, but here is one (unfortunately
it doesn't have any QoS code in the stack trace):

------------< snip <------< snip <------< snip <------------
root@trillian:~/uni-qos# cat panic.txt
c0192eb1
c0176c8c
c017718c
c0176afa
c010810f
c01082b3
c0105240
c0105240
c0105240
c0105240
c0105263
c01052d2
c0105000
c0105027

0f 0b ef 04 e0 87 1e c0 f7 c5 00 04 00 00 74 36 b8 a5 c2 0f

EIP: 0010:c012642e
ESP: c0221eb4

KERNEL BUG slab.c:1263
root@trillian:~/uni-qos#
------------< snip <------< snip <------< snip <------------

A quick objdump through the kernel's vmlinux image reveals, that the stack
trace above looks as follows:

------------< snip <------< snip <------< snip <------------
c0192eb1    alloc_skb
c0176c8c    speedo_refill_rx_buf
c017718c    speedo_rx
c0176afa    speedo_interrupt
c010810f    handle_IRQ_event
c01082b3    do_IRQ
c0105240    default_idle
c0105240    default_idle
c0105240    default_idle
c0105240
c0105263    default_idle
c01052d2    cpu_idle
c0105000    rest_init
c0105027    rest_init
------------< snip <------< snip <------< snip <------------

It crashes when it hits BUG(); in slab.c:

------------< snip <------< snip <------< snip <------------
#if DEBUG
    if (cachep->flags & SLAB_POISON)
        if (kmem_check_poison_obj(cachep, objp))
            BUG();
------------< snip <------< snip <------< snip <------------

--=20

Regards
 Abraham

Nothing is so often irretrievably missed as a daily opportunity.
		-- Ebner-Eschenbach

___________________________________________________
 Abraham vd Merwe - Frogfoot Networks CC
 9 Kinnaird Court, 33 Main Street, Newlands, 7700
 Phone: +27 21 686 1674 Cell: +27 82 565 4451
 Http: http://www.frogfoot.net/ Email: abz@frogfoot.net


--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+blLG0jJV70h31dERAiQ7AJ0b2vqj6ouXT7nlHnSGB2Y8JfLqawCfeKW7
8CmtViJv+1OGwWaCRYR/M+k=
=l040
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
