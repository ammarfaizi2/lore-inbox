Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbTDHT6y (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 15:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbTDHT6y (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 15:58:54 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:4592 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S261702AbTDHT6u (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 15:58:50 -0400
Date: Tue, 8 Apr 2003 22:19:45 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Antonio Vargas <wind@cocodriloo.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>,
       frankeh@optonline.net, nagar.us.ibm.com@elinux01.watson.ibm.com
Subject: Re: fairsched + O(1) process scheduler
Message-ID: <20030408201945.GB21496@wind.cocodriloo.com>
References: <20030401125159.GA8005@wind.cocodriloo.com> <200304041453.16630.frankeh@watson.ibm.com> <20030404213646.GD15864@wind.cocodriloo.com> <200304081456.34367.frankeh@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304081456.34367.frankeh@watson.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 02:56:34PM -0400, Hubertus Franke wrote:
> 
> Antonio, while you are coding here is some additional input.

Great!
 
> By intoducing the user based pending queue and leaking
> the tasks back into the runqueue based on the per user ticks, you
> are changing semantics slightly.
> 
> If the task is reinserted back into the runqueue oit should be 
> reinserted into the expired queue iff and only no
> expired/active queue switch has happened. 
> Otherwise it should be reinserted into the active list.

This sounds right :)
 
> This will becoe important when we later distinguish between
> users that have limited share and those that have unlimited.

Yes, we should push the "p->user->uid == 0" test into the
send_task_to_user() function then... and later on implement
a "p->user->unlimited_cpu_share == 1" test.
 
> Can be implemented by keeping a per runqueue array switch count
> and store it with the pending task. On reinsertion, if 
> the task has the same as the current it goes to the expired.
> If its older than the current, then the task missed the array switch
> and it should go into the active queue.
> 
> Also, I don't follow necessarily your reason to put an INTERACTIVE
> task back on the active queue immediately, rather than going first
> through the pending queue again.
> 
> This way, a high priority job with even a small sleep_avg already being 
> declared INTERACTIVE, will continue to suck up cycles beyond its
> user's limits. This can be as long as 8 secs currently.

Perhaps I'm not declaring this in any explicit way, but I feel
that this type of control should only be applied to cpu hogs.

> Instead, things to consider is to feed these as well through the 
> pending queue and distinguish in the pending queue ?
> More thoughts required here... I let you know when any of them is
> successful at my end.

I'm somewhat deadlocked right now, so I'll have to wait until I have
some think up some way to make it work as intended.
 
Greets, Antonio
