Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268296AbTCFUAv>; Thu, 6 Mar 2003 15:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268327AbTCFUAv>; Thu, 6 Mar 2003 15:00:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35333 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268296AbTCFUAu>; Thu, 6 Mar 2003 15:00:50 -0500
Date: Thu, 6 Mar 2003 12:08:43 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HT and idle = poll
In-Reply-To: <1046984969.17718.118.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0303061206240.8404-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 6 Mar 2003, Alan Cox wrote:
> On Thu, 2003-03-06 at 19:30, Linus Torvalds wrote:
> > >So, don't use idle=poll with HT when you know your workload has idle time!  I 
> > >have not tried oprofile, but it stands to reason that this would be a 
> 
> idle=poll probably needs to be doing "rep nop" in a tight loop.

We already do that. It's not enough. The HT thing will still steal cycles 
continually, since the "rep nop" is really only equivalent to a 
"sched_yield()".

Think of "rep nop" as yielding, and "mwait" as a true wait.

(I don't actually have any real information on "mwait", so I may be wrong 
about the details on the new instructions. They looked obvious enough, 
though).

		Linus

