Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbTENN4H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 09:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbTENNzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 09:55:48 -0400
Received: from netline-be1.netline.ch ([195.141.226.32]:9998 "EHLO
	netline-be1.netline.ch") by vger.kernel.org with ESMTP
	id S262249AbTENNzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 09:55:35 -0400
Subject: Re: Improved DRM support for cant_use_aperture platforms
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: davidm@hpl.hp.com
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
In-Reply-To: <16064.41491.952068.159814@napali.hpl.hp.com>
References: <200305101009.h4AA9GZi012265@napali.hpl.hp.com>
	 <1052653415.12338.159.camel@thor>
	 <16062.37308.611438.5934@napali.hpl.hp.com>
	 <20030511195543.GA15528@suse.de> <1052690133.10752.176.camel@thor>
	 <16063.60859.712283.537570@napali.hpl.hp.com>
	 <1052768911.10752.268.camel@thor>
	 <16064.453.497373.127754@napali.hpl.hp.com>
	 <1052774487.10750.294.camel@thor>
	 <16064.5964.342357.501507@napali.hpl.hp.com>
	 <1052786080.10763.310.camel@thor>
	 <16064.41491.952068.159814@napali.hpl.hp.com>
Content-Type: text/plain; charset=iso-8859-1
Organization: Debian, XFree86
Message-Id: <1052921284.18105.168.camel@thor>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.1.99 (Preview Release)
Date: 14 May 2003 16:08:05 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 2003-05-13 at 09:43, David Mosberger wrote: 
> >>>>> On 13 May 2003 02:34:41 +0200, Michel Dänzer <michel@daenzer.net> said:
> 
>   >> It should be possible to add vmap() and vunmap() to kernel/vmalloc.c
>   >> on older kernels.  I think those are the only dependencies
> 
>   Michel> There are a couple more, like pte_offset_kernel(), pte_pfn(),
>   Michel> pfn_to_page() and flush_tlb_kernel_range(). Getting this working with
>   Michel> 2.4 seems like a lot of work and/or ugly. :\
> 
> Actually, it turns out I'm really not well positioned to do this,
> because the ia64 agp patch for 2.4 looks very different from the 2.5
> and your tree looks rather different from the DRM stuff that's in the
> official Linux tree (correct me if I'm wrong here).
> 
> Anyhow, this should get you close to compiling (and working,
> hopefully), modulo vmap/vunmap:
> 
> #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
> # define pte_offset_kernel(dir, address)	pte_offset(dir, address)
> # define pte_pfn(pte)				(pte_page(pte) - mem_map)
> # define flush_tlb_kernel_range(s,e)		flush_tlb_all()
> #endif

[...]

> The above definition of pte_pfn() is not truly platform-independent,
> but I believe it works on all platforms that support AGP.

Looks like it should work on sane PPC systems as well. :)

# define pfn_to_page(pfn)			(mem_map + (pfn))

is also needed.


After some more thinking, the way to go for deciding whether or not to
use the new code probably isn't by checking the version but by using
some Makefile trickery as there is already for do_munmap and
remap_page_range. Once that is in place, it looks like I can finally
commit it. :)


-- 
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer

