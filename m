Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269874AbUIDKao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269874AbUIDKao (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 06:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269875AbUIDKao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 06:30:44 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:59574 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S269874AbUIDKal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 06:30:41 -0400
Date: Sat, 4 Sep 2004 11:30:40 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/patch] macro_removal_agp_mtrr.diff
In-Reply-To: <1094292878.2801.7.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.58.0409041126500.25475@skynet>
References: <Pine.LNX.4.58.0409041053450.25475@skynet>
 <1094292878.2801.7.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> it looks you can nuke most of those.
> > -#if __REALLY_HAVE_AGP
> > +#if __OS_HAS_AGP
> >  	drm_agp_head_t    *agp;	/**< AGP data */
> >  #endif
>
> for example does this extra pointer really hurt in the *really* unlikely
> case you don't have AGP ?

actually it's not just the pointer it is the structure drm_agp_head_t I
think it needs some agp includes to work ..

> if you make a drm_core_has_AGP and drm_core_has_MTRR wrapper around
> these then...

Will using inlines work in this case if the inline returns 0 will the
compiler still do the removal...

so something like
static inline int drm_core_has_AGP(struct drm_device *dev)
{
#if __OS_HAS_AGP
	return drm_core_check_feature(dev, DRIVER_USE_AGP);
#else
	return 0;
}

or the macro one

#if __OS_HAS_AGP
#define drm_core_has_AGP(dev) drm_core_check_feature(dev, DRIVER_USE_AGP)
#else
#define drm_core_has_AGP(dev) (0)
#endif

if the inline will work I'll be happier using it.. I just need to know it
works for the range of compilers we use...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

