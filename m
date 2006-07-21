Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161044AbWGULLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161044AbWGULLJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 07:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161047AbWGULLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 07:11:09 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:5865 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1161044AbWGULLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 07:11:08 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Panagiotis Issaris <takis@gna.org>
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
Date: Fri, 21 Jul 2006 13:12:25 +0200
User-Agent: KMail/1.9.3
Cc: Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, jgarzik@pobox.com,
       vandrove@vc.cvut.cz, adaplas@pol.net, thomas@winischhofer.net,
       weissg@vienna.at, philb@gnu.org, linux-pcmcia@lists.infradead.org,
       jkmaline@cc.hut.fi, paulus@samba.org
References: <20060720190529.GC7643@lumumba.uhasselt.be> <200607210850.17878.eike-kernel@sf-tec.de> <1153477839.9489.25.camel@hemera>
In-Reply-To: <1153477839.9489.25.camel@hemera>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607211312.26459.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Panagiotis Issaris wrote:

> > > @@ -443,12 +442,11 @@ int con_clear_unimap(struct vc_data *vc,
> > >  	p = (struct uni_pagedir *)*vc->vc_uni_pagedir_loc;
> > >  	if (p && p->readonly) return -EIO;
> > >  	if (!p || --p->refcount) {
> > > -		q = (struct uni_pagedir *)kmalloc(sizeof(*p), GFP_KERNEL);
> > > +		q = kzalloc(sizeof(*p), GFP_KERNEL);
> > >  		if (!q) {
> > >  			if (p) p->refcount++;
> > >  			return -ENOMEM;
> > >  		}
> > > -		memset(q, 0, sizeof(*q));
> > >  		q->refcount=1;
> > >  		*vc->vc_uni_pagedir_loc = (unsigned long)q;
> > >  	} else {
> >
> > This one still changes the way the code works. Before your patch *p will
> > be always zeroed out. Now if p is there before it will keep it's
> > contents.
>
> Hmm. I do not really see the functional change here: If the memory
> allocation failed, then in both cases, q will be zero and the function
> will return. If the memory allocation succeeds, then in both cases a
> memset will occur. Is it more subtle than that?

You're right, I got somehow confused by this p and q stuff.

Eike
