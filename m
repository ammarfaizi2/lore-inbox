Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbTFTNsp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 09:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbTFTNsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 09:48:45 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:23946 "EHLO phoebee")
	by vger.kernel.org with ESMTP id S262073AbTFTNsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 09:48:30 -0400
Date: Fri, 20 Jun 2003 16:02:28 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reimplement pci proc name
Message-Id: <20030620160228.654e181c.martin.zwickel@technotrend.de>
In-Reply-To: <20030620134811.GR24357@parcelfarce.linux.theplanet.co.uk>
References: <20030620134811.GR24357@parcelfarce.linux.theplanet.co.uk>
Organization: TechnoTrend AG
X-Mailer: Sylpheed version 0.9.0claws42 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.4.21-rc4 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.d?x8FTndnyxhxX"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.d?x8FTndnyxhxX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Matthew!

Just one question:
If pci_name_bus copies the bus' hex to name and always returns 0,
the "if (!pci_name_bus(name, bus)) return -EEXIST;" would always be true, right?

Or did I miss something?

Regards,
Martin

On Fri, 20 Jun 2003 14:48:11 +0100
Matthew Wilcox <willy@debian.org> bubbled:

> 
> Index: drivers/pci/proc.c
> ===================================================================
> RCS file: /var/cvs/linux-2.5/drivers/pci/proc.c,v
> retrieving revision 1.9
> diff -u -p -r1.9 proc.c
> --- drivers/pci/proc.c	14 Jun 2003 22:15:29 -0000	1.9
> +++ drivers/pci/proc.c	17 Jun 2003 19:36:50 -0000
> @@ -383,7 +383,8 @@ int pci_proc_attach_device(struct pci_de
>  		return -EACCES;
>  
>  	if (!(de = bus->procdir)) {
> -		sprintf(name, "%02x", bus->number);
> +		if (!pci_name_bus(name, bus))
> +			return -EEXIST;
>  		de = bus->procdir = proc_mkdir(name, proc_bus_pci_dir);
>  		if (!de)
>  			return -ENOMEM;

> Index: include/linux/pci.h
> ===================================================================
> RCS file: /var/cvs/linux-2.5/include/linux/pci.h,v
> retrieving revision 1.17
> diff -u -p -r1.17 pci.h
> --- include/linux/pci.h	14 Jun 2003 22:16:01 -0000	1.17
> +++ include/linux/pci.h	19 Jun 2003 00:55:35 -0000
> @@ -808,6 +815,11 @@ extern int pci_pci_problems;
>  
>  #ifndef CONFIG_PCI_DOMAINS
>  static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
> +static inline int pci_name_bus(char *name, struct pci_bus *bus)
> +{
> +	sprintf(name, "%02x", bus->number);
> +	return 0;
> +}
>  #endif
>  
>  #endif /* __KERNEL__ */
> 


-- 
MyExcuse:
Backbone adjustment

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--=.d?x8FTndnyxhxX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+8xP0mjLYGS7fcG0RAtrOAJ4kOijoMfXdRtRwszM67heUMWIemQCeJZPg
HeN+/biXkxwcFllf2N2FDAU=
=08qb
-----END PGP SIGNATURE-----

--=.d?x8FTndnyxhxX--
