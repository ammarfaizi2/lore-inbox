Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130580AbQLJQ5v>; Sun, 10 Dec 2000 11:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130842AbQLJQ5m>; Sun, 10 Dec 2000 11:57:42 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:46866 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130580AbQLJQ5J>;
	Sun, 10 Dec 2000 11:57:09 -0500
Message-ID: <3A33AEBE.CB853142@mandrakesoft.com>
Date: Sun, 10 Dec 2000 11:26:38 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
CC: Linus Torvalds <torvalds@transmeta.com>, rgooch@ras.ucalgary.ca,
        dhinds@valinux.com, linux-kernel@vger.kernel.org
Subject: Re: Serial cardbus code.... for testing, please.....
In-Reply-To: <200012100822.DAA17932@tsx-prime.MIT.EDU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Y. Ts'o" wrote:
> 
>    Date: Sat, 09 Dec 2000 11:13:59 -0500
>    From: Jeff Garzik <jgarzik@mandrakesoft.com>
> 
>    > Note how the "rs_interrupt()" routine _tries_ to avoid this by having a
>    > pass counter value, but that logic never triggers because we will loop
>    > forever in receive_chars(), so the rs_interrupt() counter never even gets
>    > to increment.
> 
>    Other places in serial.c check for 0xff, which implies we can and should
>    do the same in the interrupt handler...
> 
> No, other places in the serial driver check for 0xff *after* setting
> various registers and clearing various flags.  Those various
> initializations are critical before you can simply do a "bail if LSR ==
> 0xff" check.

Looking through the code, isn't this setup complete before any
interrupts get delivered to rs_interrupt?


> It's possible (not very likely, but possible) for LSR to go into
> christmas tree mode where all of the flags are set in normal operation.
> So for the interrupt driver, we're going to have to do some kind of loop
> based thing --- if interrupt driver receives 0xff more than some number
> of times, bail.

oh well :)

	Jeff


-- 
Jeff Garzik         |
Building 1024       | These are not the J's you're lookin' for.
MandrakeSoft        | It's an old Jedi mind trick.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
