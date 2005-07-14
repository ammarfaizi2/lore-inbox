Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262898AbVGNEbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbVGNEbx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 00:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbVGNEbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 00:31:53 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:17745 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262898AbVGNEbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 00:31:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=OsPRA0lJ5iOhpXoN4ncNaNVRfODT+I098nELqXHRm1gN68kG9u8JOki7Bg96XBy2+7GkunjsKfFjtGwUILJlTZUM2UX3wiD0/ocG5xwK72x8Y9X4c+dcCzpswZNclDNcq9wCQ0/qjyb4SWOgPB4IKh6oi7S+QvWJdyPyIIZ1glw=
Date: Thu, 14 Jul 2005 05:29:34 +0100
From: Nicholas Hans Simmonds <nhstux@gmail.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Nathan Scott <nathans@sgi.com>, linux-kernel@vger.kernel.org,
       "Andrew G. Morgan" <morgan@transmeta.com>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] Filesystem capabilities support
Message-ID: <20050714042934.GA25447@laptop>
References: <20050713062955.GA1609@laptop> <200507131751.j6DHpkBE016946@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507131751.j6DHpkBE016946@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 01:51:46PM -0400, Horst von Brand wrote:
> Nicholas Hans Simmonds <nhstux@gmail.com> wrote:
> > Sorry, my earlier reply seems to have gotten lost somewhere. I've been
> > pondering this issue for some time and am still not sure what's the best
> > answer. I've attached a small patch which handles this by detecting byte
> > swapping of the version code. I'm not convinced it's necessary but
> > shouldn't hurt.
> > 
> > diff --git a/security/commoncap.c b/security/commoncap.c
> > --- a/security/commoncap.c
> > +++ b/security/commoncap.c
> > @@ -153,6 +153,15 @@ int cap_bprm_set_security (struct linux_
> >  	down(&bprm_dentry->d_inode->i_sem);
> >  	ret = bprm_getxattr(bprm_dentry,XATTR_CAP_SET,&caps,sizeof(caps));
> >  	if(ret == sizeof(caps)) {
> > +		if(caps.version = swab32(_LINUX_CAPABILITY_VERSION)) {
>                               ^
> 				|
> 				+-- Surely wrong?!
> 

True, just noticed that. Amazing how even the simplest patches provide
such ample opportunity to shoot oneself in the foot.

> > +			swab32s(&caps.version);
> > +			swab32s(&caps.effective);
> > +			swab32s(&caps.mask_effective);
> > +			swab32s(&caps.permitted);
> > +			swab32s(&caps.mask_permitted);
> > +			swab32s(&caps.inheritable);
> > +			swab32s(&caps.mask_inheritable);
> > +		}
> >  		if(caps.version == _LINUX_CAPABILITY_VERSION) {
> >  			cap_t(bprm->cap_effective) &= caps.mask_effective;
> >  			cap_t(bprm->cap_effective) |= caps.effective;
> -- 
> Dr. Horst H. von Brand                   User #22616 counter.li.org
> Departamento de Informatica                     Fono: +56 32 654431
> Universidad Tecnica Federico Santa Maria              +56 32 654239
> Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

Other than this, what are the general thoughts about this method as
opposed to just using a well defined byte order?

Thanks,

Nicholas
