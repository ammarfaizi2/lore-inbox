Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVAGDLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVAGDLr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 22:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVAGDLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 22:11:46 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:32011 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261278AbVAGDL0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 22:11:26 -0500
Date: Fri, 07 Jan 2005 12:11:49 +0900 (JST)
Message-Id: <20050107.121149.102802103.yoshfuji@linux-ipv6.org>
To: bunk@stusta.de
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [2.6 patch] net/ipv6/: misc cleanups
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20050107030017.GF14108@stusta.de>
References: <20041215005546.GA11972@stusta.de>
	<20041215.105900.27736391.yoshfuji@linux-ipv6.org>
	<20050107030017.GF14108@stusta.de>
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

In article <20050107030017.GF14108@stusta.de> (at Fri, 7 Jan 2005 04:00:17 +0100), Adrian Bunk <bunk@stusta.de> says:

> - #if 0 the following unused global variable:
>   - addrconf.c: in6addr_any
> - remove the following EXPORT_SYMBOL's:
>   - ipv6_syms.c: in6addr_any
>   - ipv6_syms.c: in6addr_loopback
:
> --- linux-2.6.10-mm2-full/include/linux/in6.h.old	2005-01-07 02:34:21.000000000 +0100
> +++ linux-2.6.10-mm2-full/include/linux/in6.h	2005-01-07 02:36:18.000000000 +0100
> @@ -44,10 +44,10 @@
>   * NOTE: Be aware the IN6ADDR_* constants and in6addr_* externals are defined
>   * in network byte order, not in host byte order as are the IPv4 equivalents
>   */
> +#if 0
>  extern const struct in6_addr in6addr_any;
>  #define IN6ADDR_ANY_INIT { { { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 } } }
> -extern const struct in6_addr in6addr_loopback;
> -#define IN6ADDR_LOOPBACK_INIT { { { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 } } }
> +#endif
>  

I meant:

#if 0
extern const struct in6_addr in6addr_any;
#define IN6ADDR_ANY_INIT { { { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 } } }
#endif
extern const struct in6_addr in6addr_loopback;
#define IN6ADDR_LOOPBACK_INIT { { { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 } } }

And,

> @@ -191,7 +188,11 @@
>  };
>  
>  /* IPv6 Wildcard Address and Loopback Address defined by RFC2553 */
> +#if 0
> +#define IN6ADDR_ANY_INIT { { { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 } } }
>  const struct in6_addr in6addr_any = IN6ADDR_ANY_INIT;
> +#endif
> +#define IN6ADDR_LOOPBACK_INIT { { { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 } } }
>  const struct in6_addr in6addr_loopback = IN6ADDR_LOOPBACK_INIT;
>  

#if 0
const struct in6_addr in6addr_any = IN6ADDR_ANY_INIT;
#endif
const struct in6_addr in6addr_loopback = IN6ADDR_LOOPBACK_INIT;

or something like this.

--yoshfuji


