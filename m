Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWJPPXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWJPPXn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWJPPXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:23:43 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:28091 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932147AbWJPPXm (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:23:42 -0400
Message-Id: <200610161517.k9GFHZrA006494@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Subject: Re: [PATCH] libata-sff: Allow for wacky systems
In-Reply-To: Your message of "Mon, 16 Oct 2006 16:24:50 BST."
             <1161012290.24237.68.camel@localhost.localdomain>
From: Valdis.Kletnieks@vt.edu
References: <1161012290.24237.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1161011855_3520P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 11:17:35 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1161011855_3520P
Content-Type: text/plain; charset=us-ascii

On Mon, 16 Oct 2006 16:24:50 BST, Alan Cox said:
> There are some Linux supported platforms that simply cannot hit the low
> I/O addresses used by ATA legacy mode PCI mappings. These platforms have
> a window for PCI space that is fixed by the board logic and doesn't
> include the neccessary locations.
> 
> Provide a config option so that such platforms faced with a controller
> that they cannot support simply error it and punt
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-
2.6.19-rc1-mm1/drivers/ata/libata-sff.c linux-2.6.19-rc1-mm1/drivers/ata/libata
-sff.c
> --- linux.vanilla-2.6.19-rc1-mm1/drivers/ata/libata-sff.c	2006-10-13 15:0
9:23.000000000 +0100
> +++ linux-2.6.19-rc1-mm1/drivers/ata/libata-sff.c	2006-10-13 17:15:57.000
000000 +0100
> @@ -981,6 +981,15 @@
>  		mask = (1 << 2) | (1 << 0);
>  		if ((tmp8 & mask) != mask)
>  			legacy_mode = (1 << 3);
> +#if defined(CONFIG_NO_ATA_LEGACY)
> +		/* Some platforms with PCI limits cannot address compat
> +		   port space. In that case we punt if their firmware has
> +		   left a device in compatibility mode */
> +		if (legacy_mode) {
> +			printk(KERN_ERR "ata: Compatibility mode ATA is not supported on this platform, skipping.\n");

Would it make sense for the printk to include a hint as to which controller
is on crack, so on boxes with PCI_MULTITHREAD_PROBE it's easier to tell?

--==_Exmh_1161011855_3520P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFM6KPcC3lWbTT17ARAlZkAKC6MT1nZpDmF6xFDjwOeewvsQ7CaQCgqkNH
ZSeV4KrNKF/iS5FN2t07GTo=
=q3ih
-----END PGP SIGNATURE-----

--==_Exmh_1161011855_3520P--
