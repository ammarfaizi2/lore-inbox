Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129076AbQKOXZC>; Wed, 15 Nov 2000 18:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129103AbQKOXYw>; Wed, 15 Nov 2000 18:24:52 -0500
Received: from warande3094.warande.uu.nl ([131.211.123.94]:24149 "EHLO
	xar.sliepen.oi") by vger.kernel.org with ESMTP id <S129076AbQKOXYj>;
	Wed, 15 Nov 2000 18:24:39 -0500
Date: Wed, 15 Nov 2000 23:54:34 +0100
From: Guus Sliepen <guus@warande3094.warande.uu.nl>
To: netfilter@us5.samba.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: (iptables) ip_conntrack bug?
Message-ID: <20001115235433.M13682@sliepen.warande.net>
Mail-Followup-To: Guus Sliepen <guus@sliepen.warande.net>,
	netfilter@lists.samba.org, linux-kernel@vger.kernel.org
In-Reply-To: <20001115154603.D4089@psuedomode> <20001115221922.L13682@sliepen.warande.net> <20001115163450.E4089@psuedomode>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k2+Bt23KD9VIuFWa"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001115163450.E4089@psuedomode>; from safemode@voicenet.com on Wed, Nov 15, 2000 at 04:34:50PM -0500
X-oi: oi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k2+Bt23KD9VIuFWa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2000 at 04:34:50PM -0500, safemode wrote:

> On Wed, 15 Nov 2000 16:19:23 Guus Sliepen wrote:
> > On Wed, Nov 15, 2000 at 03:46:03PM -0500, safemode wrote:
> >=20
> > > I was DDoS'd today while away and came home to find the firewall unab=
le
> > to
> > > do anything network related (although my connection to irc was still
> > > working oddly).  a quick dmesg showed the problem.
> > > ip_conntrack: maximum limit of 2048 entries exceeded
> > [...]
> >=20
> > I have also seen this happen on a box which ran test9. Apparently becau=
se
> > of
> > it's long uptime, because the logs should no signs of an attack.

safemode and I discussed this and we tried to find an answer in the kernel
source. However, the chain of called functions is too long to determine whe=
re
exactly the problem is. But most likely, because init_conntrack() can fail
(because it cannot free an entry, which is either because netfilter does not
dare to throw out entries with large timeouts (tcp connections have ridicul=
ous
long timeouts btw, almost 2.3 days?!) or because IPS_CONFIRMED is not set),=
 and
this failure is propagating back all the way to the tcp code, so that no new
sockets can be opened.

=46rom our point of view, the conntrack stuff should be totally transparent=
 to the
tcp/ip stack. Since this allows for a DoS attack, might be wise to fix this
before 2.4 comes out...

-------------------------------------------
Met vriendelijke groet / with kind regards,
  Guus Sliepen <guus@sliepen.warande.net>
-------------------------------------------
See also: http://tinc.nl.linux.org/
          http://www.kernelbench.org/
-------------------------------------------

--k2+Bt23KD9VIuFWa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6ExQpAxLow12M2nsRApB7AKCnhSkFPqYSgqfMgVSz7i50bdzdMACgiNEz
AXf2fDEkUKXi0V4HGFJVioQ=
=KCnX
-----END PGP SIGNATURE-----

--k2+Bt23KD9VIuFWa--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
