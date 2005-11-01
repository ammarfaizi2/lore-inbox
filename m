Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbVKAXy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbVKAXy4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 18:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbVKAXy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 18:54:56 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:1713 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751450AbVKAXyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 18:54:55 -0500
In-Reply-To: <4367FF22.3030601@21cn.com>
To: Yan Zheng <yanzheng@21cn.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [PATCH][MCAST]IPv6: small fix for ip6_mc_msfilter(...)
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF19AE07D9.BF2B28D4-ON882570AC.0083498D-882570AC.00835D3A@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Tue, 1 Nov 2005 15:55:05 -0800
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.53HF654 | July 22, 2005) at
 11/01/2005 16:55:07,
	Serialize complete at 11/01/2005 16:55:07
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good. Thanks, Yan.

                        +-DLS

Acked-by: David L Stevens <dlstevens@us.ibm.com>

> 
> Signed-off-by: Yan Zheng <yanzheng@21cn.com>
> 
> Patch for IPv4
> Index:net/ipv4/igmp.c
> ============================================================
> --- linux-2.6.14/net/ipv4/igmp.c   2005-10-28 08:02:08.000000000 +0800
> +++ linux/net/ipv4/igmp.c   2005-11-02 07:31:01.000000000 +0800
> @@ -1908,8 +1908,11 @@ int ip_mc_msfilter(struct sock *sk, stru
>          sock_kfree_s(sk, newpsl, IP_SFLSIZE(newpsl->sl_max));
>          goto done;
>       }
> -   } else
> +   } else {
>       newpsl = NULL;
> +      (void) ip_mc_add_src(in_dev, &msf->imsf_multiaddr,
> +         msf->imsf_fmode, 0, NULL, 0)
> +   }
>    psl = pmc->sflist;
>    if (psl) {
>       (void) ip_mc_del_src(in_dev, &msf->imsf_multiaddr, pmc->sfmode,
> 
> 
> 
> 
> Patch for IPv6
> Index:net/ipv6/mcast.c
> ============================================================
> --- linux-2.6.14/net/ipv6/mcast.c   2005-10-30 23:09:33.000000000 +0800
> +++ linux/net/ipv6/mcast.c   2005-11-02 07:19:12.000000000 +0800
> @@ -545,8 +545,10 @@ int ip6_mc_msfilter(struct sock *sk, str
>          sock_kfree_s(sk, newpsl, IP6_SFLSIZE(newpsl->sl_max));
>          goto done;
>       }
> -   } else
> +   } else {
>       newpsl = NULL;
> +      (void) ip6_mc_add_src(idev, group, gsf->gf_fmode, 0, NULL, 0);
> +   }
>    psl = pmc->sflist;
>    if (psl) {
>       (void) ip6_mc_del_src(idev, group, pmc->sfmode,
> 
> 

