Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264019AbTDJKAi (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 06:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264020AbTDJKAi (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 06:00:38 -0400
Received: from coruscant.franken.de ([193.174.159.226]:42901 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S264019AbTDJKAf (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 06:00:35 -0400
Date: Thu, 10 Apr 2003 11:22:16 +0200
From: Harald Welte <laforge@netfilter.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Netfilter Mailinglist <netfilter@lists.netfilter.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: 2.5.67 -- questions about netfilter config options
Message-ID: <20030410092216.GK21326@naboo>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Netfilter Mailinglist <netfilter@lists.netfilter.org>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HuXIgs6JvY9hJs5C"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304080702130.25860-100000@dell>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux naboo 2.4.20-nfpom1101
X-Date: Today is Setting Orange, the 27th day of Discord in the YOLD 3169
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HuXIgs6JvY9hJs5C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 08, 2003 at 07:15:45AM -0400, Robert P. J. Day wrote:
>=20
>   [while i'm discussing these things on the netfilter mailing
> list, i figure at least a few folks here might be helpful.]
>=20
>   i'm trying to clarify the purpose and interdependence of=20
> the NF config options, and perhaps document them more clearly
> in their associated help screens.  to that end, i'm confused
> by the way some options can be selected without other=20
> options that would seem to be obvious dependencies.
> to wit:

so why didn't you take this to the netfilter development mailinglist
first?  I don't think this is of general interest to linux-kernel, which
certainly has more than enough postings per day, and the subject is
clearly netfilter-only.

> 1) currently, it's possible to select the single option
>    "IP tables support" without any other options *anywhere*
>    in that menu.  what value does this have?

this means that you have the generic iptables core. this enables you for
example to use some out-of-kernel compiled iptables_foo module.=20

compare this with enabling scsi support, but not enabling a single scsi
host.

>    if you look down the submenu for that option, you see
>    "Packet filtering", which suggests you can ask for=20
>    "IP tables support" but still not have any ability to
>    set up any filtering rules. =20

yes, this makes sense.  packet filtering is the 'filter' table.  It is
perfectly legal to use NAT ('nat' table) or mangling ('mangle') without
enabling packet filtering.

> sort of strange.  it seems
>    odd that you can select to support limit matches,
>    TTL matches, etc., without actually having basic
>    "Packet filtering" support built in.  what does this
>    mean?

see above.

>    one possibility is that, according to the help info,
>    "IP tables support" is necesasry for masq/NAT.  if
>    this is true, it leads into my next question ...

it is true.

> 2) currently, it's possible to select "Connection tracking"
>    without "IP tables support", even though the latter is
>    listed as being essential for masq/NAT as well.
>=20
>    what is the value of selecting only "Conenction tracking"
>    in the entire NF config menu?  that is, what does it allow
>    you to do if not masq/NAT?

connection tracking provides a service to the kernel.  If you load it,
any code within the kernel can derive the connection tracking entry to
which a packet belongs.  Even though there is no current code in the
kernel (besides iptable_nat and ipt_state) that uses this information,
we should not decide on that. =20

A possible application would be something like a 'cfq' (derived from the
stochastic fairness queue).  This would eliminate the 'stochastic' part
which tries to determine which 'flow' (basically one direction of a
connection) a packet belongs to.

> i guess i'm trying to clarify whether there should be more
> dependencies in the underlying config structure, or it not,

no, at least not from the point of view of the netfilter coreteam.

> rday
>=20
> p.s.  is there a reason that almost all of the options
> are listed as "(NEW)" in the config menu?  they weren't
> even labelled that way in the 2.4.20 kernel.  how is it
> that they're suddenly "NEW" now?

Everything marked as 'NEW' means that your .config file did not contain
a setting (i.e. it was copied from a kernel that didn't have support for
those options).  This is also used for 'make oldconfig'.

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--HuXIgs6JvY9hJs5C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+lTfIXaXGVTD0i/8RAsl9AJ0XadSj16Fsz6h4JIbraj7XtJVuKwCePegU
XoNBKI2QAb1eDl0w0ciR1ho=
=+Ya+
-----END PGP SIGNATURE-----

--HuXIgs6JvY9hJs5C--
