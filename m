Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273741AbRI0Tga>; Thu, 27 Sep 2001 15:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273747AbRI0TgV>; Thu, 27 Sep 2001 15:36:21 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:13561 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273741AbRI0TgK>;
	Thu, 27 Sep 2001 15:36:10 -0400
Date: Thu, 27 Sep 2001 15:36:31 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Hugh Dickins <hugh@veritas.com>
cc: Alan Cox <laughing@shared-source.org>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.9-ac16 swapoff 2*vfree
In-Reply-To: <Pine.LNX.4.21.0109271956420.1095-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.21.0109271535500.1671-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Sep 2001, Hugh Dickins wrote:

> 2.4.9-ac16 swapoff warns "Trying to vfree() nonexistent vm area":
> the new (outside locks) vfree added, the old (inside) not removed.

Oh, crap... Thanks for spotting.
 
> Hugh
> 
> --- 2.4.9-ac16/mm/swapfile.c	Thu Sep 27 19:10:00 2001
> +++ linux/mm/swapfile.c	Thu Sep 27 19:43:12 2001
> @@ -636,7 +636,6 @@
>  	p->swap_device = 0;
>  	p->max = 0;
>  	swap_map = p->swap_map;
> -	vfree(p->swap_map);
>  	p->swap_map = NULL;
>  	p->flags = 0;
>  	swap_device_unlock(p);
> 
> 

