Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbRFYJYb>; Mon, 25 Jun 2001 05:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263070AbRFYJYM>; Mon, 25 Jun 2001 05:24:12 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:7186 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S263034AbRFYJYE>; Mon, 25 Jun 2001 05:24:04 -0400
Message-ID: <3B3702B5.13554207@idb.hist.no>
Date: Mon, 25 Jun 2001 11:21:57 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: Thrashing WITHOUT swap.
In-Reply-To: <Pine.LNX.4.33.0106242133550.19801-100000@druid.if.uj.edu.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Zenczykowski wrote:
> Now my question is how can it be
> thrashing with swap explicitly turned off? 

Easy.  Linux throws executables out from memory because they _can_
be fetched again from disk.  Yes - this definitely gives trashing
if you loose almost all your executables this way.

> [oh just to make stuff even
> funnier netscape is at nice -19 (i.e. lower priority)]

That makes no difference.  nice'ing netscape means it use
less _cpu when other things want cpu_, it can still over-spend memory!

> top gives me:
> mem: 62144k av, 61180k used, 956k free, 0k shrd, 76 buff, 2636 cached
> swap: 0k av, 0k used, 0k free [as expected]

File i/o becomes a pain with so few buffers and cache pages left, and
then your file i/o and the executable fetching competes for
the disk.  No wonder it got slow, and laptop disks aren't usually
that fast either...
 
> So my basic question is what can I do to fix this?
Looks like you were 3M away from running completely out of memory.
Turn on that swap partition you mentioned, your machine will degrade
much more gracefully.  It'll keep more cache around and be able
to get rid of unused data instead of just dropping executables.
Some of the code is used a lot after all.

If it still is too slow - add RAM or run fewer/smaller apps.
Opera is a low-memory alternative to netscape.  Avoiding
gnome/kde apps when plain X apps are available is also a good idea
when you're short on memory.  Using low resolution and low-color
modes might help a little if you do lot of graphics.  But then
you might not want that.

Helge Hafting
