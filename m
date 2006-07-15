Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946038AbWGONeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946038AbWGONeS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 09:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946039AbWGONeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 09:34:18 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:8708 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1946038AbWGONeR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 09:34:17 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: gerrit@erg.abdn.ac.uk (Gerrit Renker)
Subject: Re: [PATCHv2  2.6.18-rc1-mm2   1/3]  net:  UDP-Lite generic support
Cc: akpm@osdl.org, davem@davemloft.net, yoshfuji@linux-ipv6.org,
       kuznet@ms2.inr.ac.ru, jmorris@namei.org, kaber@coreworks.de,
       pekkas@netcore.fi, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <200607141719.02766@strip-the-willow>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1G1kGi-000549-00@gondolin.me.apana.org.au>
Date: Sat, 15 Jul 2006 23:33:16 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerrit Renker <gerrit@erg.abdn.ac.uk> wrote:
>
> diff -Nurp  a/net/core/sock.c b/net/core/sock.c
> --- a/net/core/sock.c   2006-07-06 09:08:24.000000000 +0100
> +++ b/net/core/sock.c   2006-07-14 10:17:50.000000000 +0100
> @@ -479,7 +479,12 @@ set_rcvbuf:
>                        break;
> 
>                case SO_NO_CHECK:
> -                       sk->sk_no_check = valbool;
> +                       /* UDP-Lite (RFC 3828) mandates checksumming,
> +                        * hence user must not enable this option.   */
> +                       if (sk->sk_protocol == IPPROTO_UDPLITE)
> +                               ret = -EOPNOTSUPP;
> +                       else
> +                           sk->sk_no_check = valbool;

Please don't add protocol-specific stuff to generic functions.  In this
case why don't you just ignore sk_no_check for UDPLITE as we do for TCP?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
