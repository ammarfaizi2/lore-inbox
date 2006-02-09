Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422890AbWBILrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422890AbWBILrJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 06:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422893AbWBILrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 06:47:09 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:21188 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422890AbWBILrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 06:47:08 -0500
Date: Thu, 9 Feb 2006 12:47:00 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: 76306.1226@compuserve.com, pj@sgi.com, wli@holomorphy.com, ak@muc.de,
       mingo@elte.hu, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       riel@redhat.com, dada1@cosmobay.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-ID: <20060209114700.GB20554@osiris.boeblingen.de.ibm.com>
References: <200602090335_MC3-1-B7FA-621E@compuserve.com> <20060209010655.5cdeb192.akpm@osdl.org> <20060209011106.68aa890a.akpm@osdl.org> <20060209100834.GA9281@osiris.boeblingen.de.ibm.com> <20060209021314.23a9096f.akpm@osdl.org> <20060209102317.GA20554@osiris.boeblingen.de.ibm.com> <20060209023106.10c53c0b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060209023106.10c53c0b.akpm@osdl.org>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > >  > Actually, x86 appears to be the only arch which suffers this braindamage. 
> > > >  > The rest use CPU_MASK_NONE (or just forget to initialise it and hope that
> > > >  > CPU_MASK_NONE equals all-zeroes).
> > > > 
> > > >  s390 will join, as soon as the cpu_possible_map fix is merged...
> > > 
> > > What cpu_possible_map fix?
> > 
> > This one:
> > 
> > http://lkml.org/lkml/2006/2/8/162
> > 
> 
> Oh, OK.  Ow, I don't think you want to do that.  It means that all those
> for_each_cpu() loops will now be iterating over all NR_CPUS cpus, whether
> or not they're even possible.

That's ok. We're mainly running under z/VM where you can attach new virtual
cpus on the fly to the virtual machine (up to 64 cpus).
The only difference to before is that it was possible to limit the waste of
resources by passing a number with 'maxcpus'. This value was used to generate
the cpu_possible_map.
But since the map needs to be ready when we return from setup_arch, we don't
have access to max_cpus, unless we parse commandline on our own...

Heiko
