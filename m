Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262701AbVGMTyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbVGMTyn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbVGMTyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:54:38 -0400
Received: from kanga.kvack.org ([66.96.29.28]:1737 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S262711AbVGMTww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:52:52 -0400
Date: Wed, 13 Jul 2005 15:53:49 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       David Lang <david.lang@digitalinsight.com>,
       Bill Davidsen <davidsen@tmr.com>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Lee Revell <rlrevell@joe-job.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050713195349.GE26172@kvack.org>
References: <200507122239.03559.kernel@kolivas.org> <200507122253.03212.kernel@kolivas.org> <42D3E852.5060704@mvista.com> <20050712162740.GA8938@ucw.cz> <42D540C2.9060201@tmr.com> <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz> <20050713184227.GB2072@ucw.cz> <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org> <20050713193540.GD26172@kvack.org> <20050713194115.GA2272@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713194115.GA2272@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 09:41:15PM +0200, Vojtech Pavlik wrote:
> The RTC historically used to have a lower quality (cheaper) crystal than
> the 14.318 MHz crystal used for everything else. But with the spread
> spectrum modulation of frequency, the PIT may finally be worse to
> consider the RTC again.

32.768kHz crystals are pretty much standard for use in digital clocks.  
Checking an electronics catalogue shows a fairly reasonable -60ppm to 
+30ppm rating over the operating temperature range (implying the device 
is tuned for 20C room temperature).

> Another BIG problem with RTC is that it doesn't allow reading its
> internal counter like the PIT does, making TSC interpolation even harder.

That's one thing I truely dislike about the current timer code.  If we 
could program the RTC interrupt to come into the system as an NMI (iirc 
oprofile already has code to do this), we could get much better TSC 
interpolation since we would be sampling the TSC at a much smaller, less 
variable offset, which can only be a good thing.

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
