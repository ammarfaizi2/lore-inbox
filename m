Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263897AbTF0GSV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 02:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbTF0GSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 02:18:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:27307 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263897AbTF0GST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 02:18:19 -0400
Message-Id: <5.2.0.9.2.20030627071904.00c890e0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Fri, 27 Jun 2003 08:36:48 +0200
To: Bill Davidsen <davidsen@tmr.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: O(1) scheduler & interactivity improvements
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1030626104733.17562D-100000@gatekeeper.tmr.c
 om>
References: <3EFAC408.4020106@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:50 AM 6/26/2003 -0400, Bill Davidsen wrote:
>On Thu, 26 Jun 2003, Helge Hafting wrote:
>
> > This can be fine-tuned a bit: We may want the pipe-waiter
> > to get a _little_ bonus at times, but that has to be
> > subtracted from whatever bonus the process at the
> > other end of the pipe has.  I.e. no new bonus
> > created, just shift some the existing bonus around.
> > The "other end" may, after all, have gained legitimate
> > bonus from waiting on the disk/network/paging/os, and passing
> > some of that on to "clients" might make sense.
> >
> > So irman and similar pipe chains wouldn't be able to build
> > artifical priority, but if it get some priority
> > in an "acceptable" way then it is passed
> > along until it expires.
> >
> > I.e. "bzcat file.bz2 | grep something | sort | less" could
> > pass priority down the chain when bzcat suffers
> > a long nfs wait...
>
>This is the case which worries me, passing back the priority of the
>process which is waiting for user input. It's desirable, but hard to do
>and subject to unintended boosts.

The thought of building/passing "connection" information around in the 
scheduler gives me a bad case of the willies.  I can imagine a process 
struct containing a list of components and their cpu usage information as a 
means to defeat fairness/starvation issues, but I can't imagine how to do 
that and retain high speed low drag O(1) scheduling.

Until someone demonstrates that the DoS/abuse scenarios I might be 
imagining are real, in C, I think I'll do the smart thing: try to stop 
worrying about it and stick to very very simple stuff.

         -Mike

(heck, i don't know why i'm even _thinking_ about it.  plain white cone 
doesn't cut it, and there's a "you have to be this tall" line at the 
entrance to the wizards section of the hat store;) 

