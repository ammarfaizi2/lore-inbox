Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWIOVnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWIOVnz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 17:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWIOVnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 17:43:55 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:33171 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S932297AbWIOVny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 17:43:54 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=ZDzvLKu3xecygnutYNAqJPkXOwMGpQVhXAY8s94pZG/hWLeAJPpawIG/FyKJ7toBsvswcZTt7R66B//C2/eNdMzhG/L3WK2yfSjVmeQHC4Wm6VysIiX62r5ndQzesVQB;
X-IronPort-AV: i="4.09,172,1157346000"; 
   d="scan'208"; a="81180341:sNHT19639071"
Date: Fri, 15 Sep 2006 16:43:54 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Greg KH <gregkh@suse.de>, akpm@osdl.org
Cc: Pierre Peiffer <pierre.peiffer@bull.net>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [Bug ??] 2.6.18-rc6-mm2 - PCI ethernet board does not seem to work
Message-ID: <20060915214354.GB24399@lists.us.dell.com>
References: <450A7EC5.2090909@bull.net> <20060915102954.GA7014@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20060915102954.GA7014@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2006 at 03:29:54AM -0700, Greg KH wrote:
> That being said, I think we need to reverse the order of this patch,
> keeping the current scheme as default, and allowing it to be overridden
> on the command line for those few machines where it matters to be
> compatible with the old, 2.4 ordering scheme.
>=20
> Matt, care to rework the patch in this manner?

Greg, Andrew,

I'd really like to rework this patch in a different direction.  As
such, please drop the patch:

gregkh-pci-pci-sort-device-lists-breadth-first.patch

=66rom your trees, and I'll provide a new one next week.

Breadth-first vs depth-first is really only part of the problem.  More
fundamental is the expectation that embedded devices get discovered
before add-in devices in physical slots.  From there, breadth-first vs
depth-first is interesting again.  I'd like to sort the list to put
the embedded devices first, subsort those breadth-first, then list the
add-in devices in ascending slot number order, subsort breadth-first.
I'll default this sorting routine off, enabled/disabled via a command
line option, and enabled by default for some systems based on DMI
strings.

arch/i386/pci/irq.c already has the PCI IRQ Routing Table available,
=66rom which we can get embedded vs slotN information.  It's not
currently being used in this manner, so I'm massaging that.

How does this sound?

Thanks,
Matt

--=20
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFFCx6aIavu95Lw/AkRAj55AJ9wvqhRGSNK2Ct/NE+LK/S5kbm8TwCfX5OP
bbkKKoCPWFHa8v/L/qN1ATs=
=6W3C
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
