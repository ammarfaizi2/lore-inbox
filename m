Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVAYO41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVAYO41 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 09:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbVAYO41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 09:56:27 -0500
Received: from colin2.muc.de ([193.149.48.15]:26890 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261967AbVAYO4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 09:56:03 -0500
Date: 25 Jan 2005 15:56:02 +0100
Date: Tue, 25 Jan 2005 15:56:02 +0100
From: Andi Kleen <ak@muc.de>
To: "Mukker, Atul" <Atulm@lsil.com>
Cc: "'Steve Lord'" <lord@xfs.org>,
       "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       "'Mel Gorman'" <mel@csn.ul.ie>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'Linux Memory Management List'" <linux-mm@kvack.org>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'Grant Grundler'" <grundler@parisc-linux.org>
Subject: Re: [PATCH] Avoiding fragmentation through different allocator
Message-ID: <20050125145602.GB75109@muc.de>
References: <0E3FA95632D6D047BA649F95DAB60E5705A70E61@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E5705A70E61@exa-atlanta>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 09:02:34AM -0500, Mukker, Atul wrote:
>  
> > e.g. performance on megaraid controllers (very popular 
> > because a big PC vendor ships them) was always quite bad on 
> > Linux. Up to the point that specific IO workloads run half as 
> > fast on a megaraid compared to other controllers. I heard 
> > they do work better on Windows.
> > 
> <snip>
> > Ideally the Linux IO patterns would look similar to the 
> > Windows IO patterns, then we could reuse all the 
> > optimizations the controller vendors did for Windows :)
> 
> LSI would leave no stone unturned to make the performance better for
> megaraid controllers under Linux. If you have some hard data in relation to
> comparison of performance for adapters from other vendors, please share with
> us. We would definitely strive to better it.

Sorry for being vague on this. I don't have much hard data on this,
just telling an annecdote. The issue we saw was over a year ago
and on a machine running an IO intensive multi process stress test
(I believe it was an AIM7 variant with some tweaked workfile). When the test
was moved to a machine with megaraid controller it ran significantly
lower, compared to the old setup with a non RAID SCSI controller from
a different vendor. I unfortunately don't know anymore the exact
type/firmware revision etc. of the megaraid that showed the problem.

If you have already fixed the issues then please accept my apologies.

> The megaraid driver is open source, do you see anything that driver can do
> to improve performance. We would greatly appreciate any feedback in this
> regard and definitely incorporate in the driver. The FW under Linux and
> windows is same, so I do not see how the megaraid stack should perform
> differently under Linux and windows?

My understanding (may be incomplete) of the issue is basically what
Steve said: something in the stack doesn't like the Linux IO patterns
with often relatively long SG lists, which are longer than in some
other popular OS. This is unlikely to be the Linux driver
(drivers tend to just pass the SG lists through without too much processing),
more likely it was the firmware or something below.

-Andi
