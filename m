Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131378AbRA2Omu>; Mon, 29 Jan 2001 09:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132093AbRA2Omk>; Mon, 29 Jan 2001 09:42:40 -0500
Received: from [194.213.32.137] ([194.213.32.137]:5380 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131378AbRA2OmW>;
	Mon, 29 Jan 2001 09:42:22 -0500
Message-ID: <20010128232943.D1300@bug.ucw.cz>
Date: Sun, 28 Jan 2001 23:29:43 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        "H. Peter Anvin" <hpa@transmeta.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <3A7333FF.AA813685@transmeta.com> <200101272101.WAA27234@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200101272101.WAA27234@cave.bitwizard.nl>; from Rogier Wolff on Sat, Jan 27, 2001 at 10:01:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > It output garbage to the 80h port in order to enforce I/O delays.
> > > > It's one of the safe ports to issue outs to.
> 
> > > Yes, because it is reserved for POST codes. You can get "POST
> > > debugging cards" that simply have a BIN -> 7segement encoder and two 7
> > > segment displays on them. They decode 0x80. That's what it's for.
> 
> > Again, if you want to change it, find another safe port, test the hell
> > out of it, an *PUBLICIZE IT* so noone will use it in the future.
> 
> I may have missed too much of the discussion, but I thought that the
> idea was that some people noted that their POST-code-cards don't
> really work all that well when Linux is running because Linux keeps on
> sending garbage to port 0x80. 
> 
> You seem to state that if you want POST codes, you should find a
> different port, modify the code, test the hell out of it, and then
> submit the patch.
> 
> That is NOT the right way to go about this: Port 0x80 is RESERVED for
> POST usage, that's why it's always free. If people want to use it for
> the original purpose then that is a pretty damn good reason to bump
> the non-intended users of that port somewhere else. 
> 
> Now, we've found that small delays are reasonably well generated with
> an "outb" to 0x80. So, indeed changing that to something else is going
> to be tricky. 
> 
> All that I can think of right now is:
>  - Find a register that can be written without side effects in 
>   "standard" hardware like a keyboard controller, or interrupt 
>    controller. Especially good are ones that already require us to keep
>    a shadow value. Write the shadow variable to the register.
>   (Tricky: not interrupt safe!)

What about just remembering shadow of 0x80 and always writing shadow
to 0x80? Interrupt unsafety hopefully does not matter much....
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
