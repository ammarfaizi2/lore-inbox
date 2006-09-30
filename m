Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWI3O4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWI3O4R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 10:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWI3O4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 10:56:17 -0400
Received: from pool-72-66-199-147.ronkva.east.verizon.net ([72.66.199.147]:4038
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751046AbWI3O4Q (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 10:56:16 -0400
Message-Id: <200609301455.k8UEtIaX016722@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: ak@suse.de, jdmason@kudzu.us, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [PATCH 4 of 4] x86-64: Calgary IOMMU: Fix off by one when calculating register space
In-Reply-To: Your message of "Sat, 30 Sep 2006 11:43:32 +0300."
             <1e2a3d57541a0d31894c.1159605812@rhun.haifa.ibm.com>
From: Valdis.Kletnieks@vt.edu
References: <1e2a3d57541a0d31894c.1159605812@rhun.haifa.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159628118_8054P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 30 Sep 2006 10:55:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159628118_8054P
Content-Type: text/plain; charset=us-ascii

On Sat, 30 Sep 2006 11:43:32 +0300, Muli Ben-Yehuda said:

> +	 * Each Calgary has four busses. The first four busses (first Calgary)
> +	 * have RIO node ID 2, then the next four (second Calgary) have RIO
> +	 * node ID 3, the next four (third Calgary) have node ID 2 again, etc.
> +	 * We use a gross hack - relying on the dev->bus->number ordering,
> +	 * modulo 14 - to decide which Calgary a given bus is on. Busses 0, 1,
> +	 * 2 and 4 are on the first Calgary (id 2), 6, 8, a and c are on the
> +	 * second (id 3), and then it repeats modulo 14.
> + 	 */
> +	rionodeid = (dev->bus->number % 14 > 4) ? 3 : 2;

A quick perusal of the pci-calgary.c in 2.6.18-mm2 doesn't find a single
comment explaining where "6, 8, a, c" comes from, which makes that 14 seem
"magical" - are the 3rd Calgary's busses e,f, 10, and 12? It makes me wonder
why they didn't just blow 2 "reserved" numbers to make it mod 16 and an easier
decode. ;)

--==_Exmh_1159628118_8054P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFHoVWcC3lWbTT17ARAgdCAJ9zOJe6bwig0jVzh0uglYmtIBFprgCg7M5Q
YNBhDu4u+besQI1sgDztx6c=
=AvRV
-----END PGP SIGNATURE-----

--==_Exmh_1159628118_8054P--
