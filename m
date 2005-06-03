Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVFCQJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVFCQJj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 12:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVFCQJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 12:09:39 -0400
Received: from colin.muc.de ([193.149.48.1]:48901 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261275AbVFCQJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 12:09:37 -0400
Date: 3 Jun 2005 18:09:32 +0200
Date: Fri, 3 Jun 2005 18:09:32 +0200
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com
Subject: Re: 2.6.12-rc5 is broken in nvidia Ck804 Opteron MB/with dual cor e dual way
Message-ID: <20050603160932.GH1683@muc.de>
References: <3174569B9743D511922F00A0C94314230A403985@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C94314230A403985@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 01:42:00PM -0700, YhLu wrote:
>         cpuid(1, &eax, &ebx, &ecx, &edx);
>         smp_num_siblings = (ebx & 0xff0000) >> 16;
> 
> For amd dual core, smp_num_siblings is set to 1, and it mean has two cores.
> 
>                 seq_printf(m, "siblings\t: %d\n",
>                                 c->x86_num_cores * smp_num_siblings);

Yes; that is done so that the scheduler does not set up
SMT scheduling, which is suboptimal for dual core.

Also some time ago the scheduler domain setup tended to break
with SMT and NUMA combined, but that is probably fixed
now. But it also made it advisable to not set the sibling count.

> 
> for Intel it would be 
> 	c->x86_num_cores  is 2 and smp_num_siblings is 2 too....
> 	so every core will be HT....

If that was true, then a true DC+HT machine would report 4.

I doubt it is, but Suresh can probably clarify.

> Function 0000_0001[EBX]
> EBX[23:16] Logical Processor Count. If CPUID Fn[8000_0001, 0000_0001][EDX:
> HTT, ECX:
> CMPLegacy] = 11b, then this field indicates the number of CPU cores in the
> processor.
> Otherwise, this field is reserved.
> 
> what is intel value about cpuid(1) ebx [23:16], when the CPU is dual core,
> but HT is disabled.
> 1?

-Andi
