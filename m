Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293697AbSCKLVO>; Mon, 11 Mar 2002 06:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293696AbSCKLUz>; Mon, 11 Mar 2002 06:20:55 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:32006
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S293692AbSCKLUt>; Mon, 11 Mar 2002 06:20:49 -0500
Date: Mon, 11 Mar 2002 03:13:10 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Jens Axboe <axboe@suse.de>, Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] BUG check in elevator.c:237
In-Reply-To: <3C8C857A.5090809@evision-ventures.com>
Message-ID: <Pine.LNX.4.10.10203110307370.10533-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Martin Dalecki wrote:

> Jens Axboe wrote:
> 
> > That's nonsense too. I added the expiry hook to let lower levels decide
> > what should happen when an interrupt timeout occurs. So there's been
> > _no_ interrupt if we enter this from the timer handler.
> 
> No interrupt from the same drive right.

No reported interrupt from the drive.
If you have gone into one of the old SFF overlap modes then you have
attempted to release service time.

> >>And plase guess whot? CD-ROM is the only driver which is using
> >>this facility. Please have a look at the last
> >>
> > 
> > Right, it was added to handle long commands like format unit etc.
> 
> Hmm seeks on tapes can take awfully long as well...

See above, streaming media is different.
It is a noise maker both on the bus and in life.

> >>argument of ide_set_handler(). The second argument is the
> >>interrutp handler for a command. The third is supposed to be
> >>the poll timerout function. But if you look at the
> >>actual poll function found in ide-cd.c (and only there).
> >>You may as well feel to try to just execute its commands directly in
> >>ide_timer_expiry, thus reducing tons of possible races ind the
> >>overall intr handling found currently there.
> >>
> > 
> > I don't know what tangent you are going off on here, I think you should
> > re-read this code a lot more carefully. There's no polling going on
> > here.
> 
> I think the term polling used by me is the only problem here ;-).
> (I consider every command controll which goes without irq notification
> just polling... whatever it polls once or not ;-).

It is not polling, follow Jens' suggestion and read the code.
Rewind, before you started making changes.  You will begin to have a
better grasp of the issues.  You will need that since the legacy hardware
in the device side will remain for a while.


Regards,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

