Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWGHAIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWGHAIX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWGHAIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:08:21 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:7647 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932426AbWGHAIF (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:08:05 -0400
Message-Id: <200607080007.k6807p9q007430@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, gregkh <greg@kroah.com>,
       akpm <akpm@osdl.org>, davej@codemonkey.org.uk
Subject: Re: [PATCH] PCIE: create sysfs directory on first use
In-Reply-To: Your message of "Fri, 07 Jul 2006 16:52:38 PDT."
             <20060707165238.337c7a4a.rdunlap@xenotime.net>
From: Valdis.Kletnieks@vt.edu
References: <20060707165238.337c7a4a.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152317271_2990P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jul 2006 20:07:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152317271_2990P
Content-Type: text/plain; charset=us-ascii

On Fri, 07 Jul 2006 16:52:38 PDT, "Randy.Dunlap" said:

> @@ -405,11 +410,15 @@ void pcie_port_device_remove(struct pci_
>  void pcie_port_bus_register(void)
>  {
>  	bus_register(&pcie_port_bus_type);
> +	pcie_dev_registered = 1;

Shouldn't this be 'pcie_dev_registered++;'
>  }
>  
>  void pcie_port_bus_unregister(void)
>  {
> -	bus_unregister(&pcie_port_bus_type);
> +	if (pcie_dev_registered) {
> +		bus_unregister(&pcie_port_bus_type);
> +		pcie_dev_registered = 0;

and 'pciedev_registered--;'

> +	}
>  }

to keep it from blowing up if 2 bus get registered, then one de-registered,
and then re-registered again? I could see this happening in a hotplug design?

--==_Exmh_1152317271_2990P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFErvdXcC3lWbTT17ARAi9yAKDn7Zq4pKoRMJOb5OvRXLWtre+evQCfQl2q
jwVBSOAic4s9Gz17+vV9mSM=
=Fz44
-----END PGP SIGNATURE-----

--==_Exmh_1152317271_2990P--
