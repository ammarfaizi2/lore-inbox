Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263921AbTF0GoM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 02:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbTF0GoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 02:44:12 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:2315 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S263921AbTF0GoK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 02:44:10 -0400
Date: Thu, 26 Jun 2003 23:54:35 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler & interactivity improvements
Message-ID: <20030627065435.GD15033@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20030623164743.GB1184@hh.idb.hist.no> <5.2.0.9.2.20030624215008.00ce73b8@pop.gmx.net> <3EFAC408.4020106@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EFAC408.4020106@aitel.hist.no>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 26, 2003 at 11:59:36AM +0200, Helge Hafting wrote:
> How about _removing_ the io-wait bonus for waiting on pipes then?
> If you wait for disk io, someone else gets to use
> the cpu for their work.  So you get a boost for
> giving up your share of time, waiting
> for that slow device.
> 
> But if you wait for a pipe, you wait for some other
> cpu hog to do the first part of _your_ work.
> I.e. nobody else benefitted from your waiting,
> so you don't get any boost either.
> 
> This solves the problem of someone artifically
> dividing up a job, using token passing
> to get unfair priority.
> 
> This can be fine-tuned a bit: We may want the pipe-waiter
> to get a _little_ bonus at times, but that has to be
> subtracted from whatever bonus the process at the
> other end of the pipe has.  I.e. no new bonus
> created, just shift some the existing bonus around.
> The "other end" may, after all, have gained legitimate
> bonus from waiting on the disk/network/paging/os, and passing
> some of that on to "clients" might make sense.
> 
> So irman and similar pipe chains wouldn't be able to build
> artifical priority, but if it get some priority
> in an "acceptable" way then it is passed
> along until it expires.
> 
> I.e. "bzcat file.bz2 | grep something | sort | less" could
> pass priority down the chain when bzcat suffers
> a long nfs wait...

You don't want to penalise pipes either.  I can just imagine
some nutcase shifting from pipes to a less efficient
communications channel to shave 5% off his run time.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
