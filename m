Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261395AbTCGGty>; Fri, 7 Mar 2003 01:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261396AbTCGGty>; Fri, 7 Mar 2003 01:49:54 -0500
Received: from packet.digeo.com ([12.110.80.53]:54660 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261395AbTCGGtw>;
	Fri, 7 Mar 2003 01:49:52 -0500
Date: Thu, 6 Mar 2003 23:00:24 -0800
From: Andrew Morton <akpm@digeo.com>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: torvalds@transmeta.com, mingo@elte.hu, rml@tech9.net,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Message-Id: <20030306230024.0244b0f2.akpm@digeo.com>
In-Reply-To: <20030307064552.GA21885@vitelus.com>
References: <Pine.LNX.4.44.0303061819160.14218-100000@localhost.localdomain>
	<Pine.LNX.4.44.0303060936301.7206-100000@home.transmeta.com>
	<20030307064552.GA21885@vitelus.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2003 07:00:20.0295 (UTC) FILETIME=[377C9D70:01C2E477]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann <aaronl@vitelus.com> wrote:
>
> On Thu, Mar 06, 2003 at 09:42:03AM -0800, Linus Torvalds wrote:
> > But it was definitely there. 3-5 second _pauses_. Not slowdowns.
> 
> I can second this. Using Linux 2.5.5x, untarring a file while
> compiling could cause X to freeze for several seconds at a time.

This may be a VM/block/IO scheduler thing.  If the X server is trying to page
some text in and the disk is busy writing some stuff out then yes, the X
server can freeze for some time.

Of course, a ton of work has gone into this problem, and more work continues
to be done.

If your machine has a small amount of memory, or is heavily overcommitted
then it is more likely to happen.

Using the CFQ or AS IO schedulers will help a bit.  And decreasing
/proc/sys/vm/swappiness may help too.

I'd be interested in feedback on the latter.  The default policy of 60% seems
to be about right for the 128M to 256M desktops, but I am running 85% on
larger memory machines so that a bit more stuff gets paged out.


