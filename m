Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273940AbRI0V52>; Thu, 27 Sep 2001 17:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273951AbRI0V5T>; Thu, 27 Sep 2001 17:57:19 -0400
Received: from daytona.gci.com ([205.140.80.57]:8461 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S273940AbRI0V5K>;
	Thu, 27 Sep 2001 17:57:10 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA315061466BF@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: linux-kernel@vger.kernel.org
Subject: RE: [PATCH] 2.4.9-ac16 swapoff 2*vfree
Date: Thu, 27 Sep 2001 13:57:31 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've applied this patch, and together with 2.4.9-ac16 on
my UltraSparc (1x300mHz, 1024Mb)  seems to be working just fine
so far.

I've got a pretty popular Unreal Tournament Map Mirror site,
so my webserver gets a lot of traffic which should exercise the VM
pretty well, especially as I keep quite a few xterms open.  Plus
a mozilla build every now and then.

But up to now it looks good!  Nice job, all.

> -----Original Message-----
> From: Hugh Dickins [mailto:hugh@veritas.com]
> 
> 2.4.9-ac16 swapoff warns "Trying to vfree() nonexistent vm area":
> the new (outside locks) vfree added, the old (inside) not removed.
> 
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
