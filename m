Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262755AbVDHL4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbVDHL4Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 07:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVDHL4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 07:56:16 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:55738 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S262755AbVDHL4N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 07:56:13 -0400
Date: Fri, 8 Apr 2005 04:55:36 -0700
From: Tony Lindgren <tony@atomide.com>
To: Thomas Renninger <trenn@suse.de>
Cc: Frank Sorenson <frank@tuxrocks.com>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] Updated: Dynamic Tick version 050408-1
Message-ID: <20050408115535.GI4477@atomide.com>
References: <20050406083000.GA8658@atomide.com> <425451A0.7020000@tuxrocks.com> <20050407082136.GF13475@atomide.com> <4255A7AF.8050802@tuxrocks.com> <4255B247.4080906@tuxrocks.com> <20050408062537.GB4477@atomide.com> <20050408075001.GC4477@atomide.com> <42564584.4080606@tuxrocks.com> <42566C22.4040509@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42566C22.4040509@suse.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Renninger <trenn@suse.de> [050408 04:34]:
> 
> Here are some figures about idle/C-states:
> 
> Passing bm_history=0xF to processor module makes it going into C3 and deeper.
> Passing lower values, deeper states are reached more often, but system could freeze:

Hmm, I wonder why it freezes? Is it ACPI issue or related to dyn-tick?
 
> Figures NO_IDLE_HZ disabled, HZ=1000 (max sleep 1ms)
...
> Total switches between C-states:  20205
> Switches between C-states per second:  1063 per second
> 
> Figures NO_IDLE_HZ enabled, processor.bm_history=0xF HZ=1000:
...
> Total switches between C-states:  4659
> Switches between C-states per second:  65 per second

The reduction in C state changes should produce some power savings,
assuming the C states do something...

> I buffer C-state times in an array and write them to /dev/cstX.
> From there I calc the stats from userspace.
> 
> Tony: If you like I can send you the patch and dump prog for
> http://www.muru.com/linux/dyntick/ ?

Yeah, that would nice to have!

> I try to find a better algorithm (directly adjust slept time to
> C-state latency or something) for NO_IDLE_HZ (hints are very welcome)
> and try to come up with new figures soon.

I suggest we modify idle so we can call it with the estimated sleep
length in usecs. Then the idle loop can directly decide when to go to
C2 or C3 depening on the estimated sleep length.

Tony
