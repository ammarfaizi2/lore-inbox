Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265850AbTL3QuL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 11:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265851AbTL3QuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 11:50:11 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.135.30]:33031 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S265850AbTL3QuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 11:50:06 -0500
Date: Wed, 31 Dec 2003 01:50:13 +0900 (JST)
Message-Id: <20031231.015013.00858070.yoshfuji@linux-ipv6.org>
To: mingo@elte.hu
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       yoshfuji@linux-ipv6.org
Subject: Re: [patch] clean up tcp_sk(), 2.6.0
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20031230163230.GA12553@elte.hu>
References: <20031230163230.GA12553@elte.hu>
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

In article <20031230163230.GA12553@elte.hu> (at Tue, 30 Dec 2003 17:32:30 +0100), Ingo Molnar <mingo@elte.hu> says:

> incorrect, compiles just fine on 2.6.0. The patch below is equivalent to
> the define but is also type-safe. Compiles cleanly & boots fine on
> 2.6.0.
:

> -#define tcp_sk(__sk) (&((struct tcp_sock *)__sk)->tcp)
> +static inline struct tcp_opt * tcp_sk(const struct sock *__sk)
> +{
> +	return &((struct tcp_sock *)__sk)->tcp;
> +}
>  

You probably want to convert other similar things such as 
inet_sk(), inet6_sk() etc. :-)

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
