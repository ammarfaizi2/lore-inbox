Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbVKAV1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbVKAV1a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 16:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVKAV1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 16:27:30 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:37008 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751253AbVKAV1a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 16:27:30 -0500
In-Reply-To: <436586F0.9080101@21cn.com>
To: Yan Zheng <yanzheng@21cn.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       netdev-owner@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [PATCH][MCAST]IPv6: small fix for ip6_mc_msfilter(...)
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF395F8772.5B834BF9-ON882570AC.0075ACD7-882570AC.0075DC3C@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Tue, 1 Nov 2005 13:27:36 -0800
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.53HF654 | July 22, 2005) at
 11/01/2005 14:27:37,
	Serialize complete at 11/01/2005 14:27:37
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yan,
        Please also make this equivalent change in IPv4 with
ip_mc_msfilter() and ip_mc_add_src().

                                                +-DLS

Acked-by: David L Stevens <dlstevens@us.ibm.com> 
> 
> Signed-off-by: Yan Zheng <yanzheng@21cn.com> 
> 
> Index: net/ipv6/mcast.c
> 
================================================================================
> --- linux-2.6.14/net/ipv6/mcast.c   2005-10-30 23:09:33.000000000 +0800
> +++ linux/net/ipv6/mcast.c   2005-10-31 10:37:36.000000000 +0800
> @@ -545,8 +545,10 @@ int ip6_mc_msfilter(struct sock *sk, str
>           sock_kfree_s(sk, newpsl, IP6_SFLSIZE(newpsl->sl_max));
>           goto done;
>        }
> -   } else
> +   } else {
>        newpsl = NULL;
> +      ip6_mc_add_src(idev, group, gsf->gf_fmode, 0, NULL, 0);
> +   }
>     psl = pmc->sflist;
>     if (psl) {
>        (void) ip6_mc_del_src(idev, group, pmc->sfmode,
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

