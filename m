Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275533AbTHSGyK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 02:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275569AbTHSGyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 02:54:10 -0400
Received: from tomts10.bellnexxia.net ([209.226.175.54]:27277 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S275533AbTHSGyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 02:54:06 -0400
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
From: Eric St-Laurent <ericstl34@sympatico.ca>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F41B43D.6000706@cyberone.com.au>
References: <1061261666.2094.15.camel@orbiter>
	 <3F419449.4070104@cyberone.com.au> <1061266033.2900.43.camel@orbiter>
	 <3F41B43D.6000706@cyberone.com.au>
Content-Type: text/plain
Message-Id: <1061276043.6974.33.camel@orbiter>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 19 Aug 2003 02:54:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, if you give low priority processes bigger timeslices than high prio
> ones, the low priority processes will be allowed to consume more CPU than
> high. Obviously not the intended result. I agree with your intended result,

Thanks for the crystal clear explanation.

that 'switched-arrays timeslice distribution' is good for fairness but
maybe it add unwanted scheduling latency to a high priority task that
sit with it's timeslice expired...

i know it's more a real-time os thing, but i always liked the concept of
pure priority scheduling with priority boost (calculated from aging) to
prevent starvation. in a multi-level feedback queue scheduler, a
processor share percentile could be assigned to each priority level.
anyway i'm sure there is some proven fair-share scheduling algos out
there that's better than this old stuff.

> I don't think you need that much grainularity. Might be a benefit though.

personally, i not a fan of the jiffies/tick concept; conversions, lost
ticks problems, drifts, sub-tick high-res-posix-timers etc. everything 
should use the highest resolution timer/counter in the system (TSC, ACPI
PM counter, ...) directly. it's a major cleanup and many old PCs don't
have the newer timers.

> >- lastly, it may be usefull to better encapsulate the scheduler to ease
> >adding alternative scheduler, much like the i/o schedulers work...

Well, i was looking at TimeSys scheduler, trying something like that in
2.6 requires modifications to many files and it's a PITA to maintain a
diff with frequents kernel releases. having a structure in place to
plug-in other schedulers sure helps.

Eric St-Laurent


