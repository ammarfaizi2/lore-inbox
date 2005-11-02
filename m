Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965278AbVKBVzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965278AbVKBVzw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965284AbVKBVzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:55:52 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:63838 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965278AbVKBVzv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:55:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B9+YQIPGy3e0iZEJqEvs9zNzrQBhd1oalo5cnaYhtiAaYsUjxj67G81d1hb0u4Vh8sOmlYKNyTEtocvYzmLdn2m60StgEe1lM1yv1IkRk6mc9C6ppyQfshoatuFZLh84/xPzaVCXuUq7xUCTVS973BPRB8CBeEfYw6dG6+EYuTI=
Message-ID: <39e6f6c70511021355i52aff7e4n19ca4c1e24b21bb7@mail.gmail.com>
Date: Wed, 2 Nov 2005 19:55:50 -0200
From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: Yan Zheng <yanzheng@21cn.com>
Subject: Re: [PATCH][MCAST]IPv6: small fix for ip6_mc_msfilter(...)
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       David Stevens <dlstevens@us.ibm.com>
In-Reply-To: <4367FF22.3030601@21cn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <OF395F8772.5B834BF9-ON882570AC.0075ACD7-882570AC.0075DC3C@us.ibm.com>
	 <4367FF22.3030601@21cn.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/05, Yan Zheng <yanzheng@21cn.com> wrote:
> David Stevens wrote:
> > Yan,
> >         Please also make this equivalent change in IPv4 with
> > ip_mc_msfilter() and ip_mc_add_src().
> >
> >                                                 +-DLS
> >
> > Acked-by: David L Stevens <dlstevens@us.ibm.com>
>
> To keep code style, I also create a new patch for IPv6. :-)
>
> Signed-off-by: Yan Zheng <yanzheng@21cn.com>
>
> Patch for IPv4
> Index:net/ipv4/igmp.c
> ============================================================
> --- linux-2.6.14/net/ipv4/igmp.c        2005-10-28 08:02:08.000000000 +0800
> +++ linux/net/ipv4/igmp.c       2005-11-02 07:31:01.000000000 +0800
> @@ -1908,8 +1908,11 @@ int ip_mc_msfilter(struct sock *sk, stru
>                         sock_kfree_s(sk, newpsl, IP_SFLSIZE(newpsl->sl_max));
>                         goto done;
>                 }
> -       } else
> +       } else {
>                 newpsl = NULL;
> +               (void) ip_mc_add_src(in_dev, &msf->imsf_multiaddr,
> +                       msf->imsf_fmode, 0, NULL, 0)

Could you please compile test it next time :-) hint, missing ';'.
Anyway, fixed up by hand.

- Arnaldo
