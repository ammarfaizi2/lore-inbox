Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314274AbSECPct>; Fri, 3 May 2002 11:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314330AbSECPcs>; Fri, 3 May 2002 11:32:48 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:3771 "EHLO mail3.aracnet.com")
	by vger.kernel.org with ESMTP id <S314274AbSECPcr>;
	Fri, 3 May 2002 11:32:47 -0400
Date: Fri, 03 May 2002 08:32:16 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>,
        Andrea Arcangeli <andrea@suse.de>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <4056172818.1020414735@[10.10.2.3]>
In-Reply-To: <20020503092426.GH24506@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Again note that nonlinear can do nothing to help you there, the
>> limitation you deal with is pci32 and the GFP API, not at all about
>> discontigmem or nonlinear. 
>
> While I don't have a particular plan to address what changes to the
> GFP API might be required to make these scenarios work, a quick thought
> is to pass in indices into a table of zones corresponding to regions of
> memory addressible by some devices and not others. It'd give rise to a
> partition like what is already present with foreknowledge of ISA DMA
> and 32-bit PCI, but there would be strange corner cases, for instance,
> devices claiming to be 32-bit PCI that don't wire all the address lines.
> I'm not entirely sure how smoothly these cases are now handled anyway.

In my mind, one possibility for a powerful API would be to specify a
mask of acceptable physical addresses, and a "state" for what kind of
mapping you wanted - global kernel permanently mapped address, unmapped
address, per-task kernel mapped address, per-address space kernel
mapped address, etc.

Without thinking about it too much (aka I'm sticking my neck out and
am going to get shot down ;-)) it would seem possible to do the phys
mask idea inside the current buddy system without too much problem
if the mask was aligned on 2^MAX_ORDER * sizeof(struct page) boundarys?
I need to think about that one some more, but I thought I'd throw it
out to see what people think ...

M.

