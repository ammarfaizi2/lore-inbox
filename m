Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTEVPdD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 11:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTEVPdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 11:33:03 -0400
Received: from holomorphy.com ([66.224.33.161]:21644 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261939AbTEVPdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 11:33:02 -0400
Date: Thu, 22 May 2003 08:45:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: Gerrit Huizenga <gh@us.ibm.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       haveblue@us.ibm.com, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, mannthey@us.ibm.com,
       Andrew Theurer <habanero@us.ibm.com>
Subject: Re: userspace irq balancer
Message-ID: <20030522154544.GS8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	James Cleverdon <jamesclv@us.ibm.com>,
	Gerrit Huizenga <gh@us.ibm.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>, haveblue@us.ibm.com,
	pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
	johnstul@us.ibm.com, mannthey@us.ibm.com,
	Andrew Theurer <habanero@us.ibm.com>
References: <3014AAAC8E0930438FD38EBF6DCEB5640204334F@fmsmsx407.fm.intel.com> <200305220718.06982.jamesclv@us.ibm.com> <20030522144306.GQ8978@holomorphy.com> <200305220830.29592.jamesclv@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305220830.29592.jamesclv@us.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 08:30:29AM -0700, James Cleverdon wrote:
> Serial APICs have always had a spl-like effect built into them.
> The effective > TPR value of a given local APIC is:
> 	max(TPR, highest vector currently in progress) & 0xF0
> Parallel APICs don't do that because they don't have serial priority 
> arbitration; instead they use the xTPRs in the bridge chips.
> So, I suppose an argument could be made for setting the TPR to the vector 
> number on entry of do_IRQ.  I don't think that would be a good idea.  It 
> could interfere with IRQ nesting during a non-DMA IDE interrupt handler.  And 
> of course, an IRQ's vector has little to do with the IRQ itself, thanks to 
> the vector hashing scheme used to avoid the (stupid) 2 latches per APIC level 
> HW limitation of most i586 and i686 CPUs.

The code to deal with the 2 latches per APIC level is already
problematic in other ways. I'm not sure how much we can be allowed to
mix the issues. But I wouldn't mind at least hearing about alternative
methods of dealing with that that interact better with the rest of the
APIC mechanics. My interest in particular is vector exhaustion, but as
you point out rearrangements of that can also serve to make the TPR
more meaningful than it is now, and perhaps reduce mutual interference
between devices generating many interrupts and those generating few.

-- wli
