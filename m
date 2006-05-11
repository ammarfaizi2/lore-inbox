Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWEKKFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWEKKFd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 06:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWEKKFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 06:05:33 -0400
Received: from mail.bmlv.gv.at ([193.171.152.37]:18655 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id S1751224AbWEKKFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 06:05:32 -0400
From: "Ph. Marek" <philipp.marek@bmlv.gv.at>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Date: Thu, 11 May 2006 12:05:52 +0200
User-Agent: KMail/1.9.1
Cc: Matt Mackall <mpm@selenic.com>, "David S. Miller" <davem@davemloft.net>,
       tytso@mit.edu, mrmacman_g4@mac.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <20060506.170810.74552888.davem@davemloft.net> <20060508140500.GZ15445@waste.org> <20060508172111.GA5266@ucw.cz>
In-Reply-To: <20060508172111.GA5266@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605111205.53192.philipp.marek@bmlv.gv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 May 2006 19:21, Pavel Machek wrote:
> Hi!
>
> > > What do other platforms without a TSC do?
> >
> > Using get_cycles() for /dev/random is new as of 2.6. Before that, we
> > were directly calling rdtsc on x86 alone. 10msec resolution is fine
> > for plenty of sources.
>
> For what devices are timestamps still 'random/unobservable' in 10msec
> range?
>
> Maybe keyboard... but no, keyboard has autorepeat and can be observed
> remotely with 10msec accuracy in many cases. (telnet to bbs?)
>
> Disk requests take less than 10msec.
>
> It is trivial to measure packets with 10msec accuracy.
>
> Mouse will generate many events within 10msec when user actually uses
> it.
>
> ...so, what devices are still random with 10msec sampling?
There may be no devices with randomness in 10msec ...

... but how about the *count* of events during 10msec?

Keyboard presses may be observable from outside, but disk accesses, network 
interrupts, mouse moves etc. .... especially if the (outside) accesses have 
to be correlated to the (internal) timer interrupt.

Get the count of events in 10msec, take the lowest bit. In 1.28 seconds you'll 
get your 128bit key.

Or, to be conservative, take only the XOR of 8 consecutive bits ... then 
you'll have to wait 10 seconds, but will be a bit more secure.

Such a mechanism could even be used on machines with TSC ... just do an 
(non-locked) increment of some counter, reset it on every jiffie, and take a 
bit of entropy.


How about that?



Regards,

Phil
