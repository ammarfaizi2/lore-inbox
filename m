Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWAaRhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWAaRhF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 12:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWAaRhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 12:37:05 -0500
Received: from tim.rpsys.net ([194.106.48.114]:43405 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751294AbWAaRhD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 12:37:03 -0500
Subject: Re: [PATCH 4/11] LED: Add LED Timer Trigger
From: Richard Purdie <rpurdie@rpsys.net>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060131150101.GX18336@lug-owl.de>
References: <1138714882.6869.123.camel@localhost.localdomain>
	 <1138714898.6869.129.camel@localhost.localdomain>
	 <20060131150101.GX18336@lug-owl.de>
Content-Type: text/plain
Date: Tue, 31 Jan 2006 17:36:56 +0000
Message-Id: <1138729017.6869.219.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-31 at 16:01 +0100, Jan-Benedict Glaw wrote:
> On Tue, 2006-01-31 13:41:37 +0000, Richard Purdie <rpurdie@rpsys.net> wrote:
> > +static void led_timer_setdata(struct led_device *led_dev, unsigned long duty, unsigned long frequency)
> > +{
> > +	struct timer_trig_data *timer_data = led_dev->trigger_data;
> > +	signed long duty1;
> > +
> > +	if (frequency > 500)
> > +		frequency = 500;
> 
> Why? 

We're dealing with msec delays. Any frequency > 1000 will just cause
problems. There was a reason for using half that but it escapes me and
might be unneeded now. 500Hz/1000Hz is above the frequency the human eye
can see so is unlikely to present a problem.

> ...and especially: why, without complaining?

This is the important bit. It should return an -EINVAL back to
userspace.

> > +	if (duty > 100)
> > +		duty = 100;
> 
> Dito.

Duty cycles > 100 make no sense and would break the subsequent
calculation. Same problem/solution as above.

Thanks,

Richard


