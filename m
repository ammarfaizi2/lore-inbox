Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424460AbWKJWun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424460AbWKJWun (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 17:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424464AbWKJWum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 17:50:42 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:24585 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1424460AbWKJWum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 17:50:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=gHx2V7wHjhuNOMacd1eFAswuuP8xUx/8Fr0ozOrDbrZjDj0olxz6u8MzawftNMI9bZ5ixfHfITZ1/ywp3xMmNg9qRekSrPbUBOJifsq6QvFv69kq/fevxqO7Air5VoWTIH7wYl8wbXQ0ekawogEJG5KAapwoQCSoQl4/DzaIAuM=
Message-ID: <84144f020611101450p2613eca1v64e64e85ccb72936@mail.gmail.com>
Date: Sat, 11 Nov 2006 00:50:40 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Kirill Korotaev" <dev@sw.ru>
Subject: Re: [PATCH 6/13] BC: kmemsize accounting (core)
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, xemul@openvz.org,
       devel@openvz.org, oleg@tv-sign.ru, hch@infradead.org,
       matthltc@us.ibm.com, ckrm-tech@lists.sourceforge.net
In-Reply-To: <45535EA3.10300@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45535C18.4040000@sw.ru> <45535EA3.10300@sw.ru>
X-Google-Sender-Auth: 890901313c3a3262
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/06, Kirill Korotaev <dev@sw.ru> wrote:
> +#ifdef CONFIG_BEANCOUNTERS
> +#define BC_EXTRASIZE   sizeof(struct beancounter *)

Would much prefer you put all beancounter stuff into one #ifdef block
to avoid clutter.

> @@ -2579,14 +2635,14 @@ static struct slab *alloc_slabmgmt(struc
>         slabp->colouroff = colour_off;
>         slabp->s_mem = objp + colour_off;
>         slabp->nodeid = nodeid;
> +#ifdef CONFIG_BEANCOUNTERS
> +       if (cachep->flags & SLAB_BC)
> +               memset(slab_bc_ptrs(cachep, slabp), 0,
> +                               cachep->num * BC_EXTRASIZE);
> +#endif

No #ifdef within functions, please, but instead, make it an static
inline function.
