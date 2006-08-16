Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWHPIuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWHPIuE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 04:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWHPIuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 04:50:04 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:11792 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1751020AbWHPIuC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 04:50:02 -0400
Date: Wed, 16 Aug 2006 17:51:44 +0900 (JST)
Message-Id: <20060816.175144.75075807.yoshfuji@linux-ipv6.org>
To: gerrit@erg.abdn.ac.uk
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH 2.6.17] net/ipv6/udp.c: remove duplicate udp_get_port
 code
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200608160846.48174@strip-the-willow>
References: <200608160846.48174@strip-the-willow>
Organization: USAGI/WIDE Project
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

In article <200608160846.48174@strip-the-willow> (at Wed, 16 Aug 2006 08:46:48 +0100), gerrit@erg.abdn.ac.uk says:

> UDPv4 and UDPv6 use an almost identical version of the get_port function,
> which is unnecessary since the (long) code differs in only one if-statement.
:

:
> +#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +				else if(sk->sk_family == PF_INET6     &&
> +					ipv6_rcv_saddr_equal(sk, sk2)     )
> +					goto fail;
> +			}
> +#endif

This is not good because you cannot link ipv6_rcv_saddr_equal()
if you are compiling IPv6 as module.

How about retaining udp_v{4,6}_get_port() and call
common udp_get_port() from both functions?

--yoshfuji
