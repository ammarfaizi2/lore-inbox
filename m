Return-Path: <linux-kernel-owner+w=401wt.eu-S1161205AbXAHKZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161205AbXAHKZF (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 05:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161204AbXAHKZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 05:25:05 -0500
Received: from mail.macqel.be ([194.78.208.39]:26149 "EHLO mail.macqel.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161205AbXAHKZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 05:25:04 -0500
Date: Mon, 8 Jan 2007 11:25:01 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: RTC subsystem and fractions of seconds
Message-ID: <20070108102501.GA11993@ingate.macqel.be>
References: <200701051949.00662.david-b@pacbell.net> <20070107101449.GA24163@ingate.macqel.be> <200701071810.30310.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701071810.30310.david-b@pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 06:10:30PM -0800, David Brownell wrote:

> > One usefull addition for my needs and with a m41t81 is the support of
> > the calibration of the rtc.  However this can perhaps be hidden in the
> > .set_mmss function.
> 
> Doesn't seem like an set_mmss() mechanism at all.  Some drivers give
> sysfs access to an oscillator "trim" mechanism.  What tools do you
> have which track how far off that crystal is?

ntp, either from network or from a radio-clock

and using set_mmss for that purpose seems not so disgusting, because :

- writing to the clock (the expected work of set_mmss) must be disabled when
we observe the clock drift
- set_mmss is always called with a very good precision, so one could
use the time given to set_mmss to compare it to the time given by the RTC
over a long enough period of time (more than 11 minutes) to compute the RTC's
drift and the necessary adjustment.

Of course, if we want something that is not based on ntp, then we may not
overload set_mmss.

Philippe
