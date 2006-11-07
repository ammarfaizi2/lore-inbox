Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754099AbWKGIXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099AbWKGIXc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 03:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754107AbWKGIXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 03:23:32 -0500
Received: from www.osadl.org ([213.239.205.134]:414 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1754099AbWKGIXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 03:23:31 -0500
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required)
	[2.6.18-rc4-mm1]
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Len Brown <lenb@kernel.org>, Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061107080733.GB9910@elte.hu>
References: <20061101140729.GA30005@rhlx01.hs-esslingen.de>
	 <1162830033.4715.201.camel@localhost.localdomain>
	 <20061106205825.GA26755@rhlx01.hs-esslingen.de>
	 <200611070141.16593.len.brown@intel.com>  <20061107080733.GB9910@elte.hu>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 09:25:35 +0100
Message-Id: <1162887935.4715.349.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-07 at 09:07 +0100, Ingo Molnar wrote:
> * Len Brown <len.brown@intel.com> wrote:
> 
> > So given that C3 on every known system that has shipped to date breaks 
> > the LAPIC timer (and apparently this applies to C2 on these AMD 
> > boxes), dynticks needs a solid story for co-existing with C3.
> 
> check out 2.6.19-rc4-mm2: it detects this breakage and works it around 
> by using the PIT as a clock-events source. That did the trick on my 
> laptop which has this problem too. I agree with you that degrading the 
> powersaving mode is not an option.

Andreas tested with the latest -mm1-hrt-dyntick patches, so he has all
the checks already. The thing which worries me here is, that we detect
the breakage and use the fallback path already, but it still has this
weird effect on that system, while others just work fine. I'm cooking a
more brute force fallback right now.

	tglx


