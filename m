Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030541AbWBIKcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030541AbWBIKcT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 05:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030624AbWBIKcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 05:32:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12464 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030541AbWBIKcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 05:32:18 -0500
Date: Thu, 9 Feb 2006 02:31:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: 76306.1226@compuserve.com, pj@sgi.com, wli@holomorphy.com, ak@muc.de,
       mingo@elte.hu, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       riel@redhat.com, dada1@cosmobay.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-Id: <20060209023106.10c53c0b.akpm@osdl.org>
In-Reply-To: <20060209102317.GA20554@osiris.boeblingen.de.ibm.com>
References: <200602090335_MC3-1-B7FA-621E@compuserve.com>
	<20060209010655.5cdeb192.akpm@osdl.org>
	<20060209011106.68aa890a.akpm@osdl.org>
	<20060209100834.GA9281@osiris.boeblingen.de.ibm.com>
	<20060209021314.23a9096f.akpm@osdl.org>
	<20060209102317.GA20554@osiris.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
>
> > > > > aargh.
> > >  > Actually, x86 appears to be the only arch which suffers this braindamage. 
> > >  > The rest use CPU_MASK_NONE (or just forget to initialise it and hope that
> > >  > CPU_MASK_NONE equals all-zeroes).
> > > 
> > >  s390 will join, as soon as the cpu_possible_map fix is merged...
> > 
> > What cpu_possible_map fix?
> 
> This one:
> 
> http://lkml.org/lkml/2006/2/8/162
> 

Oh, OK.  Ow, I don't think you want to do that.  It means that all those
for_each_cpu() loops will now be iterating over all NR_CPUS cpus, whether
or not they're even possible.

