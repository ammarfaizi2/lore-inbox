Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVGQDzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVGQDzX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 23:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVGQDzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 23:55:23 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:19410 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261907AbVGQDzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 23:55:21 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: christoph@lameter.com, azarah@nosferatu.za.org, diegocg@gmail.com,
       mbligh@mbligh.org, linux-kernel@vger.kernel.org, kernel@kolivas.org,
       davidsen@tmr.com, david.lang@digitalinsight.com, vojtech@suse.cz,
       dtor_core@ameritech.net, "Brown, Len" <len.brown@intel.com>,
       Andrew Morton <akpm@osdl.org>, Chris Wedgwood <cw@f00f.org>,
       Linus Torvalds <torvalds@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>
In-Reply-To: <29495f1d0507161935218d798@mail.gmail.com>
References: <42D3E852.5060704@mvista.com>
	 <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <9a874849050714170465c979c3@mail.gmail.com>
	 <1121386505.4535.98.camel@mindpipe>
	 <Pine.LNX.4.58.0507141718350.19183@g5.osdl.org> <42D731A4.40504@gmail.com>
	 <Pine.LNX.4.58.0507142158010.19183@g5.osdl.org>
	 <9a874849050715061247ab4fd8@mail.gmail.com>
	 <9a874849050716191324d2f8b4@mail.gmail.com>
	 <29495f1d0507161935218d798@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 16 Jul 2005 23:55:17 -0400
Message-Id: <1121572518.14698.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-16 at 19:35 -0700, Nish Aravamudan wrote: 
> As you've seen, I think it depends on the timesource: for the PIT, it
> would be arch/i386/kernel/timers/timer_pit.c::setup_pit_timer().

That one looks pretty straightforward.
arch/i386/kernel/timers/timer_tsc.c really looks like fun.  So many
corner cases...

BTW shouldn't this code from mark_offset_tsc():

402         if (pit_latch_buggy) {
403                 /* get center value of last 3 time lutch */
404                 if ((count2 >= count && count >= count1)
405                     || (count1 >= count && count >= count2)) {
406                         count2 = count1; count1 = count;
407                 } else if ((count1 >= count2 && count2 >= count)
408                            || (count >= count2 && count2 >= count1)) {
409                         countmp = count;count = count2;
410                         count2 = count1;count1 = countmp;
411                 } else {
412                         count2 = count1; count1 = count; count = count1;
413                 }
414         }

use an ifdef?  It only applies to cyrix_55x0, and mark_offset_tsc is a
pretty hot path.

Lee

