Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276444AbRJ2QjM>; Mon, 29 Oct 2001 11:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276305AbRJ2Qi5>; Mon, 29 Oct 2001 11:38:57 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:9746 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S276255AbRJ2QiT>;
	Mon, 29 Oct 2001 11:38:19 -0500
Date: Mon, 29 Oct 2001 17:38:53 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.13-ac4
Message-ID: <20011029173853.B4041@suse.cz>
In-Reply-To: <20011029084736.A3152@suse.cz> <E15yA5r-0002Ha-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15yA5r-0002Ha-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Oct 29, 2001 at 10:56:35AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 10:56:35AM +0000, Alan Cox wrote:
> > bytes read from the 8254 get swapped. I've got some indirect evidence
> > that this also could happen with the original i8254. 
> 
> Im hoping not. That would imply we interrupted someone half way through
> reading the counter which means the locking is screwed up.

Some old DOS assembly sources say that this sometimes happens without
any interrupts at all - just that the chip is sometimes confused. It'd
be definitely worth printing the bad and good values when a problem is
detected, so that we know what's happening.

I've checked it, and yes, the locking is somewhat broken. The following
drivers can access the timer chip and don't grab the lock:

drivers/char/ftape/lowlevel/ftape-calibr.c
drivers/char/joystick/analog.c
drivers/char/joystick/gameport.c
drivers/ide/hd.c
drivers/ide/ide.c

The joystick ones are my fault, of course, and I'll fix that asap.

> > By the way, if we made the 8254 accesses (spinlock?) protected (which
> > should be done anyway, right now definitely more than one CPU can access
> > the registers at once), I think we could remove the outb(0, 0x43);,
> > saving some cycles.
> 
> Some chipsets need the outb

I see.

-- 
Vojtech Pavlik
SuSE Labs
