Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263133AbTHZHiT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 03:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263284AbTHZHiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 03:38:19 -0400
Received: from almesberger.net ([63.105.73.239]:49928 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S263133AbTHZHiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 03:38:17 -0400
Date: Tue, 26 Aug 2003 04:38:02 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tasklet_kill will always hang for recursive tasklets on a UP
Message-ID: <20030826043802.D1212@almesberger.net>
References: <20030826024808.B3448@almesberger.net> <Pine.LNX.4.44.0308260010480.31955-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308260010480.31955-100000@localhost.localdomain>; from nagendra_tomar@adaptec.com on Tue, Aug 26, 2003 at 12:15:58AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nagendra Singh Tomar wrote:
> I fail to understand this. How can we say that its not a bug. If we 
> support recursive tasklets, we should support killing them also. If we can 
> do it why not do it. Is there any reason for that.

It's just a question of how you define "to kill" :-) But the
naming is ambiguous, because people may indeed expect
tasklet_kill to work like kill(2).

Obviously, tasklet_kill could set a flag that prevents a
tasklet from rescheduling itself. But then you'd change
the semantics of tasklet_schedule, and in many cases, you'd
still need some flag to tell you what has happened.

Example: if a tasklet allocates some resources, and frees
them when running the next time, you'd need a flag that
tells the caller(s) of tasklet_kill whether there are
still such resources that need freeing.

The current mechanism makes sure that the tasklet will
execute one last time, if scheduled before tasklet_kill.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
