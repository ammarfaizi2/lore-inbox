Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423251AbWANBRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423251AbWANBRk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 20:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423245AbWANBRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 20:17:39 -0500
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86]:36481 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP id S1422883AbWANBRj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 20:17:39 -0500
Date: Fri, 13 Jan 2006 20:17:26 -0500
From: Stuffed Crust <pizza@shaftnet.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (configuration)
Message-ID: <20060114011726.GA19950@shaftnet.org>
Mail-Followup-To: Johannes Berg <johannes@sipsolutions.net>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060113195723.GB16166@tuxdriver.com> <20060113212605.GD16166@tuxdriver.com> <20060113213011.GE16166@tuxdriver.com> <20060113221935.GJ16166@tuxdriver.com> <1137191522.2520.63.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <1137191522.2520.63.camel@localhost>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.0.2 (shaft.shaftnet.org [127.0.0.1]); Fri, 13 Jan 2006 20:17:27 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2006 at 11:32:02PM +0100, Johannes Berg wrote:
> I'm not sure this is worth it. While putting this into the WiPHY device
> creates more logic there, putting knowledge like 'how many different
> channels can this WiPHY device support' etc. into some representation
> that can be used by the stack to decide is much more trouble than it is
> worth.

Do you mean 'simultaneous' channel operation, or something more mundane=20
like simply 'what frequencies can I run on'?

If you're talking about the former.. things get quite complicated, but=20
that could be handled by having two WiPHY devices registered.

As for the latter, when you factor in the needs of 802.11d and its
dependents (802.11j, 802.11k, and others) the stack is going to need to
be aware of the available channel sets; both in the sense of hardware
support and also the various regulatory requirements.=20

The hardware knows what frequencies it supports.  Unfortunately this has=20
to be a somewhat dynamic thing, as this is often not queryable until the=20
device firmware is up and running. =20

This can be accomplished by passing a static table to the=20
register_wiphy_device() call (or perhaps via a struct wiphy_dev=20
parameter) or through a more explicit, dynamic interface like:

  wiphy_register_supported_frequency(hw, 2412).=20

 - Solomon
--=20
Solomon Peachy        				 ICQ: 1318344
Melbourne, FL 					=20
Quidquid latine dictum sit, altum viditur.

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDyFEmPuLgii2759ARApk7AJ9vrsX3JKIgGn2/b6PhUQIkEF5jQACgzUaE
GZgZOrx7cdf72jqEHRGsRCk=
=QDWO
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
