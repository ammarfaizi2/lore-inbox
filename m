Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264944AbUD2TxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264944AbUD2TxV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 15:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbUD2TxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 15:53:21 -0400
Received: from linux.us.dell.com ([143.166.224.162]:26495 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S264944AbUD2TxL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 15:53:11 -0400
Date: Thu, 29 Apr 2004 14:53:01 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: PCI devices with no PCI_CACHE_LINE_SIZE implemented
Message-ID: <20040429195301.GB15106@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greg,

Some PCI device functions, such as the EHCI portion of Intel ICH5 and
ICH6 chips, do not implement the PCI_CACHE_LINE_SIZE register (which
is legal to not implement per PCI spec as it is a busmaster that
cannot issue a MWI).  However, for each of these, the kernel tries to
set the value, fails, and prints a KERN_WARNING message about it.

a) need this be a warning, wouldn't KERN_DEBUG suffice, if a message
is needed at all?  This is printed in pci_generic_prep_mwi().

b) How might you prefer to handle such devices?

Per the PCI 2.3 spec, reading a value of 0 may mean several things:
1) setting the register at all isn't supported
   - this is what pci.c assumes now and returns -EINVAL.
2) setting the register to the value you tried isn't supported, but
   you can try again with another value until you find the right one.
   - but there are no hints as to what the right value for a device
     might be.

Personally, I'd be happy if the printk were gone completely, but
that's your call.  With the prints there, our support organization is
concerned it can cause tech support calls for (in this case) a non-issue.=
=20

Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAkV0dIavu95Lw/AkRAgIgAJ0ejl4LxaBxG4lqn9hAsnzEEuzmrQCgmQ4E
1ak7k+2E6ZbQ440gKd6PWNw=
=gD8s
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
