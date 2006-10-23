Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751609AbWJWGlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbWJWGlW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 02:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbWJWGlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 02:41:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:63706 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751609AbWJWGlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 02:41:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=kKuD5wcnOK4IbpKCVVApMlv3JKhoiTSiHNlY/Q0NEKBPxBXvybs+NHZ2WnMqUK8PuDx6VeqfmZbhpmNdlzTy/7+lNJtmVergj6xhp9ICiZG/rglyxuxk/UxuPFFHswKVZx5+hGANjiaV2YrbbmRyjNGjXi/CIiOFH3IaKm2YIK8=
Message-ID: <84144f020610222341m2e4ad35fid82016ed431664b@mail.gmail.com>
Date: Mon, 23 Oct 2006 09:41:20 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Amit Choudhary" <amit2030@gmail.com>
Subject: Re: [PATCH 2.6.19-rc2] net/ipv4/multipath_wrandom.c: check kmalloc() return value.
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <20061022232052.16b1bcf3.amit2030@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061022232052.16b1bcf3.amit2030@gmail.com>
X-Google-Sender-Auth: e91e7b9ff2753712
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/06, Amit Choudhary <amit2030@gmail.com> wrote:
> diff --git a/net/ipv4/multipath_wrandom.c b/net/ipv4/multipath_wrandom.c
> index 92b0482..45bfd20 100644
> --- a/net/ipv4/multipath_wrandom.c
> +++ b/net/ipv4/multipath_wrandom.c
> @@ -242,6 +242,11 @@ static void wrandom_set_nhinfo(__be32 ne
>                 target_route = (struct multipath_route *)
>                         kmalloc(size_rt, GFP_ATOMIC);
>
> +               if (!target_route) {
> +                       spin_unlock_bh(&state[state_idx].lock);
> +                       return;
> +               }
> +
>                 target_route->gw = nh->nh_gw;
>                 target_route->oif = nh->nh_oif;
>                 memset(&target_route->rcu, 0, sizeof(struct rcu_head));
> @@ -263,6 +268,11 @@ static void wrandom_set_nhinfo(__be32 ne
>                 target_dest = (struct multipath_dest*)
>                         kmalloc(size_dst, GFP_ATOMIC);
>
> +               if (!target_dest) {
> +                       spin_unlock_bh(&state[state_idx].lock);
> +                       return;
> +               }
> +

You probably want to use goto here so you don't need to duplicate
spin_unlock_bh(). Otherwise looks good. Send this to akpm and cc
netdev@vger.kernel.org.
