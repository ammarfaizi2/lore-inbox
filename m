Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVHFAWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVHFAWM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 20:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVHFAWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 20:22:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8375 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261334AbVHFAWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 20:22:10 -0400
Date: Fri, 5 Aug 2005 17:22:06 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com
Subject: Re: [PATCH, experimental] i386 Allow the fixmap to be relocated at boot time
Message-ID: <20050806002206.GZ7762@shell0.pdx.osdl.net>
References: <42F3F61F.30305@vmware.com> <20050805234655.GY7762@shell0.pdx.osdl.net> <42F3FFBA.3040009@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F3FFBA.3040009@vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Your patch looks good, although the minimal change to subarch is to 
> merely have __FIXADDR_TOP defined by the sub-architecture.  Is there any 
> additional benefit to moving the fixmaps into the subarch - i.e. moving 
> subarch-specific pieces out of mach-default?

As you've identified, so subarch can put whatever wonky junk
it needs in there.

> I guess there is.  For example include/asm-i386/mach-visws/mach_fixmap.h 
> could do this:
> 
> #define SUBARCH_FIXMAPS \
>        FIX_CO_CPU,     /* Cobalt timer */ \
>        FIX_CO_APIC,    /* Cobalt APIC Redirection Table */ \
>        FIX_LI_PCIA,    /* Lithium PCI Bridge A */ \
>        FIX_LI_PCIB,    /* Lithium PCI Bridge B */
> 
> Then include/asm-i386/fixmap.h includes <mach_fixmap.h>, for which the 
> default is an empty define for SUBARCH_FIXMAPS.

nice.

> Also, it seems reasonable that people may want to poke holes in high 
> linear space for other hypervisor projects, research, or performance 
> reasons without having to build a custom sub-architecture just for 
> that.  So I think there is some benefit to making the hole size a 
> general configurable option (with defaults depending on the sub-arch you 
> select).

It needs to have tangible value for in-tree code.  Seems worthwhile to
play with it a bit though.

thanks,
-chris
