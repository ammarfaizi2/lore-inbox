Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWEHQHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWEHQHy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 12:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWEHQHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 12:07:54 -0400
Received: from www.levante.de ([212.101.151.130]:58016 "EHLO www.levante.de")
	by vger.kernel.org with ESMTP id S1750939AbWEHQHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 12:07:53 -0400
Date: Mon, 8 May 2006 18:05:32 +0200
From: Uwe Zeisberger <Uwe_Zeisberger@digi.com>
To: linux-kernel@vger.kernel.org
Cc: Andy Fleming <afleming@freescale.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Victor <andrew@sanpeople.com>
Subject: LXT971 driver in the phy lib
Message-ID: <20060508160531.GA2131@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
X-FS-MailScanner: Found to be clean
X-MailScanner-From: uzeisberger@fsforth.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I try to get an network interface running that has an LXT971A[1].

If I apply the following patch, the target can detect the phy.

diff --git a/drivers/net/phy/lxt.c b/drivers/net/phy/lxt.c
index bef79e4..4c66fac 100644
--- a/drivers/net/phy/lxt.c
+++ b/drivers/net/phy/lxt.c
@@ -137,9 +137,9 @@ static struct phy_driver lxt970_driver =
 };
 
 static struct phy_driver lxt971_driver = {
-	.phy_id		= 0x0001378e,
+	.phy_id		= 0x001378e0,
 	.name		= "LXT971",
-	.phy_id_mask	= 0x0fffffff,
+	.phy_id_mask	= 0xfffffff0,
 	.features	= PHY_BASIC_FEATURES,
 	.flags		= PHY_HAS_INTERRUPT,
 	.config_aneg	= genphy_config_aneg,

According to

	http://www.intel.com/design/network/products/LAN/datashts/24941402.pdf

page 90f the id registers yield 0x001378eX (with X being current
revision ID)

	uzeisberger@io:~/gsrc/linux-2.6$ git grep -i 1378e drivers/net/
	drivers/net/arm/at91_ether.h:#define MII_LXT971A_ID     0x001378E0
	drivers/net/e1000/e1000_hw.h:#define L1LXT971A_PHY_ID   0x001378E0
	drivers/net/fec.c:      .id = 0x0001378e, 
	drivers/net/fec_8xx/fec_mii.c:   .id = 0x0001378e,
	drivers/net/phy/lxt.c:  .phy_id         = 0x0001378e,

So both variants occur more than once.  (I only took a quick glance at
the usage of these ids, but I think they all use it in the same way.
That is, ID1 << 16 | ID2.)

"My" phy reports 0x001378e2 and now I wonder if there are different
chips out there with the same name.

Can anybody explain this mismatch to me?  (Or point me to the right
query for google.)

Best regards
Uwe

[1] Actually it's an LXT972A, but that only means my phy lacks four
address pins.  Nothing software has to handle.

-- 
Uwe Zeisberger
FS Forth-Systeme GmbH, A Digi International Company
Kueferstrasse 8, D-79206 Breisach, Germany
Phone: +49 (7667) 908 0 Fax: +49 (7667) 908 200
Web: www.fsforth.de, www.digi.com
