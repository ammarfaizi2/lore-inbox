Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268521AbTGISRv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 14:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268533AbTGISRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 14:17:51 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:11027 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S268521AbTGISQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 14:16:03 -0400
Date: Thu, 10 Jul 2003 03:31:17 +0900 (JST)
Message-Id: <20030710.033117.93244305.yoshfuji@linux-ipv6.org>
To: Jean-Luc.Richier@imag.fr
Cc: pekkas@netcore.fi, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       yoshfuji@linux-ipv6.org
Subject: Re: Bug in Linux 2.5.74 IPv6 routing
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030709195237.A8550@horus.imag.fr>
References: <20030709195237.A8550@horus.imag.fr>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CC: netdev

In article <20030709195237.A8550@horus.imag.fr> (at Wed, 9 Jul 2003 19:52:37 +0200), Jean-Luc Richier <Jean-Luc.Richier@imag.fr> says:

> There is a bug in IPv6 route calculation since kernel 2.5.71. It affects
> all routes with prefix length != 0 (mod 8)
> The bug is as follows:
> do:	ip -6 route add 2000::/3 via 2001:688:121:10::1
> 	ip -6 route
> It shows a route for ::/3, not for 2000::/3

good catch.

> PATCH 2: avoid overwriting the set value
> --- linux-2.5.74/include/net/ipv6.h.DIST	2003-07-02 22:53:44.000000000 +0200
> +++ linux-2.5.74/include/net/ipv6.h	2003-07-09 18:51:25.000000000 +0200
> @@ -276,8 +276,10 @@
>  	    b = plen & 0x7;
>  
>  	memcpy(pfx->s6_addr, addr, o);
> -	if (b != 0)
> +	if (b != 0) {
>  		pfx->s6_addr[o] = addr->s6_addr[o] & (0xff00 >> b);
> +		o++;
> +	}
>  	if (o < 16)
>  		memset(pfx->s6_addr + o, 0, 16 - o);
>  }
> 

Ok, let's use this one.

--yoshfuji
