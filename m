Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263895AbUHBVil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbUHBVil (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 17:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUHBVhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 17:37:05 -0400
Received: from ozlabs.org ([203.10.76.45]:31905 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263895AbUHBVgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 17:36:50 -0400
Date: Tue, 3 Aug 2004 07:32:30 +1000
From: Anton Blanchard <anton@samba.org>
To: William Lee Irwin III <wli@holomorphy.com>, sfr@ozlabs.org,
       linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: [PATCH] [ppc64] watch IOMMU virtual merging
Message-ID: <20040802213230.GP30253@krispykreme>
References: <20040802164448.GN30253@krispykreme> <20040802170843.GI2334@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802170843.GI2334@holomorphy.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> This is a rather painful state of affairs. I'm not convinced external
> fragmentation in the IOMMU address space is insurmountable as the
> physically contiguous segments can (in principle; the mechanics of
> ramming this through the IO subsystem are another matter entirely) be
> IO-mapped in a bus-discontiguous fashion.

Yep they can, but if the SG list has been sized to fit after physically
merging then we have a problem when we later on want to split it. If the
architecture had more control over the merging process we could do a
better job here.

> I'm not familiar with the TCE space regions; could you describe or
> point to documentation for the semantics there?

Think of it as a mapping from PCI to host memory, a window of at least
128MB and up to 3GB. You get to carve it up on a page granularity as you
like, we currently create 2 regions, a small allocation region and a
large one (above 15 pages).  The aim is to (hopefully) avoid
fragmentation in the large allocation region.

> My first thought is to artificially limit the amount of physical
> merging (hopefully to some nonzero amount instead of disabling it
> entirely) allowed to take place in order to allow for better virtual
> merging.

Removing the large allocation region should also fix our problems. I
should test that to verify its our problem.

Anton
