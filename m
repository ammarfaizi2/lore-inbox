Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261534AbSJAIgq>; Tue, 1 Oct 2002 04:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261535AbSJAIgq>; Tue, 1 Oct 2002 04:36:46 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60688 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261534AbSJAIgq>; Tue, 1 Oct 2002 04:36:46 -0400
Date: Tue, 1 Oct 2002 09:42:02 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andrew Morton <akpm@digeo.com>, David Miller <davem@redhat.com>,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH,RFC] Add gfp_mask to get_vm_area()
Message-ID: <20021001094202.C29814@flint.arm.linux.org.uk>
References: <20021001044226.GS10265@zax> <3D992DB0.9A8942D@digeo.com> <20021001053417.GW10265@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021001053417.GW10265@zax>; from david@gibson.dropbear.id.au on Tue, Oct 01, 2002 at 03:34:17PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 03:34:17PM +1000, David Gibson wrote:
> I don't see an easy one: PPC 4xx has non-coherent cache, so we have to
> mark consistent memory non-cacheable.  We want to make the normal
> lowmem mapping use large page TLB entries, so we can't frob the
> attribute bits on the pages in place.  That means we need to create a
> new, non-cacheable mapping for the physical RAM we allocate, which in
> turn means allocating a chunk of kernel virtual memory.

Same problem on ARM.  I just haven't got the motivation to rewrite the
bits of the kernel that need to be rewritten to make it work.

Have you checked that your pte/pmd allocation functions can be called
from IRQ context as well?

You basically need:

 - irq-safe get_vm_area
 - irq-safe pmd_alloc_kernel
 - irq-safe pte_alloc_kernel

Last time I looked, all the above were not irq-safe.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

