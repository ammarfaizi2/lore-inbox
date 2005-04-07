Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbVDGLUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbVDGLUB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 07:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbVDGLT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 07:19:26 -0400
Received: from dea.vocord.ru ([217.67.177.50]:43434 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262425AbVDGLSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 07:18:32 -0400
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Ian Campbell <ijc@hellion.org.uk>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>, greg@kroah.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1112870517.3279.42.camel@localhost.localdomain>
References: <1112859412.18360.31.camel@frecb000711.frec.bull.fr>
	 <1112860419.28858.76.camel@uganda>  <1112861638.28858.92.camel@uganda>
	 <1112865153.3086.134.camel@icampbell-debian>
	 <1112867556.28858.135.camel@uganda>
	 <1112870517.3279.42.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Ma0anTuWaT9T7ZZBJn5w"
Organization: MIPT
Date: Thu, 07 Apr 2005 15:24:34 +0400
Message-Id: <1112873074.28858.167.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Thu, 07 Apr 2005 15:17:43 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ma0anTuWaT9T7ZZBJn5w
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-04-07 at 12:41 +0200, Kay Sievers wrote:
> On Thu, 2005-04-07 at 13:52 +0400, Evgeniy Polyakov wrote:
> > On Thu, 2005-04-07 at 10:12 +0100, Ian Campbell wrote:
> > > On Thu, 2005-04-07 at 12:13 +0400, Evgeniy Polyakov wrote:
> > > > The main idea was to simplify userspace control and notification
> > > > system - so people did not waste it's time learning how skb's are
> > > > allocated
> > > > and processed, how socket layer is designed and what all those
> > > > netlink_* and NLMSG* mean if they do not need it.
> > >=20
> > > Isn't connector built on top of netlink? If so, is there any reason f=
or
> > > it to be a new subsystem rather than an extension the the netlink API=
?
> >=20
> > Connector is not netlink API extension in any way.
> > It uses netlink as transport layer, one can change
> > cn_netlink_send()/cn_input()=20
> > into something like bidirectional ioctl and use it.
> >=20
> > Only one cn_netlink_send() function can be "described" as API
> > extension,=20
> > although even it is not entirely true.
>=20
> I see much overlap here too. Wouldn't it be nice to see the transport
> part of the connector code to be implemented as a generic netlink
> multicast? We already have uni- and broadcast for netlink.

Netlink broadcast is multicast actually,
if listener exists, then message will be sent to him,=20
if no - skb will be just freed.

> Isn't the whole purpose of the connector to hook in notifications that
> act only if someone is listening? That is a perfect multicast case. :)

Connector can be used to send data from userspace to kernelspace,
so it allows sending controlling messages without ioctl() compatibility=20
mess and so on.

One may use cn_netlink_send() to send notification without being
registered=20
in connector, if it's second parameter is 0, then appropriate=20
connector listener will be searched for.

It is different from netlink messages,=20
netlink is a transport layer for connector.

> At the time we added kobject_uevent I was missing something like this.
> The broadcast groups did not really fit, and we decided not to use them,
> and unicast wasn't a option here.

There is a check for listener in netlink_broadcast() - sk_for_each_bound
().

> Thanks,
> Kay
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-Ma0anTuWaT9T7ZZBJn5w
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCVRhyIKTPhE+8wY0RAr9DAJ0X4XH2jwvT1k1XOSwVin7cqkYnjgCeMSAU
Ce7IiA2JuOygxEurO2fehxI=
=RTnH
-----END PGP SIGNATURE-----

--=-Ma0anTuWaT9T7ZZBJn5w--

