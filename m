Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbTLKHb3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 02:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbTLKHb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 02:31:29 -0500
Received: from coruscant.franken.de ([193.174.159.226]:12221 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S264396AbTLKHbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 02:31:19 -0500
Date: Thu, 11 Dec 2003 08:26:08 +0100
From: Harald Welte <laforge@netfilter.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Stephen Lee <mukansai@emailplus.org>, scott.feldman@intel.com,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: Extremely slow network with e1000 & ip_conntrack
Message-ID: <20031211072608.GF22826@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	"David S. Miller" <davem@redhat.com>,
	Stephen Lee <mukansai@emailplus.org>, scott.feldman@intel.com,
	netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDD1F@orsmsx402.jf.intel.com> <20031204213030.2B75.MUKANSAI@emailplus.org> <20031205122819.25ac14ab.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qp4W5+cUSnZs0RIF"
Content-Disposition: inline
In-Reply-To: <20031205122819.25ac14ab.davem@redhat.com>
X-Operating-system: Linux sunbeam 2.6.0-test5-nftest
X-Date: Today is Setting Orange, the 53rd day of The Aftermath in the YOLD 3169
User-Agent: Mutt/1.5.4i
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qp4W5+cUSnZs0RIF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 05, 2003 at 12:28:19PM -0800, David S. Miller wrote:

> The culprit is net/ipv4/netfilter/ip_conntrack_standalone.c,
> in ip_refrag(), it does this:
>=20

Sorry for getting back to you so late, but as indicated before, I was
offline while travelling during the last week.

Thanks for spotting and fixing the bug.

> Some auditing is definitely necessary wrt. TSO and netfilter.  In particu=
lar
> I am incredibly confident that we have issues in cases like when the FTP
> netfilter modules mangle the data.  Another area for inspection are the
> cases where TCP header bits are changed and thus the checksum needs to
> be adjusted.

yes, this is certainly a problem - but not with conntrack, only with
nat.  So maybe we should add a safeguard, preventing
iptables_nat/ipchains/ipfwadm from being loaded when TSO on any
interface is enabled?  Or at least print a warining in syslog?

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--qp4W5+cUSnZs0RIF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/2BwQXaXGVTD0i/8RAhTnAJ9qseTfbSGiGhmZG8xTAFImx9fBGQCgjq8V
OB8LsLrfb4l0RUqNrNAiAfM=
=2TJW
-----END PGP SIGNATURE-----

--qp4W5+cUSnZs0RIF--
