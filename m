Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbTELTfz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 15:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbTELTfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 15:35:55 -0400
Received: from netline-be1.netline.ch ([195.141.226.32]:47629 "EHLO
	netline-be1.netline.ch") by vger.kernel.org with ESMTP
	id S262568AbTELTfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 15:35:53 -0400
Subject: Re: [Dri-devel] Re: Improved DRM support for cant_use_aperture
	platforms
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: davidm@hpl.hp.com
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
In-Reply-To: <16063.60859.712283.537570@napali.hpl.hp.com>
References: <200305101009.h4AA9GZi012265@napali.hpl.hp.com>
	 <1052653415.12338.159.camel@thor>
	 <16062.37308.611438.5934@napali.hpl.hp.com>
	 <20030511195543.GA15528@suse.de> <1052690133.10752.176.camel@thor>
	 <16063.60859.712283.537570@napali.hpl.hp.com>
Content-Type: text/plain; charset=iso-8859-1
Organization: Debian, XFree86
Message-Id: <1052768911.10752.268.camel@thor>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.1.99 (Preview Release)
Date: 12 May 2003 21:48:31 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-12 at 20:53, David Mosberger wrote:
> >>>>> On 11 May 2003 23:55:33 +0200, Michel Dänzer <michel@daenzer.net> said:
> 
>   >> OK, we have a chicken & egg problem then: I could obviously add
>   >> Linux kernel version checks where needed, but to do that, the
>   >> patch first needs to go into the kernel.
> 
>   Michel> Mind elaborating on that? I don't see such a problem as you
>   Michel> don't need version checks for anything the patch itself
>   Michel> adds, only for kernel infrastructure that isn't available in
>   Michel> older kernels (down to 2.4).
> 
> OK, I'm confused then: earlier on, you reported this error:
> 
>   asm/agp.h: No such file or directory
> 
> My patch adds the following to asm-i386/agp.h:
> 
> diff -Nru a/include/asm-i386/agp.h b/include/asm-i386/agp.h
> --- a/include/asm-i386/agp.h	Sat May 10 01:47:42 2003
> +++ b/include/asm-i386/agp.h	Sat May 10 01:47:42 2003
> @@ -20,4 +20,11 @@
>     worth it. Would need a page for it. */
>  #define flush_agp_cache() asm volatile("wbinvd":::"memory")
>  
> +/*
> + * Page-protection value to be used for AGP memory mapped into kernel space.  For
> + * platforms which use coherent AGP DMA, this can be PAGE_KERNEL.  For others, it needs to
> + * be an uncached mapping (such as write-combining).
> + */
> +#define PAGE_AGP			PAGE_KERNEL_NOCACHE
> +
>  #endif
> 
> So, either you're using a platform which I don't know supports AGP, or
> the patch didn't apply cleanly (perhaps because you're using an old
> kernel that doesn't have asm/agp.h yet?).

That's it. So we have to check the version before #including
<asm/agp.h>. Then, we can do something like

#ifndef PAGE_AGP
#define PAGE_AGP PAGE_KERNEL_NOCACHE
#endif

Or am I missing something?


This is the easy part though, you probably know better than I what to do
about the functions you use that aren't available in 2.4 yet. :)


-- 
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer

