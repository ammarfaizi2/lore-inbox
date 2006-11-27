Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933078AbWK0Slo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933078AbWK0Slo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 13:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933073AbWK0Slo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 13:41:44 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:40079 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id S933156AbWK0Sln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 13:41:43 -0500
Message-ID: <456B3150.7020705@qualcomm.com>
Date: Mon, 27 Nov 2006 10:41:20 -0800
From: Max Krasnyansky <maxk@qualcomm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Robert Crocombe <rcrocomb@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] x86: unify/rewrite SMP TSC sync code
References: <e6babb600611270923h139a59ecr82af786f3aedf607@mail.gmail.com>
In-Reply-To: <e6babb600611270923h139a59ecr82af786f3aedf607@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Using gtod() can amount to a substantial disturbance of the thing to
> be measured.  Using rdtsc, things seem reliable so far, and we have an
> FPGA (accessed through the PCI bus) that has been programmed to give
> access to an 8MHz clock and we do some checks against that.

Same here. gettimeofday() is way too slow (dual Opteron box) for the
frequency I need to call it at. HPET is not available. But TSC is doing just
fine. Plus in my case I don't care about sync between CPUs (thread that uses
TSC is running on the isolated CPU) and I have external time source that takes
care of the drift.

So please no trapping of the RDTSC. Making it clear (bold kernel message during
boot :-) that TSC(s) are not in sync or unstable (from GTOD point of view) is of
course perfectly fine.

Thanx
Max
