Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbVLSV0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbVLSV0R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 16:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbVLSV0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 16:26:17 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:51465 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964978AbVLSV0R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 16:26:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hq9rzMfvI6Qbhg8NgRGvXjBQ2n0M9EyGa0EnWsYm4sqnGCek5A3EOZMB/dIQMA0AKqOY/+DKahbSDdS9jiRmFxC7cvWLo16XPrXNcPg2yjA20nRhoXMUXESaL9xoOoe2Il0u++aJ5+rN3OOV0iwK+4HNGqega3+jFLgBBIFmBLM=
Message-ID: <9929d2390512191326v5a924e4dv41bc33d181f3d539@mail.gmail.com>
Date: Mon, 19 Dec 2005 13:26:12 -0800
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [BUG][PATCH] e1000: Fix invalid memory reference
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <439EA1F4.3000204@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <439EA1F4.3000204@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/05, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> wrote:
> Hi,
>
> I encountered a kernel panic which was caused by the invalid memory
> access by e1000 driver. The following patch fixes this issue.
>
> Thanks,
> Kenji Kaneshige
>
>
> This patch fixes invalid memory reference in the e1000 driver which
> would cause kernel panic.
>
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
>
>  drivers/net/e1000/e1000_param.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
>
> Index: linux-2.6.15-rc5/drivers/net/e1000/e1000_param.c
> ===================================================================
> --- linux-2.6.15-rc5.orig/drivers/net/e1000/e1000_param.c
> +++ linux-2.6.15-rc5/drivers/net/e1000/e1000_param.c
> @@ -545,7 +545,7 @@ e1000_check_fiber_options(struct e1000_a
>  static void __devinit
>  e1000_check_copper_options(struct e1000_adapter *adapter)
>  {
> -       int speed, dplx;
> +       int speed, dplx, an;
>         int bd = adapter->bd_number;
>
>         { /* Speed */
> @@ -641,8 +641,12 @@ e1000_check_copper_options(struct e1000_
>                                          .p = an_list }}
>                 };
>
> -               int an = AutoNeg[bd];
> -               e1000_validate_option(&an, &opt, adapter);
> +               if (num_AutoNeg > bd) {
> +                       an = AutoNeg[bd];
> +                       e1000_validate_option(&an, &opt, adapter);
> +               } else {
> +                       an = opt.def;
> +               }
>                 adapter->hw.autoneg_advertised = an;
>         }
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Sorry, you are right.  Looks fine.

ACK.

--
Cheers,
Jeff
