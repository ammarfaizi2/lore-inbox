Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbUBYELw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 23:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbUBYELw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 23:11:52 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:17377 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262448AbUBYELr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 23:11:47 -0500
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
From: Albert Cahalan <albert@users.sf.net>
To: David Ford <david+challenge-response@blue-labs.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       albert@users.sourceforge.net
In-Reply-To: <403C014F.2040504@blue-labs.org>
References: <403C014F.2040504@blue-labs.org>
Content-Type: text/plain
Organization: 
Message-Id: <1077674048.10393.369.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Feb 2004 20:54:09 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-24 at 20:58, David Ford wrote:
> Kernel 2.6.3, procps 3.2.0
> 
> # while [ 1 ]; do (ps aux|grep "grep ps aux" && date) ; sleep 1; done
> root     20043  0.0  0.0  1504  456 pts/0    R    20:45   0:00 grep grep ps aux
> Tue Feb 24 20:45:25 EST 2004
> root     20062  0.0  0.0  1504  460 pts/0    S    20:45   0:00 grep grep ps aux
> Tue Feb 24 20:45:26 EST 2004
> root     20081  0.0  0.0  1504  460 pts/0    S    20:46   0:00 grep grep ps aux
> Tue Feb 24 20:45:27 EST 2004
> 
> Note the change in the timestamp as reported by 'ps' v.s. the time 
> reported by 'date'.
> 
> Repeatable every time at 26 seconds after the minute +/- a portion of a 
> second.

I'm not seeing it, with:

procps    both 3.1.8 and procps 3.2.0+
kernel    2.6.0-test11
library   glibc 2.3
hardware  uniprocessor G4 Mac
ntp       none (and you can tell by my email!)

Run "ps --info" to gather much of this data.

Note that time is a very awkward thing. You boot up,
with some incorrect clock. Then you adjust the time.
Later, you may discover that your clock has been
running too slow. So you adjust the frequency, but
what about the time that has already passed? Should
you change the boot time to represent what is now
known about your clock? What if, by doing so, you
cause some processes to have started before boot?
Then again, perhaps due to temperature change, you
discover that your clock frequency is wrong... This
is without even getting into the concept of leap
seconds, which are determined a few months in advance.

Two guesses:

1. leap seconds
2. SMP, with cycle counters out of sync


