Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266271AbUIWPQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUIWPQf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 11:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUIWPQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 11:16:25 -0400
Received: from [203.178.140.15] ([203.178.140.15]:24075 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S266271AbUIWPQR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 11:16:17 -0400
Date: Fri, 24 Sep 2004 00:16:27 +0900 (JST)
Message-Id: <20040924.001627.113803491.yoshfuji@linux-ipv6.org>
To: davem@davemloft.net, simlo@phys.au.dk
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ArcNet and 2.6.8.1
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.OSF.4.05.10409231534150.5114-100000@da410.ifa.au.dk>
References: <Pine.OSF.4.05.10409231534150.5114-100000@da410.ifa.au.dk>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

In article <Pine.OSF.4.05.10409231534150.5114-100000@da410.ifa.au.dk> (at Thu, 23 Sep 2004 17:08:47 +0200 (METDST)), Esben Nielsen <simlo@phys.au.dk> says:

>  I am trying to upgrade my labtop to 2.6.8.1. I have ArcNet COM20020
> PCMCIA card. After editing /etc/pcmcia/config to make it know about the
> module, it finds the com20020 with no problems but as soon as I try to
> start the network device the ifconfig process crashes.
:
> I fixed it by changing
> 	lp->hw.open(dev);
> to
> 	if(lp->hw.open) {
> 		lp->hw.open(dev);
> 	}

Thanks.

Signed-off-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>

===== drivers/net/arcnet/arcnet.c 1.18 vs edited =====
--- 1.18/drivers/net/arcnet/arcnet.c	2004-07-01 13:18:14 +09:00
+++ edited/drivers/net/arcnet/arcnet.c	2004-09-24 00:11:35 +09:00
@@ -401,7 +401,8 @@
 	lp->rfc1201.sequence = 1;
 
 	/* bring up the hardware driver */
-	lp->hw.open(dev);
+	if (lp->hw.open)
+		lp->hw.open(dev);
 
 	if (dev->dev_addr[0] == 0)
 		BUGMSG(D_NORMAL, "WARNING!  Station address 00 is reserved "

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
