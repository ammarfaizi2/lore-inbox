Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbSLFCeU>; Thu, 5 Dec 2002 21:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbSLFCeU>; Thu, 5 Dec 2002 21:34:20 -0500
Received: from holomorphy.com ([66.224.33.161]:33677 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261368AbSLFCeT>;
	Thu, 5 Dec 2002 21:34:19 -0500
Date: Thu, 5 Dec 2002 18:41:40 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, Norman Gaywood <norm@turing.une.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021206024140.GL9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
	Norman Gaywood <norm@turing.une.edu.au>,
	linux-kernel@vger.kernel.org
References: <20021206111326.B7232@turing.une.edu.au> <3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random> <3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random> <20021206021559.GK9882@holomorphy.com> <20021206022853.GJ1567@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021206022853.GJ1567@dualathlon.random>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 06:15:59PM -0800, William Lee Irwin III wrote:
>> Admission control for fallback is valuable, sure. I suspect the
>> question akpm raised is about memory utilization. My own issues are
>> centered around allocations targeted directly at ZONE_NORMAL,
>> which fallback prevention does not address, so the watermark patch
>> is not something I'm personally very concerned about.

On Fri, Dec 06, 2002 at 03:28:53AM +0100, Andrea Arcangeli wrote:
> you must be very concerned about it too.
> If you don't have the fallback prevention all your efforts around the
> allocations targeted directoy zone normal will be completely worthless.
> Either that or you want to drop ZONE_NORMAL enterely because it means
> nothing uses zone-normal dynamically anymore (ZONE_NORMAL seen as a
> place that is directly mapped, not necessairly always 32bit dma
> capable).

Yes, it's necessary; no, I've never directly encountered the issue it
fixes. Sorry about the miscommunication there.


On Thu, Dec 05, 2002 at 06:15:59PM -0800, William Lee Irwin III wrote:
>> 64GB isn't getting any testing that I know of; I'd hold off until
>> someone's actually stood up and confessed to attempting to boot
>> Linux on such a beast. Or until I get some more RAM. =)

On Fri, Dec 06, 2002 at 03:28:53AM +0100, Andrea Arcangeli wrote:
> 64GB is an example, a good example for this thing, but a 16G machine or
> a 4G machine can run in the very same issues. As said just swapoff -a
> and malloc(1G) and such 1G is all ZONE_NORMAL before you could allocate
> enough inodes for your workload. Or alloc 1G of pagetables by setting
> everything protnone, and sugh 1G of pagetables goes in zone-normal
> because the highmem is filled by cache. Choose whatever is your
> preferred example of real life bug fixed by the lowmem-reservation patch
> that is absolutely necessary to run stable on a big box with normal zone
> and highmem (not only a 64G box).
> The only place where you must not be concerned about these fixes are the
> 64bit archs.

64GB on 32-bit is in the territory where it's dead, either literally,
performance-wise, or by virtue of dropping hardware on the floor (as
it's basically no longer 64GB) due to deeper design limitations.

No idea why there's not more support behind or interest in page
clustering. It's an optimization (not required) for 64-bit/saner arches.


Bill
