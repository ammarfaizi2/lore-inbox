Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265713AbUATVHj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 16:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265736AbUATVHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 16:07:38 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:46729 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265713AbUATVHg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 16:07:36 -0500
Subject: Re: limit-timer_pm-printk-storms.patch
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Bongani Hlope <bonganilinux@mweb.co.za>,
       Dominik Brodowski <linux@brodo.de>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040120115751.5e4441bc.akpm@osdl.org>
References: <20040120212514.43e31237.bonganilinux@mweb.co.za>
	 <20040120115751.5e4441bc.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1074632752.16374.52.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 20 Jan 2004 13:05:52 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-20 at 11:57, Andrew Morton wrote:
> Bongani Hlope <bonganilinux@mweb.co.za> wrote:
> >
> > This patch has been inspired by the limit-IO-error-printk-storms patch. On my PII when I enable 
> > CONFIG_X86_PM_TIMER this gets called a lot of times, I guess my VIA chipset is too broken to play with this.
> > 
> > <example>
> > ...
> > Jan 19 04:21:46 bongani kernel: bad pmtmr read: (15567390, 15567423, 15567393)
> > Jan 19 04:21:46 bongani kernel: bad pmtmr read: (1746710, 1746719, 1746713)
> > Jan 19 04:21:47 bongani kernel: bad pmtmr read: (2239982, 2239999, 2239986)
> 
> Does the PM timer actually do the right thing once these printk's are
> suppressed?

Yep, as I have no hardware affected by this issue, the debug output was
just there to confirm we were catching the cases we expected to. Looks
like its working.

> If not, it would be better to recover somehow - presumably by blacklisting
> this machine or by falling back to a different time source.  Possible?

Don't think that's necessary. We can probably #ifdef DEBUG_PMTMR the
printks.

thanks
-john


