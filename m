Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278930AbRJVVRm>; Mon, 22 Oct 2001 17:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278919AbRJVVRb>; Mon, 22 Oct 2001 17:17:31 -0400
Received: from hatrack.unc.edu.ar ([170.210.248.6]:14060 "EHLO
	hatrack.unc.edu.ar") by vger.kernel.org with ESMTP
	id <S278930AbRJVVRG>; Mon, 22 Oct 2001 17:17:06 -0400
Date: Mon, 22 Oct 2001 15:12:50 -0300 (GMT+3)
From: Marcos Dione <mdione@hal.famaf.unc.edu.ar>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: kjournald and disk sleeping
In-Reply-To: <20011022124751.C5146@turbolinux.com>
Message-ID: <Pine.LNX.4.33.0110221501240.25281-100000@hp11.labcomp.famaf.unc.edu.ar>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001, Andreas Dilger wrote:

> Don't use 2.4.10 Linus kernel with ext3.  It is bad.  Use a newer kernel,
> or -ac kernel instead.

	ok, anyways I'll switch to 2.4.12 this evening.

> Hmm.  I have a laptop running with all ext3 filesystems, and it has no
> problems spinning down the disk.  I have not done anything to increase
> the flush interval of kjournald.  It may be that kjournald is writing
> to disk because you have things which are trying to write to disk.

	uh, and is there any way to find out which processes are doing so?
and now that I think, my current kernel is *not* patched with ext3 (my
previous 2.4.8 had it) but I have reiser support *as module* with no
reiser filesystem mounted. and not only kjornald is there, it has nowhere
to write. hmm, I'll see again thin evening and tell you tomorrow.

> > then I send a STOP signal to kupdated
>
> Well, this is a sure sign that you are getting disk write requests.
> Note that it is very dangerous to do this.  Instead, you should give it
> a long (but finite) interval so that you at least get some data written
> to disk instead of none at all.

	but I really want the machine to be suspended, in a very small
way: I mean, I know that suspending is not complete, but spinning down the
disks and entering in a conservative state both system and cpu will save
energy. stopping kupdated and switching off swap is for that.

> If you change the commit interval and run in journaled-data mode, and have
> a long interval to kupdated, then ext3 _should_ buffer all of your I/O in
> memory until the journal is full.  This is much safer than just turning off
> kupdated, since you WILL get things written to disk if there have been enough
> changes to fill the journal, so you have an upper limit of a few MB of data
> that can be lost if it never flushes to disk.

	mmm, anyways, I'm supossedly not writing to the disk. shutting
down commits should not loose anything because there's nothing to loose.

-- 
"y, bueno, yo soy muy ilogico. lo que pasa es que ustedes me toman
demasiado en serio"
                                          --JLB

