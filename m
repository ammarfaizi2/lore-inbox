Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbUDHWIP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 18:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262840AbUDHWIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 18:08:15 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:34197 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262815AbUDHWIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 18:08:13 -0400
Date: Thu, 08 Apr 2004 15:19:51 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <29690000.1081462791@flay>
In-Reply-To: <20040408215946.GU31667@dualathlon.random>
References: <20040406115539.GA31465@elte.hu> <20040406155925.GW2234@dualathlon.random> <20040406192549.GA14869@elte.hu> <12640000.1081378705@flay> <20040407230140.GT26888@dualathlon.random> <29510000.1081380104@flay> <20040407231806.GV26888@dualathlon.random> <33900000.1081380891@flay> <20040408001845.GX26888@dualathlon.random> <1479132704.1081405456@[10.10.2.4]> <20040408215946.GU31667@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Thursday, April 08, 2004 23:59:46 +0200 Andrea Arcangeli <andrea@suse.de> wrote:

> On Wed, Apr 07, 2004 at 11:24:16PM -0700, Martin J. Bligh wrote:
>> Instead of fiddling with tuning knobs, I'd prefer to just do the UKVA
>> idea I've proposed before, and let each process have their own pagetables
>> mapped permanently ;-)
> 
> that will have you pay for pte-highmem even in non-highmem machines.
> I'm always been against your above idea ;) It can speedup mmap a bit for
> some uncommon case but I believe your slowdown comes from the page faults after
> exeve and startup not from mmap with the kernel compile, and worst of
> all for non-highmem too (no sysctl or tuning knob can save you then).
> Amittedly some mmap intensive workload can get a slight speedup compared
> to pte-highmem but I don't think it's common and it has the potential of
> slowing down the page faults especially in short lived tasks even w/o
> highmem.

You mean the page-faults for the pagetable mappings themselves? I wouldn't
have thought that'd make an impact - at least I don't see how it could be
worse than pte_highmem. And as we could make it conditional on highmem
anyway (or even CONFIG_64GB, I'm pretty sure 4GB machines don't need it),
I don't think it matters (ie you'd just turn it on instead of pte_highmem).

But you're right, we do need to take that into consideration.
 
> What I found attractive was the persistent kmap in userspace, but that
> idea breaks with threading, and Andrew found another way that is to make
> the page fault interruptible so it doesn't seem very worthwhile anymore
> even w/o threading.

Yeah, I've given up on that one ;-) The main use for it was pagetables
anyway, and we can do that without the threading problems.

M.

