Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280961AbRKLUHG>; Mon, 12 Nov 2001 15:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280964AbRKLUG6>; Mon, 12 Nov 2001 15:06:58 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:21180 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S280961AbRKLUGw>;
	Mon, 12 Nov 2001 15:06:52 -0500
Date: Mon, 12 Nov 2001 21:06:32 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Frank de Lange <lkml-frank@unternet.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Abysmal interactive performance on 2.4.linus
In-Reply-To: <20011112205551.A14132@unternet.org>
Message-ID: <Pine.LNX.4.21.0111122102550.4841-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2001, Frank de Lange wrote:

> On a 768 MB SMP box (2x466 MHz Celeron), I see some weird problems with
> interactive performance on 2.4.15pre{1,2}. A good example of this is the
> following scenario:
> 
>  - copy a large file (eg. an iso image file) to a directory on the same
>    (reiserfs in this case) filesystem, or...
>  - do a filesystem comparison between a CD and the original file (with cmp
>    /mnt/cdrom/<filename> /mnt/reiserfs/1/data/<original_file_location>, using a
>    PLEXTOR Model: CD-ROM PX-40TS SCSI CD-ROM drive),
> 
>  - and THEN (while the copy or comparison runs) try any simple command (like
>    'ls /mnt/reiserfs/1/data' or 'top' or anything else...). 
> 
> Response time is abysmal, a simple 'ls /some/dir' takes tens of seconds to
> start. Once the command is running, performance is normal. Try this when a
> cdrecord session is running and you'll get a buffer underrun.
> 
> The box has 768 MB of RAM, 512 MB of swap. There is no significant load on the
> system (according to an already running copy of top) neither before nor during
> the test. Try tab-completing a command in a terminal, and that terminal freezes
> for tens of seconds, usually until after the file system load has gone down.
> 
> In a few words, heavy filesystem activity seems to wreak havoc on the system.
> Not by loading the CPU (it hardly breaks out a sweat at 178% idle (SMP...)).
> 
> Turning off swap (swapoff -a) does not change the observed behaviour.
> 
> Anyone else seen something like this?

I have 2.4.10-ac12 here and reiserfs filesystems and I have to say that
performance is terrible when doing anything diskintensive. It seems like
diskscheduling is very broken for my IDE disk, or it's a reiserfs
problem. maybe it pushes a _lot_ into the diskscheduling at once?

I've heard that read-ahead for IDE has been broken for a while but's fixed
in -ac and in Andre Hedrick's IDE-patches.

I'm going to upgrade to a more recent kernel and see how it behaves.

/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.

