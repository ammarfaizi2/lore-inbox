Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265245AbUGTD62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbUGTD62 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 23:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbUGTD62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 23:58:28 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:49827 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S265245AbUGTD6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 23:58:25 -0400
Date: Mon, 19 Jul 2004 22:47:41 -0400
From: Harald Welte <laforge@netfilter.org>
To: Sebastien ESTIENNE <sebest@ovibes.net>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       netdev@oss.sgi.com
Subject: Re: kernel 2.6.7 -> page allocation failure. order:1, mode:0x20 (netfilter?)
Message-ID: <20040720024741.GF27487@obroa-skai.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Sebastien ESTIENNE <sebest@ovibes.net>,
	linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
	netdev@oss.sgi.com
References: <40FB93FE.90308@ovibes.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="phCU5ROyZO6kBE05"
Content-Disposition: inline
In-Reply-To: <40FB93FE.90308@ovibes.net>
X-Operating-System: Linux obroa-skai.de.gnumonks.org 2.6.8-rc1-qs
X-Date: Today is Setting Orange, the 54th day of Confusion in the YOLD 3170
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 19, 2004 at 11:27:26AM +0200, Sebastien ESTIENNE wrote:
> Hello,
> i have some "swapper: page allocation failure. order:1, mode:0x20"
> followed by kernel message,
>=20
> the hardware is a dell poweredge 1750
> the kernel is a 2.6.7 vanilla
>=20
> here for a dmesg
> http://213.41.75.25/kernel/dmesg.txt
the chunk below seems like a standard code path for a locally-generated
outgoing packet:

> [<c028ac94>] skb_checksum_help+0x52/0x136
> [<e094fb79>] ip_nat_fn+0x269/0x27a [iptable_nat]
> [<e094fcb3>] ip_nat_local_fn+0x7b/0xaa [iptable_nat]
> [<c028708e>] tcp_sendmsg+0x509/0x10f7
> [<c0121872>] tasklet_action+0x65/0xae
> [<c01065da>] apic_timer_interrupt+0x1a/0x20
> [<c02ad977>] dst_output+0x0/0x29
> [<c028708e>] inet_sendmsg+0x4d/0x59
> [<c026498f>] dst_output+0x0/0x29
> [<c0276a40>] sock_aio_write+0xbd/0xdd
> [<c015902c>] do_sync_write+0x8b/0xb7
> [<c01da1ac>] nf_iterate+0x71/0xa2
> [<c028708e>] copy_from_user+0x42/0x6e
> [<c0159140>] vfs_write+0xe8/0x119
> [<c0159216>] sys_write+0x42/0x63
> [<c0105beb>] syscall_call+0x7/0xb

=20
what's worrying me is the part above... how would skb_checksum_help
directly end up in copy_from_user()?

> swapper: page allocation failure. order:1, mode:0x20
> [<c013d770>] __alloc_pages+0x2da/0x34a
> [<c013d805>] __get_free_pages+0x25/0x3f
> [<c0140e28>] kmem_getpages+0x2b/0xdc
> [<c0141bfc>] kfree_skbmem+0x24/0x2c
> [<c0141c5d>] cache_grow+0xe5/0x2a4
> [<c0141f8a>] cache_grow+0x146/0x2a4
> [<c0295917>] cache_alloc_refill+0x1cf/0x29f
> [<c014262a>] __kmalloc+0x85/0x8c
> [<c02681f1>] tcp_transmit_skb+0x411/0x68a
> [<c0296621>] alloc_skb+0x47/0xe0
> [<c026875e>] tcp_write_xmit+0x16d/0x2d6
> [<c01da1ac>] skb_copy+0x33/0xde
> [<c026ca5b>] copy_from_user+0x42/0x6e

Does anybody have a clue what's going on?

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--phCU5ROyZO6kBE05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA/IfNXaXGVTD0i/8RAiv4AJ0d3Gv+nUtbZvnlod7DNVqSXgAZVQCfYEo0
IReZ37a9XbULaBQQb0L4+m4=
=qpTK
-----END PGP SIGNATURE-----

--phCU5ROyZO6kBE05--
