Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262600AbVHDQay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbVHDQay (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 12:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVHDQax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 12:30:53 -0400
Received: from fmr21.intel.com ([143.183.121.13]:15034 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262600AbVHDQ3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 12:29:36 -0400
Date: Thu, 4 Aug 2005 09:28:41 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>,
       zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/8] x86_64:Dont call enforce_max_cpus when hotplug is enabled
Message-ID: <20050804092841.A15274@unix-os.sc.intel.com>
References: <20050801202017.043754000@araj-em64t> <20050801203011.178499000@araj-em64t> <20050804104110.GB97893@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050804104110.GB97893@muc.de>; from ak@muc.de on Thu, Aug 04, 2005 at 12:41:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 12:41:10PM +0200, Andi Kleen wrote:
> On Mon, Aug 01, 2005 at 01:20:20PM -0700, Ashok Raj wrote:
> > No need to enforce_max_cpus when hotplug code is enabled. This
> > nukes out cpu_present_map and cpu_possible_map making it impossible to add
> > new cpus in the system.
> 
> Hmm - i think there was some reason for this early zeroing,
> but I cannot remember it right now.
> 
> It might be related to some checks later that check max possible cpus.
> 
> So it would be still good to have some way to limit max possible cpus.
> Maybe with a new option?

The only useful thing with enfore_max() is that cpu_possible_map is trimmed
so some resource allocations that use for_each_cpu() for upfront allocation
wont allocate resources.

Currently i see max_cpus only limiting boot-time start, none trim cpu_possible
which is done in only x86_64. max_cpu is still honored, just that for initial
boot. I would think maybe remove enforce_max_cpus() altogether like other 
archs instead of adding one more just for x86_64. 

Maybe we should add only if there is a need, instead of adding and finding
no-one using it and finally removing it very soon.
> 
> -Andi

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
