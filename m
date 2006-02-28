Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbWB1WA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWB1WA4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 17:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWB1WA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 17:00:56 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:63400 "EHLO
	mail1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S932521AbWB1WAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 17:00:55 -0500
Date: Tue, 28 Feb 2006 17:00:54 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Abdulla Bubshait <darkray@ic3man.com>
Cc: Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: AMD64 X2 lost ticks on PM timer
Message-ID: <20060228220054.GC23330@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Abdulla Bubshait <darkray@ic3man.com>,
	Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org
References: <200602280022.40769.darkray@ic3man.com> <20060227222152.GA26541@ti64.telemetry-investments.com> <Pine.LNX.4.61.0602271744270.31386@dhcp83-105.boston.redhat.com> <200602281041.27960.darkray@ic3man.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602281041.27960.darkray@ic3man.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 10:41:27AM +0300, Abdulla Bubshait wrote:
> Unfortunately, I can't seem to find a way to force it to use hpet. Passing 
> 'notsc' and 'nopmtimer' I end up using PIT/TSC based timekeeping. TSC is 
> already known to have problems with dual core. But I will sit with it for a 
> while to see if it fairs better than the pm timer.
> 
> Bill, What timer do you use, and do these lost ticks persist after sata_nv 
> interrupts stop?

Sorry for the late reply.  I'm using pmtimer (the default).  I
get lost ticks reported mostly in default_idle and __do_softirq.

The machine is running PostgreSQL, so the Lost tick messages occur
throughout the day, but they come frequently during our nightly cron
jobs that do rsyncs, checksums, etc. So far today:

rugolsky@ti88: awk '/Feb 28.*Lost.*timer/{n++;sum+=$8};END{printf "%d messages, %d lost ticks\n",n,sum}' /var/log/messages
487 messages, 588 lost ticks

And this month:

rugolsky@ti88: awk '/Feb .*Lost.*timer/{n++;sum+=$8};END{printf "%d messages, %d lost ticks\n",n,sum}' /var/log/messages*
19051 messages, 23794 lost ticks

I got another test machine up and running today, so I can start patching and
testing tomorrow.

	Bill Rugolsky
