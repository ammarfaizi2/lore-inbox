Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965247AbVLRT3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965247AbVLRT3f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 14:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbVLRT3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 14:29:35 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:23219 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965247AbVLRT3e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 14:29:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gjqFn2CCroDg3SwxEOA+sK7UDX296WHsqpXJJA9LHd2V/dw+lF86HgJOnvBaZdkrbB98fhdq1s5Gkmo2A3df2Y16xr/EdVxK6czwm7pe7+68do+jHBX3UMKimN9uO7vQ/LPm1B4ttAO6MnsKd8bUWNTt2ymOidj6OD5cfvbDuVY=
Message-ID: <28cc27130512181129q77fcccfcq@mail.gmail.com>
Date: Sun, 18 Dec 2005 20:29:31 +0100
From: Luuk van der Duim <luukvanderduim@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] micro optimization of cache_estimate in slab.c
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, LKML <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>, balbir.singh@wipro.com
In-Reply-To: <1134931062.13138.214.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1134894189.13138.208.camel@localhost.localdomain>
	 <84144f020512180927lc6492abpb28c047f9e0c535c@mail.gmail.com>
	 <1134931062.13138.214.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Index: linux-2.6.15-rc5/mm/slab.c
> ===================================================================
> --- linux-2.6.15-rc5.orig/mm/slab.c     2005-12-16 16:24:09.000000000 -0500
> +++ linux-2.6.15-rc5/mm/slab.c  2005-12-18 13:30:13.000000000 -0500
> @@ -708,7 +708,14 @@
>                 base = sizeof(struct slab);
>                 extra = sizeof(kmem_bufctl_t);
>         }
> -       i = 0;
> +       /*
> +        * Divide the amount we have, by the amount we need for
> +        * each object.  Since the size is already calculated
> +        * to be no less than the alignment, this result will
> +        * not be any greater than 1 that we need, and this will
> +        * be subtracted after the while loop.
> +        */
> +       i = (wastage - base)/(size + extra);
>         while (i*size + ALIGN(base+i*extra, align) <= wastage)
>                 i++;
>         if (i > 0)


Yes, I recognised the patch because I passed Balbirs version over to
Micheal Cohen in early 2002. The patch originaly was intended for 2.4

Complexity of Stevens patch has gone, readability has improved, Steven
has taken advantage of context-code and the rationale has been
explained in the comment.

Sounds fine to me.

   Luuk van der Duim

Partners aan het Werk
