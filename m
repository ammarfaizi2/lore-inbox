Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266170AbUAQX3u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 18:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUAQX3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 18:29:50 -0500
Received: from gprs214-97.eurotel.cz ([160.218.214.97]:36993 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266170AbUAQX3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 18:29:48 -0500
Date: Sun, 18 Jan 2004 00:29:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Valdis.Kletnieks@vt.edu
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sched-idle and disk-priorities for 2.6.X
Message-ID: <20040117232926.GC9999@elf.ucw.cz>
References: <20040116181047.GA1896@elf.ucw.cz> <200401161937.i0GJbJmv003365@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401161937.i0GJbJmv003365@turing-police.cc.vt.edu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I have some lingvistics application here that is pretty
> > demanding... it eats a lot of memory, overloads disk, and basically
> > makes system unusable for even as simple tasks as reading maillists.
> 
> > Where are lastest versions of disk-prio and sched-idle patches?
> 
> The most likely culprit here is "eats memory".  What's almost certainly
> happening is that your application is using a lot of pages, and leaving the
> system in thrashing mode.  Quite likely, "sched-idle" won't do what you want,
> as all that will happen is that the application will dirty pages while the CPU
> is otherwise idle (and cause the same problem you're seeing
> already).

Well, problem is that it takes long even to awake galeon after you
have not used it for few seconds. Disk is utilized by galeon at this
point, and disk-prio + sched-idle should guarantee that when I ask
system to do something, it will do it at max possible performance.

> A better bet would be a patch that allowed you to set the maximum RSS size for
> the process so it can basically thrash itself while leaving enough memory for
> everybody else (and yes, I *know* how this can be self-defeating if the
> thrashing app then increases the total I/O consumed to be higher than the I/O
> bandwidth available - the point is that it's probably the high RSS value for
> his application causing OTHER things to thrash that's the root cause of his
> performance problem).

Is there effective way to limit RSS?
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
