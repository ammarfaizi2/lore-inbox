Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbVHDQlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbVHDQlX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 12:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbVHDQio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 12:38:44 -0400
Received: from fmr22.intel.com ([143.183.121.14]:23972 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262618AbVHDQhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 12:37:00 -0400
Date: Thu, 4 Aug 2005 09:36:10 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>,
       zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [patch 5/8] x86_64:Dont do broadcast IPIs when hotplug is enabled in flat mode.
Message-ID: <20050804093609.C15274@unix-os.sc.intel.com>
References: <20050801202017.043754000@araj-em64t> <20050801203011.403184000@araj-em64t> <20050804105107.GD97893@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050804105107.GD97893@muc.de>; from ak@muc.de on Thu, Aug 04, 2005 at 12:51:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 12:51:07PM +0200, Andi Kleen wrote:
> >  static void flat_send_IPI_allbutself(int vector)
> >  {
> > +#ifndef CONFIG_HOTPLUG_CPU
> >  	if (((num_online_cpus()) - 1) >= 1)
> >  		__send_IPI_shortcut(APIC_DEST_ALLBUT, vector,APIC_DEST_LOGICAL);
> > +#else
> > +	cpumask_t allbutme = cpu_online_map;
> > +	int me = get_cpu(); /* Ensure we are not preempted when we clear */
> > +	cpu_clear(me, allbutme);
> > +	flat_send_IPI_mask(allbutme, vector);
> > +	put_cpu();
> 
> This still needs the num_online_cpus()s check.

Opps missed that... Thanks for spotting it.

I will send an updated one to Andrew.
-- 
Cheers,
Ashok Raj
- Open Source Technology Center
