Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271742AbTHHTcB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 15:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271746AbTHHTcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 15:32:01 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:44805 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S271742AbTHHTb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 15:31:59 -0400
Subject: Re: [PATCH]O14int
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Cliff White <cliffw@osdl.org>
In-Reply-To: <200308090149.25688.kernel@kolivas.org>
References: <200308090149.25688.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1060371116.702.6.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 08 Aug 2003 21:31:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-08 at 17:49, Con Kolivas wrote:
> More duck tape interactivity tweaks
> 
> Changes
> 
> Put some bounds on the interactive_credit and specified a size beyond which a 
> task is considered highly interactive or not.
> 
> Moved the uninterruptible sleep limiting to within recalc_task_prio removing 
> one call of the sched_clock() and being more careful about the limits.
> 
> Wli pointed out an error in the nanosecond to jiffy conversion which may have 
> been causing too easy to migrate tasks on smp (? performance change).
> 
> Put greater limitation on the requeuing code; now it only requeues interactive 
> tasks thereby letting cpu hogs run their full timeslice unabated which should 
> improve cpu intensive task performance.
> 
> Made highly interactive tasks earn all their waiting time on the runqueue
> during requeuing as sleep_avg.

I have been testing this jewel on top of 2.6.0-test2-mm5 for a couple of
hours. It behaves much like O13*int, well maybe a little bit better:
Renicing X to -20 is a total disaster (sluggish window movement, Juk
skipping like mad, etc), but with X at +0 the system feels pretty good.

Evolution still feels like a mamooth when moving windows over it. XMMS
doesn't skip, neither Juk does when X is at +0. This is good :-)
All in all, this one feels good!

PS: May I say O10int is still a little bit smoother than this one? ;-)

