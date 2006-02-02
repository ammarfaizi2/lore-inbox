Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423350AbWBBHcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423350AbWBBHcc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 02:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423351AbWBBHcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 02:32:32 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:20303 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423350AbWBBHcc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 02:32:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NG0GMkaJkNZIwtObI/lwbt7oOSNelLKXKZKfKe410DYOhRNbhWThTbPXho5Lf5SMBEuGQeju4jztR0hoCWnN+5n5OlYuwCBo+/NvPbGVAsS6G8MMAU+RMVBGmaZWQu3lA9k/TaPzc98EPPTKo0y6RrRwBU4v+uOwTpQ+jyTdMfA=
Message-ID: <84144f020602012332g57a58f0aw373983fc6bc7368b@mail.gmail.com>
Date: Thu, 2 Feb 2006 09:32:30 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Size-128 slab leak
Cc: "Kevin O'Connor" <kevin@koconnor.net>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, manfred@colorfullife.com
In-Reply-To: <20060201231001.0ca96bf0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060131024928.GA11395@double.lan>
	 <20060201231001.0ca96bf0.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/2/06, Andrew Morton <akpm@osdl.org> wrote:
> @@ -2550,6 +2550,15 @@ static void *cache_alloc_debugcheck_afte
>                 *dbg_redzone1(cachep, objp) = RED_ACTIVE;
>                 *dbg_redzone2(cachep, objp) = RED_ACTIVE;
>         }
> +       {
> +               int objnr;
> +               struct slab *slabp;
> +
> +               slabp = page_get_slab(virt_to_page(objp));
> +
> +               objnr = (objp - slabp->s_mem) / cachep->objsize;
> +               slab_bufctl(slabp)[objnr] = (unsigned long)caller;
> +       }

We already have last caller in dbg_userword. Manfred, is there a
reason we're not using it?

                               Pekka
