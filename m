Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265369AbSLPG3N>; Mon, 16 Dec 2002 01:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbSLPG3N>; Mon, 16 Dec 2002 01:29:13 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:24332 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S265369AbSLPG3N>; Mon, 16 Dec 2002 01:29:13 -0500
Date: Mon, 16 Dec 2002 15:35:32 +0900 (JST)
Message-Id: <20021216.153532.87456123.yoshfuji@wide.ad.jp>
To: linux-kernel@vger.kernel.org
CC: netdev@oss.sgi.com, davem@redhat.com, kuznet@ms2.inr.ac.ru,
       krkumar@us.ibm.com
Subject: Re: [PATCH RESEND] memory leak in ndisc_router_discovery
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200212121905.gBCJ5hn18058@eng2.beaverton.ibm.com>
References: <200212121905.gBCJ5hn18058@eng2.beaverton.ibm.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: Mew version 2.2 on XEmacs 21.4.6 (Common Lisp)
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200212121905.gBCJ5hn18058@eng2.beaverton.ibm.com> (at Thu, 12 Dec 2002 11:05:43 -0800 (PST)), Krishna Kumar <krkumar@us.ibm.com> says:

> I had sent this earlier, there is a bug in router advertisement handling code,
> where the reference (and memory) to an inet6_dev pointer can get leaked (this
> leak can happen atmost once for each interface on a system which receives
> invalid RA's). Below is the patch against 2.5.51 to fix it.

(It would be called "refcnt leakage," or some thing like that, but anyway)
This seems correct fix. please apply...

> -------------------------------------------------------------------------------
> diff -ruN linux.org/net/ipv6/ndisc.c linux/net/ipv6/ndisc.c
> --- linux.org/net/ipv6/ndisc.c	Fri Nov  7 10:02:11 2002
> +++ linux/net/ipv6/ndisc.c	Fri Nov  8 14:37:27 2002
> @@ -871,6 +871,7 @@
>  	}
>  
>  	if (!ndisc_parse_options(opt, optlen, &ndopts)) {
> +		in6_dev_put(in6_dev);
>  		if (net_ratelimit())
>  			ND_PRINTK2(KERN_WARNING
>  				   "ICMP6 RA: invalid ND option, ignored.\n");
> -------------------------------------------------------------------------------

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
