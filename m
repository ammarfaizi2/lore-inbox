Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289239AbSCLXgv>; Tue, 12 Mar 2002 18:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289272AbSCLXgc>; Tue, 12 Mar 2002 18:36:32 -0500
Received: from [217.79.102.244] ([217.79.102.244]:14333 "EHLO
	monkey.beezly.org.uk") by vger.kernel.org with ESMTP
	id <S289239AbSCLXgZ>; Tue, 12 Mar 2002 18:36:25 -0500
Subject: Re: Dropped packets on SUN GEM
From: Beezly <beezly@beezly.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020312.151443.03370128.davem@redhat.com>
In-Reply-To: <1015974664.2652.10.camel@monkey> 
	<20020312.151443.03370128.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-I8iSL7lMhzQeh1pdBays"
X-Mailer: Evolution/1.0.2 
Date: 12 Mar 2002 23:36:21 +0000
Message-Id: <1015976181.2652.30.camel@monkey>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-I8iSL7lMhzQeh1pdBays
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, 2002-03-12 at 23:14, David S. Miller wrote:
> What I believe happens is that when the RX overflow condition occurs,
> there will be some packets that will be corrupted as a result.

Yep, I expected that, but wouldn't this only be packets which had
*already* entered the RX buffer? These packets are being transmitted at
a rate of one every .1/.2 seconds, so I guess it's unlikely that all
these packets have entered the RX buffer and been zapped. OTOH - I'm
just stabbing away wildly in the dark so I most likely wrong ;)

> I find it really odd that you can reproduce this condition so readily.
> Does it happen under normal usage or do you have to issue a ping flood
> or some other packet intensive job to trigger the problem?  Also, are
> you getting Pause enabled on the link consistently?

I'm not getting the Pause enabled message *at all*. The other host is
100Mbit (I've not got another gigabit host to test against yet).

If I stop doing the ping I notice that I loose TCP/IP connectivity for a
while, but it usually comes back after a period of time (sorry to be so
vague, but I haven't been able to tell how long it takes to come back
exactly).

Interestingly, whilst writing this e-mail, I've been running a ping with
a 1 second interval and no options (so we end up with 84 bytes in the
packet). It did the same thing, but took a lot longer than 14 packets to
recover... (FYI: 195.195.14.1 is across an ADSL link from me -
explaining the high rtt :) )

64 bytes from 195.195.14.1: icmp_seq=3D258 ttl=3D239 time=3D33.0 ms
64 bytes from 195.195.14.1: icmp_seq=3D259 ttl=3D239 time=3D32.4 ms
64 bytes from 195.195.14.1: icmp_seq=3D260 ttl=3D239 time=3D63.1 ms
64 bytes from 195.195.14.1: icmp_seq=3D261 ttl=3D239 time=3D32.3 ms
64 bytes from 195.195.14.1: icmp_seq=3D262 ttl=3D239 time=3D33.2 ms
64 bytes from 195.195.14.1: icmp_seq=3D263 ttl=3D239 time=3D33.8 ms
64 bytes from 195.195.14.1: icmp_seq=3D264 ttl=3D239 time=3D33.4 ms
>From 10.0.0.12 icmp_seq=3D309 Destination Host Unreachable
>From 10.0.0.12 icmp_seq=3D310 Destination Host Unreachable
>From 10.0.0.12 icmp_seq=3D311 Destination Host Unreachable
>From 10.0.0.12 icmp_seq=3D313 Destination Host Unreachable
>From 10.0.0.12 icmp_seq=3D314 Destination Host Unreachable
<snip>
>From 10.0.0.12 icmp_seq=3D370 Destination Host Unreachable
>From 10.0.0.12 icmp_seq=3D371 Destination Host Unreachable
>From 10.0.0.12 icmp_seq=3D373 Destination Host Unreachable
>From 10.0.0.12 icmp_seq=3D374 Destination Host Unreachable
64 bytes from 195.195.14.1: icmp_seq=3D375 ttl=3D239 time=3D1036 ms
64 bytes from 195.195.14.1: icmp_seq=3D376 ttl=3D239 time=3D38.2 ms
64 bytes from 195.195.14.1: icmp_seq=3D377 ttl=3D239 time=3D29.4 ms
64 bytes from 195.195.14.1: icmp_seq=3D378 ttl=3D239 time=3D32.1 ms

So I had another brainstorm, perhaps this is related to the amount of
data transfer /rather/ than packets.

If I do ping -i .1 10.0.0.15 (i.e. an 84 byte packet), I get the
following very interesting results.

64 bytes from 10.0.0.15: icmp_seq=3D298 ttl=3D255 time=3D0.223 ms
64 bytes from 10.0.0.15: icmp_seq=3D299 ttl=3D255 time=3D0.209 ms
64 bytes from 10.0.0.15: icmp_seq=3D300 ttl=3D255 time=3D0.233 ms
64 bytes from 10.0.0.15: icmp_seq=3D301 ttl=3D255 time=3D0.210 ms
64 bytes from 10.0.0.15: icmp_seq=3D302 ttl=3D255 time=3D0.220 ms
64 bytes from 10.0.0.15: icmp_seq=3D303 ttl=3D255 time=3D0.208 ms
64 bytes from 10.0.0.15: icmp_seq=3D304 ttl=3D255 time=3D0.213 ms
64 bytes from 10.0.0.15: icmp_seq=3D630 ttl=3D255 time=3D0.214 ms
64 bytes from 10.0.0.15: icmp_seq=3D631 ttl=3D255 time=3D0.212 ms
64 bytes from 10.0.0.15: icmp_seq=3D632 ttl=3D255 time=3D0.202 ms
64 bytes from 10.0.0.15: icmp_seq=3D633 ttl=3D255 time=3D0.201 ms


i.e. it takes the card 325 packets to recover, yet with 1500 byte
packets... I get,=20

1480 bytes from 10.0.0.15: icmp_seq=3D499 ttl=3D255 time=3D0.558 ms
1480 bytes from 10.0.0.15: icmp_seq=3D500 ttl=3D255 time=3D0.561 ms
1480 bytes from 10.0.0.15: icmp_seq=3D501 ttl=3D255 time=3D0.550 ms
1480 bytes from 10.0.0.15: icmp_seq=3D502 ttl=3D255 time=3D0.557 ms
1480 bytes from 10.0.0.15: icmp_seq=3D503 ttl=3D255 time=3D0.547 ms
1480 bytes from 10.0.0.15: icmp_seq=3D518 ttl=3D255 time=3D0.566 ms
1480 bytes from 10.0.0.15: icmp_seq=3D519 ttl=3D255 time=3D0.551 ms
1480 bytes from 10.0.0.15: icmp_seq=3D520 ttl=3D255 time=3D0.552 ms
1480 bytes from 10.0.0.15: icmp_seq=3D521 ttl=3D255 time=3D0.552 ms
1480 bytes from 10.0.0.15: icmp_seq=3D522 ttl=3D255 time=3D0.548 ms

14 packets missing.

325*84  =3D 27300
14*1500 =3D 21000

Are these number relevant?

Beezly


--=-I8iSL7lMhzQeh1pdBays
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8jpD1Xu4ZFsMQjPgRAufrAKDLQosjBXsTkQKOwdGn+y+W6KXLyACgxXak
8gLaHu/4pwBNo4ifwwLhkco=
=AxD9
-----END PGP SIGNATURE-----

--=-I8iSL7lMhzQeh1pdBays--
