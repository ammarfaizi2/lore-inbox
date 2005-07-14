Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262915AbVGNUdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbVGNUdc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 16:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262891AbVGNUbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 16:31:45 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3858 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261645AbVGNUau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 16:30:50 -0400
Date: Thu, 14 Jul 2005 21:30:23 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050714213023.F10410@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Vojtech Pavlik <vojtech@suse.cz>, Lee Revell <rlrevell@joe-job.com>,
	dean gaudet <dean-list-linux-kernel@arctic.org>,
	Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
	"Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
	david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
	linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
	azarah@nosferatu.za.org, christoph@lameter.com
References: <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org> <1121304825.4435.126.camel@mindpipe> <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org> <1121326938.3967.12.camel@laptopd505.fenrus.org> <20050714121340.GA1072@ucw.cz> <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org> <1121360561.3967.55.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0507141010530.19183@g5.osdl.org> <20050714200926.C10410@flint.arm.linux.org.uk> <Pine.LNX.4.58.0507141302210.19183@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0507141302210.19183@g5.osdl.org>; from torvalds@osdl.org on Thu, Jul 14, 2005 at 01:06:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 01:06:00PM -0700, Linus Torvalds wrote:
> On Thu, 14 Jul 2005, Russell King wrote:
> > Umm.  Except, according to your description of what it's supposed to
> > do, the above code can have an accumulating error.
> 
> No. It can have a local drift, but the point is, the error never gets 
> worse - it _stays_ local.
> 
> There's no point in polling twice in immediate succession just because a 
> sleep overslept. That's like a security guard testing each door twice for 
> being locked, just because he overslept one round. Pointless.

That depends what you're trying to achieve.  If you're trying to achieve
an average interval of 10ms over half a second, your solution won't get
that, whereas mine will.

> But what matters is that you don't let your local errors accumulate into 
> the big picture.

Precisely - it's all about "the big picture" and what the requirements
there are.  My requirements for "once every 10ms" may be different from
yours.

An example may be best.  You need to toggle an IO output at 50Hz for
half a second but you don't care at all about the duty cycle.  You
do care about it being as close as possible 50Hz, and not 40Hz
because for whatever reason it's taking you a hypothetical (*) 2ms
latency between timer expiry either time.

(* - yes, I know we don't like that word here... 8) but I'm trying
to make a point through exaggeration, so I'm covering my ass when
someone says "but 2ms is a bloody stupid latency!".)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
