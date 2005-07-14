Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVGNMNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVGNMNy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 08:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVGNMNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 08:13:53 -0400
Received: from styx.suse.cz ([82.119.242.94]:38565 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261214AbVGNMNs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 08:13:48 -0400
Date: Thu, 14 Jul 2005 14:13:40 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050714121340.GA1072@ucw.cz>
References: <d120d50005071312322b5d4bff@mail.gmail.com> <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org> <20050713211650.GA12127@taniwha.stupidest.org> <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org> <20050714005106.GA16085@taniwha.stupidest.org> <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org> <1121304825.4435.126.camel@mindpipe> <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org> <1121326938.3967.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121326938.3967.12.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 09:42:18AM +0200, Arjan van de Ven wrote:

> > IOW, nothing ever sees any "variable frequency", and there's never any 
> > question about what the timer tick is: the timer tick is 2kHz as far as 
> > everybody is concerned. It's just that the ticks sometimes come in 
> > "bunches of 20".
> 
> btw we can hide all of this a lot nicer from just about the entire
> kernel by reducing the usage of both HZ and jiffies in drivers/non
> platform code. That isn't hard; msleep() is a good step forward there
> already; the next step is a nicer api for add_timer/mod_timer that is
> both relative and in miliseconds; with those 2 the majority of code that
> has "knowledge" about this shrinks to near zero. Once we have that the
> actual implementation of this in the background matters a whole lot
> less.
 
A note on the relaive timer API: There needs to be a way to say
"x milliseconds from the time this timer should have triggered" instead
of "x milliseconds from now", to avoid skew in timers that try to be
strictly periodic.

But other than that - such an API would be a great thing for drivers.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
