Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbVCJHUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVCJHUw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 02:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVCJHUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 02:20:52 -0500
Received: from gate.crashing.org ([63.228.1.57]:58057 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262230AbVCJHUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 02:20:44 -0500
Subject: Re: [PATCH 2/2] No-exec support for ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@austin.ibm.com>
Cc: Jake Moilanen <moilanen@austin.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>
In-Reply-To: <20050310032507.GC20789@austin.ibm.com>
References: <20050308165904.0ce07112.moilanen@austin.ibm.com>
	 <20050308171326.3d72363a.moilanen@austin.ibm.com>
	 <20050310032507.GC20789@austin.ibm.com>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 18:15:34 +1100
Message-Id: <1110438934.32524.203.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 21:25 -0600, Olof Johansson wrote:
> Hi,
> 
> On Tue, Mar 08, 2005 at 05:13:26PM -0600, Jake Moilanen wrote:
> > diff -puN arch/ppc64/mm/hash_utils.c~nx-kernel-ppc64 arch/ppc64/mm/hash_utils.c
> > --- linux-2.6-bk/arch/ppc64/mm/hash_utils.c~nx-kernel-ppc64	2005-03-08 16:08:57 -06:00
> > +++ linux-2.6-bk-moilanen/arch/ppc64/mm/hash_utils.c	2005-03-08 16:08:57 -06:00
> > @@ -89,12 +90,23 @@ static inline void loop_forever(void)
> >  		;
> >  }
> >  
> > +int is_kernel_text(unsigned long addr)
> > +{
> > +	if (addr >= (unsigned long)_stext && addr < (unsigned long)__init_end)
> > +		return 1;
> > +
> > +	return 0;
> > +}
> 
> This is used in two files, but never declared extern in the second file
> (iSeries_setup.c). Should it go in a header file as a static inline
> instead?

Yes, I think it should.

> There also seems to be a local static is_kernel_text() in kallsyms that
> overlaps (but it's not identical). Removing that redundancy can be taken
> care of as a janitorial patch outside of the noexec stuff.
> 
> 
> 
> -Olof
> _______________________________________________
> Linuxppc64-dev mailing list
> Linuxppc64-dev@ozlabs.org
> https://ozlabs.org/cgi-bin/mailman/listinfo/linuxppc64-dev
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

