Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266109AbUAQUKG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 15:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266112AbUAQUKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 15:10:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32184 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266109AbUAQUKD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 15:10:03 -0500
Date: Sat, 17 Jan 2004 20:10:00 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: David Woodhouse <dwmw2@infradead.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] kill sleep_on
Message-ID: <20040117201000.GL21151@parcelfarce.linux.theplanet.co.uk>
References: <40098251.2040009@colorfullife.com> <1074367701.9965.2.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074367701.9965.2.camel@imladris.demon.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 17, 2004 at 07:28:21PM +0000, David Woodhouse wrote:
> On Sat, 2004-01-17 at 19:43 +0100, Manfred Spraul wrote:
> > Virtually all sleep_on / interruptible_sleep_on users are racy. Actually
> > there is only one safe case: if both wakeup and sleep happen under
> > lock_kernel.
> > Any objections against killing it entirely? Or what about marking it as
> > deprecated, as the first step towards killing it?
> > 
> > I'll follow with two patches that remove it from shaper and sunrpc/sched
> > - shaper is racy, rpciod_down is only safe if called with lock_kernel.
> 
> Deprecate it in 2.7.0 and add BUG_ON(BKL not held) to it. Not before
> time.

We need to remove racy uses anyway - that can't wait for 2.7.  And I really
wonder if there will be anything left after that - right now only reiserfs
uses look like something that might be not immediately broken.

AFAICS, _all_ uses of sleep_on() in drivers are broken in one way or another
and BKL won't help them.
