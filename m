Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932785AbWKSSew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785AbWKSSew (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 13:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932792AbWKSSew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 13:34:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:5507 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932785AbWKSSew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 13:34:52 -0500
X-Authenticated: #14349625
Subject: Re: Sluggish system responsiveness on I/O
From: Mike Galbraith <efault@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Christian <christiand59@web.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1163958288.22176.82.camel@mindpipe>
References: <200611181412.29144.christiand59@web.de>
	 <1163922694.7504.42.camel@Homer.simpson.net>
	 <1163958288.22176.82.camel@mindpipe>
Content-Type: text/plain
Date: Sun, 19 Nov 2006 19:34:55 +0100
Message-Id: <1163961295.5977.53.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-19 at 12:44 -0500, Lee Revell wrote:
> On Sun, 2006-11-19 at 08:51 +0100, Mike Galbraith wrote:
> > That makes sense, I/O tasks don't generally hold the cpu for extended
> > periods, whereas a cpu bound task does.
> 
> So what can we do about I/O intensive tasks that also want a lot of CPU,
> for example, the bloatier Gnome/KDE apps?  Evolution is the worst for
> me.


Evolution has big trouble with the ext3 (and maybe others) journal.
I've _never_ seen evolution having scheduler priority problems, only
journal problems (absolutely every damn time hefty I/O is going on).

What should we do about I/O tasks that decide to use massive cpu?

IMHO, absolutely nothing beyond what ever we decide to do with any other
cpu intensvive task.  There is nothing special about scheduling I/O
heavy tasks.  If it uses massive cpu for sustained periods, it must pay
the price.  In the meantime, an I/O intensive task that decides to use
heavy cpu will round-robin at relatively high frequency with every other
"interactive" task, which may also be doing a burst of cpu heavy work.
The reason for doing that cpu intensive burst just doesn't matter.

Currently, we special case I/O tasks to limit the dynamic priority boost
they can get via I/O.  I think that is wrong.

	-Mike

