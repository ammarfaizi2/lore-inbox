Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143442AbRELAxo>; Fri, 11 May 2001 20:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143441AbRELAxf>; Fri, 11 May 2001 20:53:35 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:10139 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S143439AbRELAx0>;
	Fri, 11 May 2001 20:53:26 -0400
Message-ID: <3AFC8983.3FDB9513@mandrakesoft.com>
Date: Fri, 11 May 2001 20:53:23 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk,
        " Mads Martin =?iso-8859-1?Q?J=F8rgensen?=" <mmj@suse.com>
Subject: Re: 2.4.4-ac8 doesn't work with Lite-On 82c168 PNIC rev 32
In-Reply-To: <20010511165749.B12289@lucon.org> <3AFC8896.47AA1481@mandrakesoft.com>
Content-Type: multipart/mixed;
 boundary="------------8844F6E659122723830D6881"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8844F6E659122723830D6881
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Here's another patch to try, for PNIC.  Feedback welcome.
-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
--------------8844F6E659122723830D6881
Content-Type: text/plain; charset=us-ascii;
 name="patch-pnic"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-pnic"

diff -ur 2.4/drivers/net/tulip/media.c build-2.4/drivers/net/tulip/media.c
--- 2.4/drivers/net/tulip/media.c	Fri May 11 22:12:51 2001
+++ build-2.4/drivers/net/tulip/media.c	Fri May 11 22:10:03 2001
@@ -409,8 +409,6 @@
 	struct tulip_private *tp = dev->priv;
 	unsigned int bmsr, lpa, negotiated, new_csr6;
 
-	if (tp->full_duplex_lock)
-		return 0;
 	bmsr = tulip_mdio_read(dev, tp->phys[0], MII_BMSR);
 	lpa = tulip_mdio_read(dev, tp->phys[0], MII_LPA);
 	if (tulip_debug > 1)
@@ -428,7 +426,7 @@
 		}
 	}
 	negotiated = lpa & tp->advertising[0];
-	tp->full_duplex = (mii_nway_result(negotiated) & LPA_DUPLEX) ? 1 : 0;
+	tp->full_duplex = tp->full_duplex_lock | (mii_nway_result(negotiated) & LPA_DUPLEX) ? 1 : 0;
 
 	new_csr6 = tp->csr6;
 

--------------8844F6E659122723830D6881--

