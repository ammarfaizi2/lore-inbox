Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751687AbVIZRKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbVIZRKu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 13:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbVIZRKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 13:10:50 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:60848 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751685AbVIZRKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 13:10:49 -0400
Message-Id: <200509261710.j8QHAkE7008871@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
Subject: Re: [PATCH 2.6.14-rc2] aoe [1/2]: explicitly set minimum packet length to ETH_ZLEN 
In-Reply-To: Your message of "Mon, 26 Sep 2005 12:50:28 EDT."
             <87hdc7ept7.fsf@coraid.com> 
From: Valdis.Kletnieks@vt.edu
References: <87oe6fhj8y.fsf@coraid.com>
            <87hdc7ept7.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127754646_3790P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Sep 2005 13:10:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127754646_3790P
Content-Type: text/plain; charset=us-ascii

On Mon, 26 Sep 2005 12:50:28 EDT, Ed L Cashin said:
> "Ed L. Cashin" <ecashin@coraid.com> writes:
> 
> ...
> > Explicitly set the minimum packet length to ETH_ZLEN.
> >
> > Index: 2.6.14-rc2-aoe/drivers/block/aoe/aoecmd.c
> > ===================================================================
> > --- 2.6.14-rc2-aoe.orig/drivers/block/aoe/aoecmd.c	2005-09-26 12:20:34.000000000 -0400
> > +++ 2.6.14-rc2-aoe/drivers/block/aoe/aoecmd.c	2005-09-26 12:27:49.000000000 -0400
> > @@ -20,6 +20,9 @@
> >  {
> >  	struct sk_buff *skb;
> >  
> > +	if (len < ETH_ZLEN)
> > +		len = ETH_ZLEN;
> > +
> >  	skb = alloc_skb(len, GFP_ATOMIC);
> 
> This change fixes some strange problems observed on a system that was
> using the e1000 network driver.  Is the network driver supposed to
> ensure that ethernet packets are up to spec, at least 60 bytes long?

I haven't chased through the code in detail - will this change ensure that
all ETH_ZLEN bytes are initialized?  We had a bunch of drivers a few years
ago that set the length to the legal min, but then only copied some smaller
number of bytes in, resulting in leakage of kernel memory contents....


--==_Exmh_1127754646_3790P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDOCuWcC3lWbTT17ARAmTkAJ9oJsXQBhFHw7BV92yJ/m1QBDZz1wCfcqlJ
FSluQ6/N7lTjsu+CKmsFpr8=
=t5LA
-----END PGP SIGNATURE-----

--==_Exmh_1127754646_3790P--
