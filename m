Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135589AbRA0VZk>; Sat, 27 Jan 2001 16:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135596AbRA0VZT>; Sat, 27 Jan 2001 16:25:19 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:12038 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135589AbRA0VZO>; Sat, 27 Jan 2001 16:25:14 -0500
Message-ID: <3A733CA0.C05D8BBC@transmeta.com>
Date: Sat, 27 Jan 2001 13:24:48 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <200101272101.WAA27234@cave.bitwizard.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff wrote:
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

Again, such bumping entails:

	- Modify the code
	- Test the hell out of it
	- Submit the patch

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
>  - Find a scratch register (like the one in the 16450).
> 
>  - Is port 0x81 possibly "quite often" free?
> 

Who knows?  That's the thing you're going to have to find out if you want
to push this.  Again, the only way anyone is ever going to find out is by
doing *lots* of research (look at things like Ralf Brown's Interrupt
List), *then* followed by lots and lots of testing to smoke out boxes
that don't work for this.

For what it's worth, I'm talking from experience -- I tried to switch it
to port 0xED which I was told was used for this purpose by BIOS
manufacturers.  It didn't work.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
