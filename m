Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263395AbVBDUMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263395AbVBDUMY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVBDUE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:04:29 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:13240 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S265326AbVBDUCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:02:20 -0500
Date: Fri, 4 Feb 2005 21:02:38 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       keith maanthey <kmannth@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: i386 HPET code
Message-ID: <20050204200238.GA5510@ucw.cz>
References: <88056F38E9E48644A0F562A38C64FB6003EA715C@scsmsx403.amr.corp.intel.com> <20050203213026.GF3181@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050203213026.GF3181@wotan.suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 10:30:26PM +0100, Andi Kleen wrote:
> On Thu, Feb 03, 2005 at 06:28:27AM -0800, Pallipadi, Venkatesh wrote:
> > 
> > Hi John, Andrew,
> > 
> > 
> > Can you check whether only the following change makes the problem go
> > away. If yes, then it looks like a hardware issue.
> > 
> > >	hpet_writel(hpet_tick, HPET_T0_CMP);
> > >+	hpet_writel(hpet_tick, HPET_T0_CMP); /* AK: why twice? */
> 
> 
> Ask Vojtech (cced), he wrote the x86-64 HPET code.

It took me a while to remember, but:
 
The first write after writing TN_SETVAL to the config register sets the
counter value, the second write sets the threshold. 

When you only do the first write you never set the threshold and
interrupts won't be generated properly.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
