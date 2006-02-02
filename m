Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWBBVcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWBBVcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWBBVcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:32:11 -0500
Received: from macferrin.com ([65.98.32.91]:61457 "EHLO macferrin.com")
	by vger.kernel.org with ESMTP id S932280AbWBBVcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:32:09 -0500
Message-ID: <43E27A1A.4090709@macferrin.com>
Date: Thu, 02 Feb 2006 14:31:06 -0700
From: Ken MacFerrin <lists@macferrin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Thunderbird/1.0.7 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: linux-kernel@vger.kernel.org, dspring@acm.org
Subject: Re: PROBLEM: kernel BUG at mm/rmap.c:486 - kernel 2.6.15-r1
References: <43DAE307.5010306@macferrin.com> <Pine.LNX.4.61.0601281537120.5929@goblin.wat.veritas.com> <43E15DB6.9070003@macferrin.com> <Pine.LNX.4.61.0602021511160.7689@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0602021511160.7689@goblin.wat.veritas.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

>>Feb  1 17:01:01 mm-home1 cron[31322]: (root) CMD (/usr/bin/updatedb) 
> Okay, so plenty of disk and cache activity then.
> Were you doing anything interesting at the graphics end?

Nope.. just had a couple vncviewer sessions, firefox, thunderbird, a few 
superkarmba applets and a couple konsole windows.  I'm typically running 
KDE 3.5.0 on two 19" flatpanels via the DVI ports on a dual-head GF 
6600GT card.

One thing I have noticed in the past is I would often get the crash as 
soon as I resumed from a locked screen.  Xscreensaver is set to kick on 
after 20 mintues and the screensaver would be running fine when I sit 
back down, but as soon as I gave a mouse/keyboard input it would lockup 
with a garbled screen.  This time however I was actively using the 
machine when it crashed.

[snip]

>>Feb  1 17:04:14 mm-home1 kdm[10322]: X server for display :0 terminated
>>unexpectedly
> 
> Nothing to say why that was, but we already know the system is bad.

Yep, this is when I get the garbled screen.  Sometimes it will stop 
responding to any input at this point, others it allow me to 
Ctrl+Alt+F10 into the console.  This time I was able to drop to console.

[snip]

>>Feb  1 17:04:29 mm-home1 login(pam_unix)[10286]: session opened for user root
>>by LOGIN(uid=0)
>>Feb  1 17:06:45 mm-home1 __find_get_block_slow() failed. block=1681,
>>b_blocknr=23362423066986129

This was after dropping to console.  It let me login to root but before 
being able to view the logs it started spewing out strings of errors 
that are scrolling too quickly to read and do not get captured by syslog 
(either local or remote).  I've learned from experience that this is the 
time to do a hard reboot or it starts trashing up the filesystem.  I've 
had to run "fsck-reiserfs --rebuild-tree" more times than I'd prefer.

> 
> Or in hex, block=0x691 b_blocknr=0x0053000000000691: something has
> corrupted the upper short of the bufheader's block number with 0x53.
> 
> Well, you're getting plenty of memory corruption, and there's some pattern
> to it (bits 8-11 each time), but I can't guess where it's coming from,
> I'm afraid.  The "Bad rmap", my speciality, looks merely incidental
> to the more general memory corruption.
> 
> I know you already said you really need to use the nVidia driver for
> xinerama, but it has to be suspect #1.  Any chance of doing without it
> just for a day, to see what happens then?  Or would that force you into
> such a different work pattern that it would prove nothing?
> 
> After that, the next thing to try is going back to 2.6.12: I think you
> said this bad behaviour started with 2.6.13 (but I may be quite wrong
> to assume that you were running 2.6.12 before).  Perhaps the problem
> lies with your hardware, but started to manifest around the time you
> moved to 2.6.13, we do need to rule that out.
> 
> Hugh

I agree. I will run with the kernel "nv" driver on a single monitor over 
the weekend to see if I can recreate the problem.  Failing that I'll 
give 2.6.12 another shot.  A couple other datapoints that may be worth note:

1) David Spring posted the following message on this thread yesterday 
that would seem to point away from the binary nvidia driver:

"It's not the nv drivers - or at least not just them.  I'm getting this 
bug once or twice a day on a mini-ITX (C3 533Mhz processor) based server 
which doesn't even have X installed.  For me, it appeared sometime after 
2.6.12.  I'm now running with gentoo 2.6.15-r1 with Hugh's recently 
posted patch,and waiting 8-|
Dave Spring"

If Dave is able to post a syslog with his errors then it would provide 
an untainted report.


2) I have also found this thread from the Nvidia forum that would seem 
to point towards the nvidia driver.  Although unlike this person, whose 
troubles only started with 2.6.15-rc3, I have experienced this bug since 
the 2.6.13 series.
http://www.nvnews.net/vbulletin/archive/index.php/t-60711.html

Thanks,
Ken
