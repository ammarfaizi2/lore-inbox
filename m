Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbUBYFpi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 00:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbUBYFpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 00:45:38 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:35748 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262623AbUBYFpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 00:45:36 -0500
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
From: Albert Cahalan <albert@users.sf.net>
To: David Ford <david+powerix@blue-labs.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <403C2E56.2060503@blue-labs.org>
References: <403C014F.2040504@blue-labs.org>
	 <1077674048.10393.369.camel@cube>  <403C2E56.2060503@blue-labs.org>
Content-Type: text/plain
Organization: 
Message-Id: <1077679677.10393.431.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Feb 2004 22:27:57 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-25 at 00:10, David Ford wrote:

> I can see if a process long in the past would have a different time set 
> on it, but shouldn't the entry in /proc coincide with the system clock 
> that date is accessing?  Or how many different "clocks" does the kernel 
> have going?

There are way too many clocks, none of which are good.

> Actually, it seems that there is a -significant- time difference in this 
> phantom clock now, I suspended my notebook to bring it home from the 
> station, and now this time difference is greater than 9 minutes.  I 
> suspect it's roughly 46 seconds plus the amount of time that my notebook 
> was suspended.  Yes, I'm running ntpd.
> 
> root     16894  0.0  0.0  1544  484 pts/3    S    Feb24   0:00 grep grep ps
> Wed Feb 25 00:09:09 EST 2004

OK, this is pointing right at the problem.

Linux does not record process start times at all.
Instead, it records the number of clock ticks
from boot until the process starts.

Either the boot time or current time is real.
The other may be computed from the uptime, which
may be measured in clock ticks.

The clock doesn't tick when your laptop sleeps.
I seem to recall recent changes to the way the
boot time in /proc/stat gets reported. In any
case, a sleeping laptop suggests some interesting
questions about process run times.

Here's another one to make you scream: Linux does
not supply real %CPU data.


