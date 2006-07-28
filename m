Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161277AbWG1UNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161277AbWG1UNO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161267AbWG1UNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:13:13 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:40945 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161275AbWG1UNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:13:10 -0400
Subject: Re: A better interface, perhaps: a timed signal flag
From: Steven Rostedt <rostedt@goodmis.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Theodore Tso <tytso@mit.edu>, Neil Horman <nhorman@tuxdriver.com>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, jg@freedesktop.org
In-Reply-To: <1154116918.13509.162.camel@localhost.localdomain>
References: <44C67E1A.7050105@zytor.com>
	 <20060725204736.GK4608@hmsreliant.homelinux.net>
	 <44C6842C.8020501@zytor.com> <20060725222547.GA3973@localhost.localdomain>
	 <70FED39F-E2DF-48C8-B401-97F8813B988E@kernel.crashing.org>
	 <20060725235644.GA5147@localhost.localdomain> <44C6B117.80300@zytor.com>
	 <20060726002043.GA5192@localhost.localdomain>
	 <20060726144536.GA28597@thunk.org>
	 <1154093606.19722.11.camel@localhost.localdomain>
	 <20060728145210.GA3566@thunk.org>
	 <1154104885.13509.142.camel@localhost.localdomain>
	 <1154105089.19722.23.camel@localhost.localdomain>
	 <1154116918.13509.162.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 16:12:12 -0400
Message-Id: <1154117532.19722.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 21:01 +0100, Alan Cox wrote:
> Ar Gwe, 2006-07-28 am 12:44 -0400, ysgrifennodd Steven Rostedt:
> > But for real-time applications, the signal handling has a huge latency.
> 
> For real-time you want a thread. Our thread switching is extremely fast
> and threads unlike signals can have RT priorities of their own
> 

You mean to have a thread that does a nanosleep till the expected
timeout, then write some variable that the other high prio thread can
see that the timeout has expired?

Hmm, so that register_timeout can be implemented with at thread that
does a nanosleep then updates the flag.

The only problem is that the thread needs to go up to a higher priority
(perhaps the highest), which means that this can only be implemented
with special capabilities. Then again, pretty much all RT tasks are
special, and usually run with privileged capabilities.


There's also something else that would be a nice addition to the kernel
API.  A sleep and wakeup that is implemented without signals. Similar to
what the kernel does with wake_up.  That way you can sleep till another
process/thread is done with what it was doing and wake up the other task
when done, without the use of signals.  Or is there something that
already does this?

-- Steve


