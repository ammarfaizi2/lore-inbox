Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267309AbSLEMhE>; Thu, 5 Dec 2002 07:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267310AbSLEMhE>; Thu, 5 Dec 2002 07:37:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58637 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267309AbSLEMhD>; Thu, 5 Dec 2002 07:37:03 -0500
Date: Thu, 5 Dec 2002 12:44:34 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021205124434.C22686@flint.arm.linux.org.uk>
Mail-Followup-To: "Adam J. Richter" <adam@yggdrasil.com>,
	linux-kernel@vger.kernel.org
References: <200212051221.EAA04710@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200212051221.EAA04710@adam.yggdrasil.com>; from adam@yggdrasil.com on Thu, Dec 05, 2002 at 04:21:01AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 04:21:01AM -0800, Adam J. Richter wrote:
> Russell King wrote:
> [An excellent explanation of why you sometimes may need consistent
> memory.]
> >In other words, you _will_ loose information in this case, guaranteed.
> >I'd rather keep our existing pci_* API than be forced into this crap
> >again.
> 
> 	All of the proposed API variants that we have discussed in
> this thread for pci_alloc_consistent / dma_malloc give you consistent
> memory (or fail) unless you specifically tell it that returning
> inconsistent memory is OK.

How does a driver writer determine if his driver can cope with inconsistent
memory?  If their view is a 32-byte cache line, and their descriptors are
32 bytes long, they could well say "we can cope with inconsistent memory".
When 64 byte cache lines are the norm, the driver magically breaks.

I think we actually want to pass the minimum granularity the driver can
cope with if we're going to allocate inconsistent memory.  A driver
writer does not have enough information to determine on their own
whether inconsistent memory is going to be usable on any architecture.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

