Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279317AbRJ2Rrw>; Mon, 29 Oct 2001 12:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279321AbRJ2Rrm>; Mon, 29 Oct 2001 12:47:42 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:20243 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S279317AbRJ2Rrb>; Mon, 29 Oct 2001 12:47:31 -0500
Date: Mon, 29 Oct 2001 18:48:05 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.13-ac4
Message-ID: <20011029184805.A4504@suse.cz>
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
> 
> > By the way, if we made the 8254 accesses (spinlock?) protected (which
> > should be done anyway, right now definitely more than one CPU can access
> > the registers at once), I think we could remove the outb(0, 0x43);,
> > saving some cycles.
> 
> Some chipsets need the outb

I'm looking at how to cleanly fix the timer accesses. And I think a
common inline function that does the

lock
outb
inb
inb
check - via, other bugs
unlock

would make sense. What do you think?

-- 
Vojtech Pavlik
SuSE Labs
