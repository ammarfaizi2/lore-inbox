Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288854AbSBDKk1>; Mon, 4 Feb 2002 05:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288859AbSBDKkS>; Mon, 4 Feb 2002 05:40:18 -0500
Received: from mx2.elte.hu ([157.181.151.9]:5319 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288854AbSBDKkC>;
	Mon, 4 Feb 2002 05:40:02 -0500
Date: Mon, 4 Feb 2002 13:36:47 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
In-Reply-To: <20020204044055.EF0579251@oscar.casa.dyndns.org>
Message-ID: <Pine.LNX.4.33.0202041330401.4090-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 3 Feb 2002, Ed Tomlinson wrote:

> One point that seems to get missed is that a group of java threads,
> posix threads or sometimes forked processes combine to make an
> application. [...]

yes - but what makes them an application is not really the fact that they
share the VM (i can very much imagine thread-based login servers where
different users use different threads - a single application as well?),
but the intention of the application designer, which is hard to guess.

if this becomes inevitable then perhaps a better line we can guess along
is the child-parent relationship. Looking at 'pstree' output shows some
clear application boundaries. I'd say an application are 'all children of
a parent'. Ie. if two threads (shared VM or not shared VM, does not
matter) have the same parent (which is not init) then they form an
'application'. This will cover FreeNet java threads just as well as
hundreds of Apache processes.

but this method is guesswork as well, so it could mishandle certain cases.
Eg. i'm quite certain that most people would notice the interactive
effects if we handled all processes forked by kdeinit as a single
application. So lets do it only if everything else fails to fix your
workload.

	Ingo

