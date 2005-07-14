Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVGNULy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVGNULy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 16:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbVGNUJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 16:09:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30858 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261706AbVGNUIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 16:08:04 -0400
Date: Thu, 14 Jul 2005 13:06:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Arjan van de Ven <arjan@infradead.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <20050714200926.C10410@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0507141302210.19183@g5.osdl.org>
References: <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>
 <20050714005106.GA16085@taniwha.stupidest.org>
 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org> <1121304825.4435.126.camel@mindpipe>
 <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org> <1121326938.3967.12.camel@laptopd505.fenrus.org>
 <20050714121340.GA1072@ucw.cz> <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>
 <1121360561.3967.55.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0507141010530.19183@g5.osdl.org>
 <20050714200926.C10410@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Jul 2005, Russell King wrote:
> 
> Umm.  Except, according to your description of what it's supposed to
> do, the above code can have an accumulating error.

No. It can have a local drift, but the point is, the error never gets 
worse - it _stays_ local.

There's no point in polling twice in immediate succession just because a 
sleep overslept. That's like a security guard testing each door twice for 
being locked, just because he overslept one round. Pointless.

But what matters is that you don't let your local errors accumulate into 
the big picture.

Now, if somebody wants to make nicer helper functions so that you can say

	timeout = ms_from_now(500);

or something instead of saying "timeout = jiffies + HZ/2", then hey, go 
wild. At that point it's just syntactic sugar, and maybe it's worth it.

		Linus
