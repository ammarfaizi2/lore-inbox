Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbUKCAcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbUKCAcP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbUKCA17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 19:27:59 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:48882 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262440AbUKCA1V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 19:27:21 -0500
Subject: Re: 2.6.8 Thinkpad T40, clock running too fast
From: john stultz <johnstul@us.ibm.com>
To: Shawn Willden <shawn-lkml@willden.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200411021703.43453.shawn-lkml@willden.org>
References: <200411021551.53253.shawn-lkml@willden.org>
	 <1099436816.9139.28.camel@cog.beaverton.ibm.com>
	 <200411021703.43453.shawn-lkml@willden.org>
Content-Type: text/plain
Message-Id: <1099441631.9139.36.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 02 Nov 2004 16:27:11 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-02 at 16:03, Shawn Willden wrote:
> On Tuesday 02 November 2004 04:06 pm, john stultz wrote:
> > Does this go away if you disable cpufreq in your kernel config?
> 
> I'll try that next.

Thanks, do let me know if it helps or not.

> > Also, looking at /proc/interrupts, does it look like you're getting more
> > then ~1000 interrupts per second?
> 
> I don't think so.  I'm not sure how to tell.  Running the following:
> 
> prev=0
> while true; do
>     cur=`cat /proc/interrupts| grep timer|cut -d' ' -f 6`
>     (( diff = $cur - $prev ))
>     echo $diff; prev=$cur
>     sleep 1
> done 
> 
> gives interrupt count differences that are between 1003 and 1222 per (rough) 
> second.  The mean is 1016 with a std deviation of 16.  Running the same thing 
> on another machine -- one without clock problems -- yields similar values.
> 
> Is there a better way to measure this?

Not really, the problem is that the sleep call returns after so many
timer ticks, so even if the wrong amount of time has passed, you'll see
the same number of interrupts. It would be best if you checked the time
on your watch, waited 5 minutes and checked again, or better, did
something similar w/ ntpdate.  I just wanted to eyeball it to make sure
you weren't running away w/ way too many timer interrupts. 

thanks
-john

PS: If you wouldn't mind, CC me next time.

