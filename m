Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWFRDrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWFRDrc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 23:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWFRDrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 23:47:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10392 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751090AbWFRDrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 23:47:31 -0400
Date: Sat, 17 Jun 2006 20:47:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.17
In-Reply-To: <4494C8E7.3080700@ens-lyon.org>
Message-ID: <Pine.LNX.4.64.0606172036360.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606171856190.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606171902040.5498@g5.osdl.org> <4494C8E7.3080700@ens-lyon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 17 Jun 2006, Brice Goglin wrote:
>
> I guess I could use git to generate the full changelog once a new
> release and keep it for later...

Well, if you are already a git user (or willing to become one), there's no 
point in even keeping it for later.

	[torvalds@g5 linux]$ time git log v2.6.16..v2.6.17 > /dev/null 
	
	real    0m0.484s
	user    0m0.448s
	sys     0m0.036s

ie the logfile generation really is almost free. And yes, that's the 
_full_ big log (all 92 _thousand_ lines of it, from the 6113 commits in 
the 2.6.16->17 case) being generated in under half a second.

Doing the shortlog (which sort and group by author in perl) is only 
fractionally more expensive.

The added benefit of doing it with git and generating it each time is that 
then you can also ask for logs just for a specific subsystem.

I don't know of anything but git that can efficiently do things like

	git log v2.6.16..v2.6.17 drivers/usb/

and it will show the log for all the commits that changed things under 
drivers/usb. And yeah, that can be slightly more expensive, but usually 
it's not noticeably so (history pruning at least in that case makes up for 
the extra work it has to do to figure out which commits changed that 
subsystem).

The point being that the dynamically generated data is often a lot more 
useful and readable. 

			Linus
