Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129453AbQLNAMp>; Wed, 13 Dec 2000 19:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbQLNAMe>; Wed, 13 Dec 2000 19:12:34 -0500
Received: from h201.s254.netsol.com ([216.168.254.201]:57230 "EHLO
	tesla.admin.cto.netsol.com") by vger.kernel.org with ESMTP
	id <S129453AbQLNAM3>; Wed, 13 Dec 2000 19:12:29 -0500
Date: Wed, 13 Dec 2000 18:41:58 -0500
From: Pete Toscano <pete@research.netsol.com>
To: linux-kernel@vger.kernel.org
Subject: Re: linux ipv6 questions.  bugs?
Message-ID: <20001213184158.P1139@tesla.admin.cto.netsol.com>
Mail-Followup-To: linux-kernel@vger.redhat.com
In-Reply-To: <20001213144558.L1139@tesla.admin.cto.netsol.com> <200012132027.XAA15957@ms2.inr.ac.ru> <20001213162512.N1139@tesla.admin.cto.netsol.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="xjamM5M9kpPM/bcu"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001213162512.N1139@tesla.admin.cto.netsol.com>; from pete@research.netsol.com on Wed, Dec 13, 2000 at 04:25:12PM -0500
X-Uptime: 4:56pm  up 1 day,  5:38,  7 users,  load average: 0.27, 0.12, 0.09
X-Married: 395 days, 21 hours, 11 minutes, and 16 seconds
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xjamM5M9kpPM/bcu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ugh, bad form, i know, but i forgot this little dollop of information:

it looks like the incorrectly mac addressed n.s. packets are being fed
right back into the linux box's ip stack (as it sees an ethernet packet
with the destination set to its own mac address):=20

[root@nsv6 /root]# ping6 X:Y::1
PING X:Y::1(X:Y::1) from X:Y::4 : 56 data bytes
=46rom ::1: Destination unreachable: Address unreachable
=46rom ::1: Destination unreachable: Address unreachable
    .
    .
    .
=46rom ::1: Destination unreachable: Address unreachable
64 bytes from X:Y::1: icmp_seq=3D16 hops=3D64 time=3D433 usec
64 bytes from X:Y::1: icmp_seq=3D15 hops=3D64 time=3D1.000 sec

the pings start working when i put the X:Y::1 box's ethernet card
into promsc mode and it sees an ipv6 packet destined for one of its
multicast addresses.  (i guess promsc mode tells the eth to just ignore
all link-level addressing info.)

pete

On Wed, 13 Dec 2000, Pete Toscano wrote:

>=20
> On Wed, 13 Dec 2000, kuznet@ms2.inr.ac.ru wrote:
>=20
> > Hello!
> >=20
> > > 0.  whenever i ping6 the loopback interface (::1/128), all echo reque=
sts
> > > seem to be dropped and i get no echo replies.  is this correct?
> =20
> > Your guess? 8) Of course, it is incorrect. I even have no idea
> > how it is possible to put system into such sad state.
>=20
> well, just power it on, it seems.  but then again, this is just a guess.
> =3D;]
>=20
> > Though... probably, you forgot to up loopback.
>=20
> doesn't look it:
>=20
> [root@nsv6 /root]# ifconfig lo
> lo        Link encap:Local Loopback =20
>           inet addr:127.0.0.1  Mask:255.0.0.0
>           inet6 addr: ::1/128 Scope:Host
>           UP LOOPBACK RUNNING  MTU:7952  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0=20
> [root@nsv6 /root]# ping6 ::1
> PING ::1(::1) from ::1 : 56 data bytes
>=20
> --- ::1 ping statistics ---
> 156 packets transmitted, 0 packets received, 100% packet loss
>=20
> ...and this is right after boot.
>=20
> > > the destination mac address is set to the linux box's mac address and
> > > the source mac address is set to 0:0:0:0:0:0.
> >=20
> > I think it is consequence of above. When loopback interface is missing,
> > networking does not work.
> >=20
> >=20
> > > other way around?  this would explain why the openbsd box doesn't
> > > respond to the linux box's n.s. until it starts looking at all the
> > > packets in promisc mode, right?
> >=20
> > Rather it means that openbsd is buggy, its stack accepts packets
> > not destined to it. It cannot react to those strange packets, which
> > you have just described.
>=20
> that may very well be, but shouldn't the neighbor solisitation packets
> from the linux box have the source mac address set to its mac address
> and the destination mac address set to 0:0:0:0:0:0 and not the other way
> around?
>=20
> thanks,
> pete

--=20
Pete Toscano    p:sigsegv@psinet.com     w:pete@research.netsol.com
GPG fingerprint: D8F5 A087 9A4C 56BB 8F78  B29C 1FF0 1BA7 9008 2736

--xjamM5M9kpPM/bcu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6OAlGH/Abp5AIJzYRAsq+AKCDK+1yz6B3wpNHUG/0YK3kG/q9kwCfSmrf
rrvjWUC2UQzbA4H5rPvs2hA=
=gjVV
-----END PGP SIGNATURE-----

--xjamM5M9kpPM/bcu--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
