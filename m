Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBLKeb>; Mon, 12 Feb 2001 05:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129098AbRBLKeV>; Mon, 12 Feb 2001 05:34:21 -0500
Received: from [194.213.32.137] ([194.213.32.137]:18692 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129042AbRBLKeI>;
	Mon, 12 Feb 2001 05:34:08 -0500
Message-ID: <20010212113213.B235@bug.ucw.cz>
Date: Mon, 12 Feb 2001 11:32:13 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <andrewm@uow.edu.au>
Cc: Tom Eastep <teastep@seattlefirewall.dyndns.org>,
        "Michael B. Trausch" <fd0man@crosswinds.net>,
        Josh Myer <jbm@joshisanerd.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Major Clock Drift
In-Reply-To: <3A871252.45974FFF@uow.edu.au> <E14SFbG-0006WR-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <E14SFbG-0006WR-00@the-village.bc.nu>; from Alan Cox on Mon, Feb 12, 2001 at 09:48:47AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Why are interrupts being disabled for vesafb scrolling anyway ?
> > 
> > Console writes happen under spin_lock_irq(console_lock).
> > 
> > The only reason for this which I can see: the kernel
> > can call printk() from interrupt context.
> 
> We certainly need to be able to call printk from interrupt context so that
> bit is in itself reasonable, but not the cost.
> 
> Suppose vesafb did something like this, dropping the printk lock
> 
> 	if(test_and_set_bit(0, &vesafb_lock))
> 	{
> 		if(in_interrupt())
> 		{
> 			// remember which bit of the dmesg ring to queue
> 			queued_writes=1;
> 			return;
> 		}
> 	}

Unfortunately, that means that if machine crashes in interrupt, it may
"loose" printk message. That is considered bad (tm).
								Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
