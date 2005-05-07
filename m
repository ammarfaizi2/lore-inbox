Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263130AbVEGNl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbVEGNl2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 09:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbVEGNl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 09:41:28 -0400
Received: from cantor2.suse.de ([195.135.220.15]:51591 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S263130AbVEGNl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 09:41:26 -0400
Date: Sat, 7 May 2005 15:41:16 +0200
From: Andi Kleen <ak@suse.de>
To: Natalie.Protasevich@unisys.com
Cc: akpm@osdl.org, ak@suse.de, zwane@arm.linux.org.uk, len.brown@intel.com,
       venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] Do not enforce unique IO_APIC_ID for Xeon processors in EM64T mode (x86_64)
Message-ID: <20050507134116.GA30158@wotan.suse.de>
References: <20050505221117.508BB42AE4@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050505221117.508BB42AE4@linux.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2005 at 03:11:16PM -0700, Natalie.Protasevich@unisys.com wrote:
> 
> 
> This patch disables unique IO_APIC_ID check for xAPIC systems running in EM64T mode. Xeon-based ES7000s panic failing this unnecessary check. I added IOAPIC_ID_CHECK config option and turned it off for Intel processors. Also added the boot option that overrides default and turnes this check on/off in case it is needed for some reason. Hope this is acceptable way to fix the problem.

I think we can turn it off for all x86-64 systems. Near all EM64T 
systems have xAPIC. AMD processors don't need it neither. That would only 
leave the new IBM summit2 chipset, but I suppose they also don't need this 
(James please complain if I am wrong)

So can you please do a new patch that just removes this code?

More tricky will be to do the equivalent patch on i386 because they
still need to support the pre XAPICs and have to detect this case.
I suppose an heuristic like
if (cpu is P6 or earlier and from Intel)
	enable
else
	disable
would be good enough.	

Thanks

-Andi

