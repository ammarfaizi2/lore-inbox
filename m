Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWGTSDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWGTSDl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 14:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWGTSDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 14:03:41 -0400
Received: from outmx018.isp.belgacom.be ([195.238.4.117]:10982 "EHLO
	outmx018.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1750832AbWGTSDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 14:03:40 -0400
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to
	k(z|c)alloc.
From: Panagiotis Issaris <takis@gna.org>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, jgarzik@pobox.com,
       vandrove@vc.cvut.cz, adaplas@pol.net, thomas@winischhofer.net,
       weissg@vienna.at, philb@gnu.org, linux-pcmcia@lists.infradead.org,
       jkmaline@cc.hut.fi, paulus@samba.org
In-Reply-To: <44BE395B.2090001@grupopie.com>
References: <20060719004659.GA30823@lumumba.uhasselt.be>
	 <44BE395B.2090001@grupopie.com>
Content-Type: text/plain
Date: Thu, 20 Jul 2006 20:03:12 +0200
Message-Id: <1153418593.11873.48.camel@hemera>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On wo, 2006-07-19 at 14:53 +0100, Paulo Marques wrote:
> > [...]
> > --- a/drivers/char/consolemap.c
> > +++ b/drivers/char/consolemap.c
> > @@ -192,11 +192,9 @@ static void set_inverse_transl(struct vc
> >  	q = p->inverse_translations[i];
> >  
> >  	if (!q) {
> > -		q = p->inverse_translations[i] = (unsigned char *) 
> > -			kmalloc(MAX_GLYPH, GFP_KERNEL);
> > +		q = p->inverse_translations[i] = kzalloc(MAX_GLYPH, GFP_KERNEL);
> >  		if (!q) return;
> >  	}
> > -	memset(q, 0, MAX_GLYPH);
> 
> This changes semantics here. Before, the data pointed by q was always 
> cleared whether it was malloc'ed or not. Now it is only cleared if it is 
> malloc'ed. I haven't checked the code to find out if this is ok, though.
Oops :( My bad. I've removed this from my updated patch. Thanks!

>[...]
> > -			struct cardmap *np = kmalloc(sizeof(*np), GFP_KERNEL);
> > -			memset(np, 0, sizeof(*np));
> > +			struct cardmap *np = kzalloc(sizeof(*np), GFP_KERNEL);
> >  			np->shift = p->shift - CARDMAP_ORDER;
> >  			np->parent = p;
> >  			p->ptr[i] = np;
> 
> This is not your fault, but this code is using the return value from 
> kmalloc (or kzalloc, now) without checking for NULL.
Oops again. I should have noticed that. Thanks again!

> > --- a/drivers/video/offb.c
> > +++ b/drivers/video/offb.c
> > @@ -376,13 +376,12 @@ static void __init offb_init_fb(const ch
> >  
> >  	size = sizeof(struct fb_info) + sizeof(u32) * 17;
> >  
> > -	info = kmalloc(size, GFP_ATOMIC);
> > +	info = kzalloc(size, GFP_ATOMIC);
> >  	
> >  	if (info == 0) {
> 
> Again, not your fault, but "info == 0"? If you're doing a new version of 
> the patch, please change this to NULL or !info, so that we don't confuse 
> human readers :)
Thanks for the hint! I've modified my patch accordingly.

Cheers,
Takis


