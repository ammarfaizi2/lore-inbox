Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266075AbUBKSoo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 13:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266083AbUBKSoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 13:44:44 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.135.30]:14608 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S266075AbUBKSok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 13:44:40 -0500
Date: Thu, 12 Feb 2004 03:45:37 +0900 (JST)
Message-Id: <20040212.034537.11291491.yoshfuji@linux-ipv6.org>
To: kas@informatics.muni.cz
Cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru,
       yoshfuji@linux-ipv6.org
Subject: Re: [Patch] Netlink BUG() on AMD64
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20040211181113.GA2849@fi.muni.cz>
References: <20040205183604.N26559@fi.muni.cz>
	<20040211181113.GA2849@fi.muni.cz>
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

In article <20040211181113.GA2849@fi.muni.cz> (at Wed, 11 Feb 2004 19:11:14 +0100), Jan Kasprzak <kas@informatics.muni.cz> says:

> 	I suggest the following patch, but all occurences of
> nlmsg_failure: and rtattr_failure: labels should be checked for a similar
> problem.
> 
> --- linux-2.6.2/net/ipv4/fib_rules.c.orig	2004-02-11 18:55:58.000000000 +0100
> +++ linux-2.6.2/net/ipv4/fib_rules.c	2004-02-11 19:03:08.319215408 +0100
> @@ -438,7 +438,7 @@
>  
>  nlmsg_failure:
>  rtattr_failure:
> -	skb_put(skb, b - skb->tail);
> +	skb_trim(skb, b - skb->data);
>  	return -1;
>  }
>  
> Please apply or let me know what the proper fix should be.

looks good to me.
Other places including net/ipv6/{addrconf.c,route.c} seems okay.

--yoshfuji
