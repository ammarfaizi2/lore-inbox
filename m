Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266649AbTAKAMH>; Fri, 10 Jan 2003 19:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266688AbTAKAMG>; Fri, 10 Jan 2003 19:12:06 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:31362 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S266649AbTAKAMF>; Fri, 10 Jan 2003 19:12:05 -0500
Message-Id: <200301110020.h0B0KdLK016200@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [patch][2.5] setup default dma_mask for cardbus devices 
In-Reply-To: Your message of "Fri, 10 Jan 2003 18:48:24 EST."
             <Pine.LNX.4.50.0301101841210.9169-100000@montezuma.mastecende.com> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.50.0301101841210.9169-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1316245180P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Jan 2003 19:20:39 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1316245180P
Content-Type: text/plain; charset=us-ascii

On Fri, 10 Jan 2003 18:48:24 EST, Zwane Mwaikambo said:
> Devices hanging off a cardbus bridge don't get a default dma mask which
> causes problems later when doing pci_alloc_consistent. Patch has been
> tested with tulip based ethernet.

> diff -u -r1.1.1.1 cardbus.c
> --- linux-2.5.56/drivers/pcmcia/cardbus.c	10 Jan 2003 21:22:48 -0000
	1.1.1.1
> +++ linux-2.5.56/drivers/pcmcia/cardbus.c	10 Jan 2003 23:38:24 -0000
> @@ -281,6 +281,8 @@
>  		dev->vendor = vend;
>  		pci_readw(dev, PCI_DEVICE_ID, &dev->device);
>  		dev->hdr_type = hdr & 0x7f;
> +		dev->dma_mask = 0xffffffff;
> +		dev->dev.dma_mask = &dev->dma_mask;
> 
>  		pci_setup_device(dev);
>  		if (pci_enable_device(dev))

And yet, this looks *different* than the bug I've been chasing with the Xircom
card, not 10 lines away from your patch.  However, it's odd that
pdev_enable_device() was responsible for both disabling the card ROM *and*
disabling DMA....

Things that make you go "Hmmm...."

-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-1316245180P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+H2NXcC3lWbTT17ARAqWLAJwJJgaxU9dUFs9tg7JuDNyZ7XxQewCfas1y
Rxhz/u2IpvqLUFhIlfT4QA8=
=+2P+
-----END PGP SIGNATURE-----

--==_Exmh_-1316245180P--
