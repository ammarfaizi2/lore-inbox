Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTEYR7g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 13:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbTEYR7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 13:59:36 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:50153 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S261651AbTEYR7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 13:59:35 -0400
Date: Sun, 25 May 2003 19:31:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] fix do_fork() return value
Message-ID: <20030525173119.GA26077@elf.ucw.cz>
References: <20030520024801.535E02C002@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030520024801.535E02C002@lists.samba.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> # Noticed by Julie DeWandel <jdewand@redhat.com>.
> # 
> # do_fork() needs to return the pid (or error), not the pointer to the
> # resulting process structure.  The process structure may not even be
> # valid any more, since do_fork() has already woken the process up (and as
> # a result it might already have done its thing and gone away).
> # 
> # Besides, doing it this way cleans up the users, which all really just
> # wanted the pid or error number _anyway_.
> 
> Just FYI: the change was done in the first place to allow spawning a
> new init thread as CPUs come up.  But now we have copy_process it can
> be done neatly (it should also be done out of keventd so we get a
> clean thread, but that's another story).
> 
> Note that this version also has a (theoretical) race, except hidden
> by the time to wrap PIDs ie. "never happens".

We have more such wrappers. IIRC, it is possible to go into
/proc/PID/something, and just stay there, kill the process, and wait
for PIDs to wrap around, fun stuff happens...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
