Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbUD3T0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbUD3T0Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 15:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUD3T0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 15:26:24 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:58806 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261161AbUD3T0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 15:26:22 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Andrew Morton <akpm@osdl.org>, Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: [BUG] 2.6.6-rc2-bk5 mm/slab.c change broke x86-64 SMP
Date: Fri, 30 Apr 2004 21:33:05 +0200
User-Agent: KMail/1.5
Cc: ak@suse.de, linux-kernel@vger.kernel.org
References: <200404301611.i3UGBkdK026345@harpo.it.uu.se> <20040430112704.3dca3c4c.akpm@osdl.org>
In-Reply-To: <20040430112704.3dca3c4c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404302133.05387.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 of April 2004 20:27, Andrew Morton wrote:
> Mikael Pettersson <mikpe@csd.uu.se> wrote:
> > The change to mm/slab.c between 2.6.6-rc2-bk4 and -bk5
> > broke x86-64 SMP. The symptoms are general protection
> > faults in __switch_to shortly after init starts, and
> > then the machine is dead. (Can't be more specific, my
> > box can't log early boot oopses.)
> >
> > I'm only seeing this with x86-64 SMP; x86-64 UP and i386
> > SMP on the same machine (Athlon64 UP) have no problems.
> >
> > Reverting 2.6.6-rc2-bk5's change to mm/slab.c eliminates
> > the problem.
>
> The "-bk5" terminology doesn't mean much to people who use bitkeeper or who
> use http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/ - I assume
> you refer to the alignment changes?
>
> Does this fix?
>
> diff -puN include/asm-x86_64/processor.h~a include/asm-x86_64/processor.h
> --- 25/include/asm-x86_64/processor.h~a	Fri Apr 30 11:24:58 2004
> +++ 25-akpm/include/asm-x86_64/processor.h	Fri Apr 30 11:25:28 2004
> @@ -20,6 +20,8 @@
>  #include <asm/mmsegment.h>
>  #include <linux/personality.h>
>
> +#define ARCH_MIN_TASKALIGN L1_CACHE_BYTES
> +
>  #define TF_MASK		0x00000100
>  #define IF_MASK		0x00000200
>  #define IOPL_MASK	0x00003000
>

AFAICS, yes, it does. :-)
I'm now (happily) running 2.6.6-rc3 on a dual-Opteron box.

RJW

