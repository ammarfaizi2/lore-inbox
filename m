Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbVHIKL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbVHIKL3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 06:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbVHIKL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 06:11:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44241 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932501AbVHIKL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 06:11:29 -0400
Date: Tue, 9 Aug 2005 11:11:10 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Dave Jones <davej@redhat.com>, linux-parport@lists.infradead.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-parport] Incorrect permissions on parport sysctls.
Message-ID: <20050809101110.GN7718@redhat.com>
References: <20050809044440.GA7725@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H83aLI5Lttn3Hg7B"
Content-Disposition: inline
In-Reply-To: <20050809044440.GA7725@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H83aLI5Lttn3Hg7B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 09, 2005 at 12:44:41AM -0400, Dave Jones wrote:

> We have a bunch of 'probe' sysctl's in parport, which are
> readable. (world readable even). Make them write-only.
> Without this, sysctl -a will try to read these files.

??

This change is wrong.  The probing happens at module load time, and
the IEEE 1284 device IDs are stored for later retrieval to user space
via these sysctls.

They are backed by read-only variables.  Reading does not trigger any
device interaction.

Make them 0400 if you think it's a security issue: but then,
/proc/ide/hda/model etc should also get the same treatment.

Tim.
*/

--H83aLI5Lttn3Hg7B
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFC+IE+HU/d4jnpWe0RAlHZAKCiaaz2hFM9PbAOT1eWNf2uNspbEgCgpIp9
HdYGOwQfDMHoQWnhgvPhF9c=
=oIlT
-----END PGP SIGNATURE-----

--H83aLI5Lttn3Hg7B--
