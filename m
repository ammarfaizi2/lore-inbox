Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276665AbRKFBVf>; Mon, 5 Nov 2001 20:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276708AbRKFBVY>; Mon, 5 Nov 2001 20:21:24 -0500
Received: from 24.159.204.122.roc.nc.chartermi.net ([24.159.204.122]:60935
	"EHLO tweedle.cabbey.net") by vger.kernel.org with ESMTP
	id <S276665AbRKFBVU>; Mon, 5 Nov 2001 20:21:20 -0500
Date: Mon, 5 Nov 2001 19:20:52 -0600 (CST)
From: Chris Abbey <linux@cabbey.net>
X-X-Sender: <cabbey@tweedle.cabbey.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How can I know the number of current users in the system?
In-Reply-To: <Pine.LNX.4.21.0111050746280.9415-100000@Consulate.UFP.CX>
Message-ID: <Pine.LNX.4.33.0111051852200.24928-100000@tweedle.cabbey.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today, Riley Williams wrote:
> Here's a simple shell command to provide that information:
>
> 	who | wc -l
>
> Try it and see...

Actually that's not a fair count of the number of users on the box,
only the number that are *logged in*. On one of our boxes at work,
that would miss about 80% of the users, maybe more. Anyone that
RSH's or SSH's in without a tty wouldn't be counted:

cabbey@CHESIRE ~> ssh -T tweedle who
cabbey@CHESIRE ~>

so even though I was executing who on tweedle it didn't see me
logged in. A more realistic situation:

[cabbey@tweedle cabbey]$ who
cabbey   pts/0    Nov  5 19:05
cabbey   pts/1    Nov  5 19:05
[cabbey@tweedle cabbey]$

pts/0 is my pine session, pts/1 is the shell I executed who in,
there are also two copies of "xeyes" running back to chesire
that were started as 'ssh -T tweedle /usr/X11r6/bin/xeyes -display
chesire:0' but don't appear in who

going back to running it remotely:

cabbey@CHESIRE ~> ssh -T tweedle who
cabbey   pts/0    Nov  5 19:05
cabbey   pts/1    Nov  5 19:05
cabbey@CHESIRE ~>

If those were move cpu hungry programs than xeyes,
like vncserver with a complete kde/gnome desktop
running under it then you could really be missing
some data from a scheduling pov... which as I recall
was what the original poster wanted to fiddle with.

-- 
now the forces of openness have a powerful and
  unexpected new ally - http://ibm.com/linux


