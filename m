Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbVHXDpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbVHXDpA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 23:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbVHXDpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 23:45:00 -0400
Received: from fmr17.intel.com ([134.134.136.16]:48798 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750929AbVHXDo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 23:44:59 -0400
Subject: Re: [PATCH] Add MCE resume under ia32
From: Shaohua Li <shaohua.li@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200508240512.35827.ak@suse.de>
References: <1124762500.3013.3.camel@linux-hp.sh.intel.com.suse.lists.linux.kernel>
	 <p73pss4f6dj.fsf@verdi.suse.de>
	 <1124848740.3622.1.camel@linux-hp.sh.intel.com>
	 <200508240512.35827.ak@suse.de>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 11:47:58 +0800
Message-Id: <1124855278.5047.2.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-24 at 05:12 +0200, Andi Kleen wrote:
> On Wednesday 24 August 2005 03:59, Shaohua Li wrote:
> > On Wed, 2005-08-24 at 03:52 +0200, Andi Kleen wrote:
> > > Shaohua Li <shaohua.li@intel.com> writes:
> > > > x86-64 has resume support. It uses 'on_each_cpu' in resume method,
> > > > which is known broken. We'd better fix it.
> > >
> > > What is broken with it?
> >
> > It's a sysdev. The resume method is invoked with interrupt disabled.
> 
> But only local interrupt disabled, no? 
> 
> Hmm - didn't we have a WARN_ON(irqs_disabled()) in smp_call_function().
> 
> Anyways, it'll probably still work for now because the system should
> be synchronized at this point.
We are using cpu hotplug framework for MP suspend/resume. When sysdev's
resume is calling, APs actually aren't up. So it actually can't work.

Thanks,
Shaohua

