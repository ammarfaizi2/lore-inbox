Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbUBEHB4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 02:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264361AbUBEHB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 02:01:56 -0500
Received: from dsl081-085-091.lax1.dsl.speakeasy.net ([64.81.85.91]:26764 "EHLO
	mrhankey.megahappy.net") by vger.kernel.org with ESMTP
	id S263787AbUBEHBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 02:01:51 -0500
Message-ID: <4021E8D1.80006@jpl.nasa.gov>
Date: Wed, 04 Feb 2004 22:55:13 -0800
From: Bryan Whitehead <driver@jpl.nasa.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bryan Whitehead <driver@megahappy.net>
Cc: ctindel@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.2] drivers/net/bonding/bond_alb.c
References: <20040205065051.0EF40FA5F1@mrhankey.megahappy.net>
In-Reply-To: <20040205065051.0EF40FA5F1@mrhankey.megahappy.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oops, sorry for duplicate email, thought I didn't send in the patch 
already...

Bryan Whitehead wrote:
> __constant_htons is used on a variable that is only a byte. This results
> in an if statement always returning true in function bond_alb_xmit.
> 
> This is the compiler warning on gcc 3.3.2 a gentoo linux system:
>   CC [M]  drivers/net/bonding/bond_alb.o
> drivers/net/bonding/bond_alb.c: In function `bond_alb_xmit':
> drivers/net/bonding/bond_alb.c:1340: warning: comparison is always true due to limited range of data type
> 
> Here is the patch:
> --- linux-2.6.2/drivers/net/bonding/bond_alb.c.orig     2004-02-04 15:08:04.228336168 -0800
> +++ linux-2.6.2/drivers/net/bonding/bond_alb.c  2004-02-04 15:26:03.769221008 -0800
> @@ -1336,8 +1336,7 @@ bond_alb_xmit(struct sk_buff *skb, struc
>                         break;
>                 }
>   
> -               if (ipx_hdr(skb)->ipx_type !=
> -                   __constant_htons(IPX_TYPE_NCP)) {
> +               if (ipx_hdr(skb)->ipx_type != IPX_TYPE_NCP) {
>                         /* The only protocol worth balancing in
>                          * this family since it has an "ARP" like
>                          * mechanism
> 
> 
> --
> Bryan Whitehead
> driver@megahappy.net
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Bryan Whitehead
Email:driver@megahappy.net
WorkE:driver@jpl.nasa.gov
