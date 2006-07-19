Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWGSNyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWGSNyD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 09:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWGSNyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 09:54:02 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:40126 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964818AbWGSNyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 09:54:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=KoLCfR4v1FRCiuMCCsnKrYrtTPSasYNlUvno0joVOM1S8SQ9V7w8AFPBL5pRGRDcKJHYJwjXmv2tZmGzKxelV1djHgXa7VIelqIbfraCzhIeu+RhAKwa9fK36Y26gB6ZZcJZHp927lxvyMrGipF6utsChGwy+20POBMv2BUTh2Q=
Message-ID: <84144f020607190653r5fb8b220g7d183ca79e95eff2@mail.gmail.com>
Date: Wed, 19 Jul 2006 16:53:58 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
Cc: "Panagiotis Issaris" <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, jgarzik@pobox.com,
       vandrove@vc.cvut.cz, adaplas@pol.net, thomas@winischhofer.net,
       weissg@vienna.at, philb@gnu.org, linux-pcmcia@lists.infradead.org,
       jkmaline@cc.hut.fi, catalin.marinas@gmail.com
In-Reply-To: <17598.10992.445446.148411@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060719004659.GA30823@lumumba.uhasselt.be>
	 <17598.10992.445446.148411@cargo.ozlabs.ibm.com>
X-Google-Sender-Auth: 1224dfaa9e045379
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/06, Paul Mackerras <paulus@samba.org> wrote:
> > -     par->mmap_map = kmalloc(j * sizeof(*par->mmap_map), GFP_ATOMIC);
> > +     par->mmap_map = kcalloc(j, sizeof(*par->mmap_map), GFP_ATOMIC);
> >       if (!par->mmap_map) {
> >               PRINTKE("atyfb_setup_sparc() can't alloc mmap_map\n");
> >               return -ENOMEM;
> >       }
> > -     memset(par->mmap_map, 0, j * sizeof(*par->mmap_map));
>
> What exactly do we gain by using kcalloc rather than kzalloc here?
> There is no potential overflow issue to worry about.

Potentially useful for kmemleak, I think. Catalin?

                                       Pekka
