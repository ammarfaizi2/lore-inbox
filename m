Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269866AbUIDKVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269866AbUIDKVN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 06:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269869AbUIDKVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 06:21:13 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:54196 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S269866AbUIDKVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 06:21:08 -0400
Date: Sat, 4 Sep 2004 11:21:07 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/patch] macro_removal_agp_mtrr.diff
In-Reply-To: <1094292878.2801.7.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.58.0409041117160.25475@skynet>
References: <Pine.LNX.4.58.0409041053450.25475@skynet>
 <1094292878.2801.7.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> for example does this extra pointer really hurt in the *really* unlikely
> case you don't have AGP ?

good point..

>
> if you make a drm_core_has_AGP and drm_core_has_MTRR wrapper around
> these then...
>
>
> > +#if __OS_HAS_MTRR
> > +		if (drm_core_check_feature(dev, DRIVER_USE_MTRR)) {
> > +			if ( map->type == _DRM_FRAME_BUFFER ||
> > +			     (map->flags & _DRM_WRITE_COMBINING) ) {
> > +				map->mtrr = mtrr_add( map->offset, map->size,
> > +						      MTRR_TYPE_WRCOMB, 1 );
> > +			}
> >  		}
>
> ...this would NOT need an ifdef because drm_core_has_MTRR would be a
> define to 0 for non-OS_HAS_MTRR machines at which point the compiler
> removes the entire code. Eg no ifdef needed and the code gets more
> readable.

I never remember the compiler will drop things completely.. so the
mtrr_add will never show up in the module.. I'll implement these and throw
another patch in ...

Thanks,
Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

