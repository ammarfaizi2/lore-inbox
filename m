Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbVLFH1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbVLFH1E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 02:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbVLFH1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 02:27:04 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:25247 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751431AbVLFH1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 02:27:03 -0500
Date: Tue, 6 Dec 2005 08:27:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/13] Time: Reduced NTP Rework (part 2)
Message-ID: <20051206072708.GA25129@elte.hu>
References: <4390E48E.4020005@mvista.com> <4395475C.21877.29399CFE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4395475C.21877.29399CFE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ulrich Windl <ulrich.windl@rz.uni-regensburg.de> wrote:

> > I'm thinking about moving the leap second handling to a timer, with the 
> > new timer system it would be easy to set a timer for e.g. 23:59.59 and 
> > then set the time. This way it would be gone from the common path and it 
> > wouldn't matter that much anymore whether it's used or not.
> 
> Will the timer solution guarantee consistent and exact updates?

it would still be dependent on system-load situations. It's an 
interesting idea to use a timer for that, but there is no strict 
synchronization between "get time of day" and "timer execution", so any 
timer-based leap-second handling would be fundamentally asynchronous. I 
dont think we want that, leap second handling should be a synchronous 
property of 'time'.

i think the very first step should be the cleanups i did to the NTP 
portions of timer.c. That made all the code (including leap second 
handling) more readable. I think a portion of the inner desire to 
rewrite the NTP code comes from the current spaghetti that accumulated 
over the years.

	Ingo
