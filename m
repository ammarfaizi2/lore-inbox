Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265346AbSJXIMR>; Thu, 24 Oct 2002 04:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265348AbSJXIMR>; Thu, 24 Oct 2002 04:12:17 -0400
Received: from coruscant.franken.de ([193.174.159.226]:4572 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S265346AbSJXIMO>; Thu, 24 Oct 2002 04:12:14 -0400
Date: Thu, 24 Oct 2002 10:16:56 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Bart De Schuymer <bart.de.schuymer@pandora.be>
Cc: coreteam@netfilter.org, linux-kernel@vger.kernel.org,
       Lennert Buytenhek <buytenh@gnu.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [netfilter-core] [RFC] place to put bridge-netfilter specific data in the skbuff
Message-ID: <20021024101656.T2450@sunbeam.de.gnumonks.org>
References: <20020911223252.GA12517@erik.ca> <200209120836.52062.bart.de.schuymer@pandora.be> <200210141953.38933.bart.de.schuymer@pandora.be> <200210142159.49290.bart.de.schuymer@pandora.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/JIF1IJL1ITjxcV4"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <200210142159.49290.bart.de.schuymer@pandora.be>; from bart.de.schuymer@pandora.be on Mon, Oct 14, 2002 at 09:59:49PM +0200
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.19-pre10-newnat-pptp
X-Date: Today is Setting Orange, the 3rd day of The Aftermath in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/JIF1IJL1ITjxcV4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2002 at 09:59:49PM +0200, Bart De Schuymer wrote:
> Hello netfilter team and others,

Hi Bart.

> DaveM suggested I talk to you (netfilter team) about this.

Thanks, unfortunately there was this huge delay before your email was answe=
red. Sorry for this inconvenience.

> What's bridge-netfilter: the mapping of the IPv4 onto the bridge hooks, t=
o=20
> make a powerful bridging firewall.

Yes, I am aware of this project.  In fact, Lennert did a presentation about=
=20
this on the netfilter developer workshop in Nov 2001

> The solution I like best (and David seems to not mind) is adding one poin=
ter=20
> to a struct nf_bridge_info in the skbuff. So, adding one new member.

That would be acceptable.

> Another suggestion by David is this:
>=20
> struct nf_ct_info {
> 	union {
> 		struct nf_conntrack *master;
> 		struct nf_bridge_info *brinfo;
> 	} u;
> };
>=20
> But I don't think this will not work because master will be in use while =
we=20
> need brinfo.

no, it will not work.  It clashes as soon as you want to use connection
tracking on a bridging firewall.

> So another solution could be this:
>=20
> struct nf_ct_info {
> 		struct nf_conntrack *master;
> 		struct nf_bridge_info *brinfo;
> };

This is, of course, possible.

> But I don't know anything about the intricacies of adding this.

I don't see any big problems.  If master stays the first member in struct
nf_ct_info, it should even work if there is a mis-use somewhere in the code,
referencing directly to nf_ct_info instead of nf_ct_info->master.

> Do you have any other suggestions? Comments? Help?

It's great seeing that the bridging stuff finally gets included.

> Also, could you have a look at the current patch, to spot any other=20
> obstacles/things you don't like?
> The patch is available at:
> http://users.pandora.be/bart.de.schuymer/ebtables/br-nf/bridge-nf-0.0.10-=
dev-pre1-against-2.5.42.diff

I have read the new (2.5.44) patch.

The only issue that comes to my mind is:

ip_packet_match is getting a way too long argument list.  Can't you write t=
he
matching against physical in/out devices as iptables match extension? (like
ipt_physdev.c?)

> Another question:
> I've been told it is the general concensus that this bridge firewall shou=
ld
> be compiled in the kernel if CONFIG_NETFILTER=3Dy. Or should it be a user
> option?=20
> It is predicted that using a user option will give alot of questions abou=
t=20
> the bridge firewall not working.
> Do you have any strong opinion about this?

Mh. Since bridging firewall is cool, but not something everybody will
use by default [and it adds code as well as enlarges the skb], I think it=
=20
should be a compiletime kernel config option.

> cheers,
> Bart
--=20
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"If this were a dictatorship, it'd be a heck of a lot easier, just so long
 as I'm the dictator."  --  George W. Bush Dec 18, 2000

--/JIF1IJL1ITjxcV4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9t6x3XaXGVTD0i/8RAq0iAJ0f+YiBHWZ9tHiuGuBEPTz/iE3sCACgjEU9
J1/QS+35aGLm3rZJDRRFfjE=
=hg0e
-----END PGP SIGNATURE-----

--/JIF1IJL1ITjxcV4--
