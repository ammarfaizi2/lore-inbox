Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264679AbRFQBgC>; Sat, 16 Jun 2001 21:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264678AbRFQBfw>; Sat, 16 Jun 2001 21:35:52 -0400
Received: from chaos.analogic.com ([204.178.40.224]:42624 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264677AbRFQBfi>; Sat, 16 Jun 2001 21:35:38 -0400
Date: Sat, 16 Jun 2001 21:35:34 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Bill Pringlemeir <bpringle@sympatico.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: Newbie idiotic questions.
In-Reply-To: <m2d78352do.fsf@sympatico.ca>
Message-ID: <Pine.LNX.3.95.1010616212729.14170A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jun 2001, Bill Pringlemeir wrote:

> 
> I have been looking at the emu10k1 driver and I had a few questions
> about general idioms used there.
> 
> In a line like this,
> 
> [main.c, line 175]
> 
> 	for (count = 0; count < sizeof(card->digmix) / sizeof(card->digmix[0]); count++) {
> 
> Isn't there some sort of `ALEN' macro available, or is this
> considered to muddy things by using a macro?

Note that code in drivers range from very nice to awful, and every level
in between.

I generally use a macro called ArraySize(), defined up-front.

> 
> [main.c, line 223]
> 	if ((card->mpuout = kmalloc(sizeof(struct emu10k1_mpuout), GFP_KERNEL))
> 
> Why is the struct type referenced for the allocation size?  Why not,
> 
> 	if ((card->mpuout = kmalloc(sizeof(card->mpuout), GFP_KERNEL))
> 
> This seems to get the size for the actual object being allocated.
> 

Again, you are correct. However, you may not know the history of the
driver. Perhaps at one time the above statement was correct.

> [cardmi.c, line 42]
> 
> static struct {
> 	int (*Fn) (struct emu10k1_mpuin *, u8);
> } midistatefn[] = {
> ...
> 

[...snipped....]



> 
> regards,
> Bill Pringlemeir.


What you should do is supply a patch. Call it a "general cleanup". Send
it first to the maintainer of the driver. If this doesn't work, send it
to linux-kernel. Test your patch well because you may fix something that
breaks something else. 


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


