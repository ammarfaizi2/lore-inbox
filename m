Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135476AbRA0VBa>; Sat, 27 Jan 2001 16:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135563AbRA0VBT>; Sat, 27 Jan 2001 16:01:19 -0500
Received: from 13dyn73.delft.casema.net ([212.64.76.73]:21260 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S135457AbRA0VBL>; Sat, 27 Jan 2001 16:01:11 -0500
Message-Id: <200101272101.WAA27234@cave.bitwizard.nl>
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <3A7333FF.AA813685@transmeta.com> from "H. Peter Anvin" at "Jan
 27, 2001 12:47:59 pm"
To: "H. Peter Anvin" <hpa@transmeta.com>
Date: Sat, 27 Jan 2001 22:01:02 +0100 (MET)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Rogier Wolff wrote:
> > H. Peter Anvin wrote:
> > > It output garbage to the 80h port in order to enforce I/O delays.
> > > It's one of the safe ports to issue outs to.

> > Yes, because it is reserved for POST codes. You can get "POST
> > debugging cards" that simply have a BIN -> 7segement encoder and two 7
> > segment displays on them. They decode 0x80. That's what it's for.

> Again, if you want to change it, find another safe port, test the hell
> out of it, an *PUBLICIZE IT* so noone will use it in the future.

I may have missed too much of the discussion, but I thought that the
idea was that some people noted that their POST-code-cards don't
really work all that well when Linux is running because Linux keeps on
sending garbage to port 0x80. 

You seem to state that if you want POST codes, you should find a
different port, modify the code, test the hell out of it, and then
submit the patch.

That is NOT the right way to go about this: Port 0x80 is RESERVED for
POST usage, that's why it's always free. If people want to use it for
the original purpose then that is a pretty damn good reason to bump
the non-intended users of that port somewhere else. 

Now, we've found that small delays are reasonably well generated with
an "outb" to 0x80. So, indeed changing that to something else is going
to be tricky. 

All that I can think of right now is:
 - Find a register that can be written without side effects in 
  "standard" hardware like a keyboard controller, or interrupt 
   controller. Especially good are ones that already require us to keep
   a shadow value. Write the shadow variable to the register.
  (Tricky: not interrupt safe!)
 - Find a scratch register (like the one in the 16450). 

 - Is port 0x81 possibly "quite often" free?

		Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
