Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262699AbVGMTna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbVGMTna (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbVGMTlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:41:44 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:55021 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262455AbVGMTlC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:41:02 -0400
Date: Wed, 13 Jul 2005 21:41:15 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       David Lang <david.lang@digitalinsight.com>,
       Bill Davidsen <davidsen@tmr.com>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Lee Revell <rlrevell@joe-job.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050713194115.GA2272@ucw.cz>
References: <20050712121008.GA7804@ucw.cz> <200507122239.03559.kernel@kolivas.org> <200507122253.03212.kernel@kolivas.org> <42D3E852.5060704@mvista.com> <20050712162740.GA8938@ucw.cz> <42D540C2.9060201@tmr.com> <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz> <20050713184227.GB2072@ucw.cz> <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org> <20050713193540.GD26172@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713193540.GD26172@kvack.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 03:35:40PM -0400, Benjamin LaHaise wrote:

> On Wed, Jul 13, 2005 at 12:10:48PM -0700, Linus Torvalds wrote:
> > Long-term time drift is a known issue, and is unavoidable since you don't 
> > even know the exact frequency of the crystal, since that is not only not 
> > that exact in the first place, it depends on temperature etc. So long-term 
> > time drift is something that we inevitably have to use things like NTP to 
> > handle, if you want an exact clock.
> 
> diz gave #kernel a good diatribe a few weeks ago about the headaches 
> associated with using the PIT as a clock source, with one of the more 
> interesting tidbits being that chipsets will pull the frequency higher 
> and lower at times in order to implement spread spectrum to comply with 
> RF emissions.  The RTC doesn't suffer from this, but it only provides 
> HZ values which are powers of two.  How bad would 256 Hz be?
 
The RTC historically used to have a lower quality (cheaper) crystal than
the 14.318 MHz crystal used for everything else. But with the spread
spectrum modulation of frequency, the PIT may finally be worse to
consider the RTC again.

Another BIG problem with RTC is that it doesn't allow reading its
internal counter like the PIT does, making TSC interpolation even harder.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
