Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269281AbUIIBJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269281AbUIIBJe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 21:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269319AbUIIBJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 21:09:33 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:15306 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S269281AbUIIBJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 21:09:30 -0400
Date: Wed, 8 Sep 2004 21:14:00 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>,
       acpi-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
Subject: RE: [ACPI] Re: [PATCH] Oops and panic while unloading holder of
 pm_idle
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD305751210A8@pdsmsx402.ccr.corp.intel.com>
Message-ID: <Pine.LNX.4.53.0409082106460.15087@montezuma.fsmlabs.com>
References: <16A54BF5D6E14E4D916CE26C9AD305751210A8@pdsmsx402.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shaohua,

> +		/* Wait the idle thread to read the new value, 
> +		 * otherwise we Oops.
> +		 */

I should have mentioned this earlier, but the comment needs work, 
something like this;

"We are about to unload the current idle thread pm callback (pm_idle), 
 Wait for all processors to update cached/local copies of pm_idle before 
 proceeding."

> +			/* If pm_idle is in a module and is preempted,
> +			 * oops occurs. Disable preempt.
> +			 */

"Mark this as an RCU critical section so that synchronize_kernel() in the 
 unload path waits for our completion."

Then resend the patch, i swear it'll be the last time ;)

Thanks,
	Zwane
