Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267716AbTCFDVL>; Wed, 5 Mar 2003 22:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267721AbTCFDVL>; Wed, 5 Mar 2003 22:21:11 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:527 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267716AbTCFDVK>; Wed, 5 Mar 2003 22:21:10 -0500
Date: Wed, 5 Mar 2003 19:29:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: george anzinger <george@mvista.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Making it easy to add system calls
In-Reply-To: <3E66A44A.6000808@mvista.com>
Message-ID: <Pine.LNX.4.44.0303051926180.10651-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Mar 2003, george anzinger wrote:
> 
> SYS_CALL(clock_nanosleep) \
> 
> This will put "sys_clock_nanosleep" in the call table in entry.S and 
> define the "__NR_clock_nanosleep" for unistd.  The last entry of the 
> enum is NR_syscalls, thus defineing and keeping this symbol current.

Me no likee.

The fact is, we add system calls maybe a few times a year. Having to 
update two places instead of just one is not very onerous.

More importantly, the system call numbers should be something you have to 
think about, and a setup that makes it easy to merge new system calls with 
different numbers "by mistake" is a _bad_ setup.

Don't get me wrong - I'm not saying that "system calls should be hard to 
add, because only real men should add system calls". But I _am_ saying 
that it should be damn hard to add a system call by mistake at the wrong 
number, which is something your patch makes a lot easier than the current 
situation.

And I do believe that adding system calls should inherently be something
that you have to think twice about, even if one of the thoughs is just
literally writing out the number that you decided on. So while I don't 
think it should be "hard", it should definitely not be made any easier 
than it already is.

		Linus

