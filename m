Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268330AbUHLCD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268330AbUHLCD5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 22:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268332AbUHLCD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 22:03:57 -0400
Received: from cantor.suse.de ([195.135.220.2]:26065 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268330AbUHLCDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 22:03:55 -0400
Date: Thu, 12 Aug 2004 04:03:52 +0200
From: Kurt Garloff <kurt@garloff.de>
To: James Morris <jmorris@redhat.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [LSM] Rework LSM hooks
Message-ID: <20040812020352.GI14744@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <kurt@garloff.de>,
	James Morris <jmorris@redhat.com>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20040811221903.GA14744@tpkurt.garloff.de> <Xine.LNX.4.44.0408112110030.15343-100000@dhcp83-76.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="16qp2B0xu0fRvRD7"
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0408112110030.15343-100000@dhcp83-76.boston.redhat.com>
X-Operating-System: Linux 2.6.7-0-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--16qp2B0xu0fRvRD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi James,

On Wed, Aug 11, 2004 at 09:20:22PM -0400, James Morris wrote:
> Also, we still have the option of making COND_SECURITY ia64-specific.

We could do that. The patch sets security_ops to
capabilities_security_ops if no LSM is loaded, so it would be OK to
call into it unconditionally on archs that have a higher penalty for
a branch than for an indirect call.

You could just redefine the macro, depending on the arch, indeed.

We could also drop the unlikely. For the hot paths, the branch
prediction of the CPU can do its job. So, I'm not religious about
it; in practice it should make little difference either way.=20

My patch was aiming for a zerocost possibility to turn CONFIG_SECURITY
on. With the unlikely(), I should have gotten as close as one ~1 or 2=20
CPU cycles (compare plus correctly predicted branch). That's why I
put the unlikely.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>             [Koeln, DE]
Physics:Plasma modeling <garloff@plasimo.phys.tue.nl> [TU Eindhoven, NL]
Linux: SUSE Labs (Head)        <garloff@suse.de>    [SUSE Nuernberg, DE]

--16qp2B0xu0fRvRD7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBGtAIxmLh6hyYd04RAmzQAJ9/EIeSO0xRxJv05Ue8xuCSiMIQwQCfSXyr
74pH3eoe2jYWVUHRLBtdCXQ=
=tpkx
-----END PGP SIGNATURE-----

--16qp2B0xu0fRvRD7--
