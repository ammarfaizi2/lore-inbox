Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbVLANTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbVLANTE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 08:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVLANTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 08:19:04 -0500
Received: from ns2.suse.de ([195.135.220.15]:54252 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932214AbVLANTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 08:19:03 -0500
Date: Thu, 1 Dec 2005 14:18:57 +0100
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: x86_64/HOTPLUG_CPU: NULL dereference doesn't #PF with init_level4_pgt
Message-ID: <20051201131857.GG19515@wotan.suse.de>
References: <Pine.LNX.4.64.0511301859070.13220@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511301859070.13220@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2005 at 08:03:33PM -0800, Zwane Mwaikambo wrote:
> NULL dereferences don't cause a page fault if the 4th level pagetable 
> being used is init_level4_pgt because we never zap_low_mappings. Since 
> the idle thread uses init_level4_pgt any bad dereferences happening there 
> (e.g. from interrupts) won't cause a fault. Andi would you be fine with 
> switching the idle threads to a different level4?

That recently changed. Are you sure it's still the case?

idle threads should always run with lazy TLB, no different mms.
That's important for performance.

If a NULL reference causes a oops or not depends on if user space
from the last process mapped a page to NULL or not.

-Andi
