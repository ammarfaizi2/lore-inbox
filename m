Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130816AbRABKWq>; Tue, 2 Jan 2001 05:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130993AbRABKW0>; Tue, 2 Jan 2001 05:22:26 -0500
Received: from wep10a-3.wep.tudelft.nl ([130.161.65.38]:27399 "EHLO
	wep10a-3.wep.tudelft.nl") by vger.kernel.org with ESMTP
	id <S130816AbRABKWQ>; Tue, 2 Jan 2001 05:22:16 -0500
Date: Tue, 2 Jan 2001 10:51:46 +0100 (CET)
From: Taco IJsselmuiden <taco@wep.tudelft.nl>
Reply-To: Taco IJsselmuiden <taco@wep.tudelft.nl>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ne2000 (ISA) & test11+
In-Reply-To: <3A519108.23A41385@yahoo.com>
Message-ID: <Pine.LNX.4.21.0101021048140.3622-100000@hewpac.taco.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Taco IJsselmuiden wrote:
> > 
> > Second: I'm having problems loading my ne2000 (ISA) card as a module since
> > test11 (test10 + 2.2.17 works perfectly. Haven't tried 2.2.18...):
> > 
> > When loading the module with 'modprobe ne io=0x360 irq=4' it says:
> > 
> > /lib/modules/2.4.0-prerelease/kernel/drivers/net/ne.o: init_module: No
> > such device or address
> > Hint: insmod errors can be caused by incorrect module parameters,
> > including invalid IO or IRQ parameters
> > 
<snip>
> Since ne.c doesn't allow modular autoprobing, there was always an i/o
> address present, and hence you could still load the module even if
> there was a potential i/o space conflict.
> 
> In test11 and newer, check_region() is gone and an unconditional
> request_region() takes place, which will not allow any i/o space
> conflict.  In your case, 0x360 is suspect since a ne2000 is 0x20
> wide in i/o space and you are probably bumping into either:
> 
> 0376-0376 : ide1
> 0378-037a : parport0
> 
> Check your /proc/ioports, and relocate your ne card as appropriate.
Yep, that does the trick ;)
Thanks.

<pondering>
Hmm, so all this time I've had an io-conflict ...
Maybe my box will get even more stable now ;))
</pondering>

Cheers,
Taco.
---
"I was only 75 years old when I met her and I was still a kid...."
          -- Duncan McLeod

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
