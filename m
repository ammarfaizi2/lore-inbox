Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVAYHji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVAYHji (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 02:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVAYHji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 02:39:38 -0500
Received: from one.firstfloor.org ([213.235.205.2]:51676 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261855AbVAYHjd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 02:39:33 -0500
To: Steve Lord <lord@xfs.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Mel Gorman <mel@csn.ul.ie>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [PATCH] Avoiding fragmentation through different allocator
References: <20050120101300.26FA5E598@skynet.csn.ul.ie>
	<20050121142854.GH19973@logos.cnet>
	<Pine.LNX.4.58.0501222128380.18282@skynet>
	<20050122215949.GD26391@logos.cnet>
	<Pine.LNX.4.58.0501241141450.5286@skynet>
	<20050124122952.GA5739@logos.cnet> <1106585052.5513.26.camel@mulgrave>
	<41F55EE1.5090702@xfs.org>
From: Andi Kleen <ak@muc.de>
Date: Tue, 25 Jan 2005 08:39:31 +0100
In-Reply-To: <41F55EE1.5090702@xfs.org> (Steve Lord's message of "Mon, 24
 Jan 2005 14:47:29 -0600")
Message-ID: <m1mzuyt0ss.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord <lord@xfs.org> writes:
>
> I realize this is one data point on one end of the scale, but I
> just wanted to make the point that there are cases where it
> does matter. Hopefully William's little change from last
> year has helped out a lot.

There are more datapoints: 

e.g. performance on megaraid controllers (very popular because a big
PC vendor ships them) was always quite bad on Linux. Up to the point
that specific IO workloads run half as fast on a megaraid compared to
other controllers. I heard they do work better on Windows.

Also I did some experiments with coalescing SG lists in the Opteron IOMMU
some time ago. With a MPT fusion controller and forcing all SG lists
through the IOMMU so that the SCSI controller always only contiguous mappings
I saw ~5% improvement on some IO tests.

Unfortunately there are some problems that doesn't allow to enable
this unconditionally. But it gives strong evidence that MPT Fusion prefers
shorter SG lists too.

So it seems to be worthwhile to optimize for shorter SG lists.

Ideally the Linux IO patterns would look similar to the Windows IO patterns,
then we could reuse all the optimizations the controller vendors
did for Windows :)
 
-Andi
