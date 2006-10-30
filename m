Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422756AbWJ3XvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422756AbWJ3XvA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 18:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWJ3XvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 18:51:00 -0500
Received: from ns2.suse.de ([195.135.220.15]:6890 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932474AbWJ3Xu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 18:50:59 -0500
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Tue, 31 Oct 2006 00:50:51 +0100
User-Agent: KMail/1.9.5
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200610200009.k9K09MrS027558@zach-dev.vmware.com> <20061030231251.GB98768@muc.de> <454689C7.6030009@vmware.com>
In-Reply-To: <454689C7.6030009@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610310050.51912.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It doesn't happen often, but it is a possibility that the kernel 
> calibrates the delay wrong because of timing glitches caused by CPU 
> migration, paging, or other phenomena which are supposed to be 
> transparent to the kernel (but cause temporal lapse).

We're supposed to handle those because they happen on real hardware
too with long running SMM handlers. Or at least there was a effort some time ago
to do this. If it wasn't enough we'll likely need to fix the code.

> In that case, the  
> kernel may not make enough progress in a spin delay loop to properly 
> reach the number of microseconds required for N number of timer ticks to 
> occur.  

Hmm, mdelay is polling RDTSC and assumes it makes forward progress
and waits until the time that was estimated at the original TSC<->PIT
calibration passed.  While there is a spin loop it is definitely 
polling a timer that is supposed to tick properly even in virtualization.

You're saying that doesn't work on vmware? Does it have trouble
with RDTSC?

Anyways if polling against TSC doesn't work I suppose we could
change it to poll against some other timer.
 
> In theory this can happen on a real machine, as SMM mode could 
> be active, doing USB device emulation or something that takes a while 
> during the lpj calibration and throwing the computation off.

Yep.

> By changing the parameters (N ticks at K Hz in T seconds), it is easy to 
> create an unstable measurement that can achieve high failure rates, 
> although in practice the Linux parameters appear to be reasonable enough 
> that it is not a major problem.

Hmm, why exactly? 

-Andi
