Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267375AbTBKSAx>; Tue, 11 Feb 2003 13:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267377AbTBKSAx>; Tue, 11 Feb 2003 13:00:53 -0500
Received: from DaVinci.coe.neu.edu ([129.10.32.95]:64168 "EHLO
	DaVinci.coe.neu.edu") by vger.kernel.org with ESMTP
	id <S267375AbTBKSAw>; Tue, 11 Feb 2003 13:00:52 -0500
Date: Tue, 11 Feb 2003 13:10:39 -0500 (EST)
From: Mauricio Martinez <mauricio@coe.neu.edu>
To: Corey Minyard <minyard@acm.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.20 drivers/cdrom/cdu31a.c
In-Reply-To: <3E43D552.8010707@acm.org>
Message-ID: <Pine.GSO.4.33.0302111235510.29078-100000@Amps.coe.neu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for your reply. I guess there are still some drives like this
floating around. I can live without it, but it is good to use it in an old
486 as a jukebox and print server :)

Your patch makes much more sense that mine (I have no experience in Linux
driver development), and it makes the drive work *very well* (excellent
transfer rate and no system overload), but only if I remove the last hunk.

This last hunk tries to read again the data with 4 sectors less each time
(i.e. 16,14,12,...,4) which *i think* overloads the buffer leading to an
oops (and even a system reboot without warning!).

Hope this information helps.

-Mauricio


On Fri, 7 Feb 2003, Corey Minyard wrote:

> I don't guess anyone I've sent documentation to has taken up support of
> this drive.  It's amazing that any of these things are still running,
> since I think they stop manufacturing them in 1994.  I don't think I
> have a machine that it will even work in any more.  I guess they were
> well-built drives.
>
> The change you are suggesting is probably not the best, you probably
> need to fix it higher up to do multiple requests if nsect is > 4.  I've
> attached a patch.  It compiles, but I obviously can't test it.
>
> Looking through the code, there's obvious SMP problems and a few other
> things.  I have a new machine with an ISA slot (I think), I might try to
> plug it in.
>
> -Corey
>
> Mauricio Martinez wrote:
>
> >This patch fixes the kernel oops while trying to read a data CD. Thanks to
> >Brian Gerst and Faik Uygur for your suggestions.
> >
> >It looks like the variable nblocks must be <= 4 so the read ahead buffer
> >size is not exceeded (which is the cause of the oops). Changing its value
> >doesn't seem to be the right way, but it makes the device work properly.
> >
> >Feedback of any sort welcome.
> >
> >
> >
>

