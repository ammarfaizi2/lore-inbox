Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbTI3N0O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 09:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbTI3NY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 09:24:57 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:22826 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261434AbTI3NWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 09:22:37 -0400
Date: Tue, 30 Sep 2003 14:22:11 +0100
From: Dave Jones <davej@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       richard.brunner@amd.com
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20030930132211.GA23333@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jamie Lokier <jamie@shareable.org>, akpm@osdl.org,
	torvalds@osdl.org, linux-kernel@vger.kernel.org,
	richard.brunner@amd.com
References: <20030930073814.GA26649@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930073814.GA26649@mail.jlokier.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 08:38:14AM +0100, Jamie Lokier wrote:
 > diff -urN --exclude-from=dontdiff orig-2.6.0-test6/arch/i386/Kconfig dual-2.6.0-test6/arch/i386/Kconfig
 > --- orig-2.6.0-test6/arch/i386/Kconfig	2003-09-30 05:39:33.467103692 +0100
 > +++ dual-2.6.0-test6/arch/i386/Kconfig	2003-09-30 06:05:19.868623767 +0100
 > @@ -397,6 +397,12 @@
 >  	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6
 >  	default y
 >  
 > +config X86_PREFETCH_FIXUP
 > +	bool
 > +	depends on MK7 || MK8
 > +	default y
 > +
 > +
 >  config HPET_TIMER
 >  	bool "HPET Timer Support"
 >  	help
 > diff -urN --exclude-from=dontdiff orig-2.6.0-test6/arch/i386/kernel/cpu/common.c dual-2.6.0-test6/arch/i386/kernel/cpu/common.c
 > --- orig-2.6.0-test6/arch/i386/kernel/cpu/common.c	2003-09-30 05:39:33.871035696 +0100
 > +++ dual-2.6.0-test6/arch/i386/kernel/cpu/common.c	2003-09-30 06:03:46.222851345 +0100
 > @@ -327,6 +327,17 @@
 >  	 * we do "generic changes."
 >  	 */
 >  
 > +	/* Prefetch works ok? */
 > +#ifndef CONFIG_X86_PREFETCH_FIXUP
 > +	if (c->x86_vendor != X86_VENDOR_AMD || c->x86 < 6)
 > +#endif
 > +	{
 > +		if (cpu_has(c, X86_FEATURE_XMM))
 > +			set_bit(X86_FEATURE_XMM_PREFETCH, c->x86_capability);
 > +		if (cpu_has(c, X86_FEATURE_3DNOW))
 > +			set_bit(X86_FEATURE_3DNOW_PREFETCH, c->x86_capability);
 > +	}
 > +
 >  	/* TSC disabled? */
 >  	if ( tsc_disable )

This looks to be completely gratuitous. Why disable it when we have the
ability to work around it ?

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
