Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbUD1Ulk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUD1Ulk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbUD1UDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:03:25 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:19183 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S261258AbUD1TTE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 15:19:04 -0400
Date: Wed, 28 Apr 2004 21:19:08 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Ken Ashcraft <ken@coverity.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] Implementation inconsistencies involving writes
Message-ID: <20040428191908.GB4819@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	Ken Ashcraft <ken@coverity.com>, linux-kernel@vger.kernel.org
References: <3197.171.64.70.113.1083124455.spork@webmail.coverity.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
In-Reply-To: <3197.171.64.70.113.1083124455.spork@webmail.coverity.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 27, 2004 at 08:54:15PM -0700, Ken Ashcraft wrote:
> I'm trying to cross check implementations of the same interface for
> errors.  I assume that if functions are assigned to the same function
> pointer, they are implementations of a common interface and should be
> consistent with each other.

> [BUG] <linux@brodo.de> not writing policy->governor. looks like it is
> necessary to write a default value there.

It surely _looks like_ it's a bug, but it isn't. cpufreq drivers can either
have a "->target" or a "->setpolicy" function defined in the cpufreq_driver
struct. If it's ->target, ->governor needs to be set, if it's ->setpolicy,
->governor may not be set, or at least should not be set. As there's only=
=20
one ->setpolicy cpufreq driver (longrun), it's not as clear as it should be.

The difference between target and setpolicy cpufreq drivers is the
following: on the first type, the CPU can be set to run at a specific
frequency. setpolicy drivers can set the CPU to a frequency range; the CPU
itself at which frequency to run within this range -- an interesting featur=
e=20
of Transmeta CPUs, which made this distinction necessary.

	Dominik

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAkAOsZ8MDCHJbN8YRAm6JAJ9WeLq3OTX8fo/ayn5YPwAG4ZPUPgCgi2Vd
2OWjEEZbl6VlBeOCFN7FpLc=
=2R+9
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
