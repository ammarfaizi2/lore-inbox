Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264620AbTANPmv>; Tue, 14 Jan 2003 10:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbTANPm0>; Tue, 14 Jan 2003 10:42:26 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34320 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264620AbTANPmS>; Tue, 14 Jan 2003 10:42:18 -0500
Date: Tue, 14 Jan 2003 15:51:05 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: [BK-2.5] Update the generic DMA API to take GFP_ flags on
Message-ID: <20030114155105.A4077@flint.arm.linux.org.uk>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
References: <200301141530.h0EFUGH02371@localhost.localdomain> <20030114.073023.89921980.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030114.073023.89921980.davem@redhat.com>; from davem@redhat.com on Tue, Jan 14, 2003 at 07:30:23AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 07:30:23AM -0800, David S. Miller wrote:
>    From: James Bottomley <James.Bottomley@steeleye.com>
>    Date: Tue, 14 Jan 2003 10:30:15 -0500
> 
>    A GFP_KERNEL request is safely implemented as GFP_ATOMIC as long as the caller 
>    checks return for NULL.  for dma_alloc_coherent return checking is a 
>    requirement because the system may return NULL anyway if it is out of mappings 
>    even with a GFP_KERNEL flag.
>    
> Now what about the corollary, a platform that needs
> to sleep to setup the cpu mapings in a race-free manner?
> 
> It could not ever honor GFP_ATOMIC in that case.

That got solved in recent 2.5, albiet with limit of 2MB of consistent /
coherent allocations at any one time.  We return NULL if we run out of
space, and _all_ callers must check the return code of
pci_alloc_consistent and/or dma_alloc_coherent no matter what flags they
pass in.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

