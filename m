Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264698AbRFQIHM>; Sun, 17 Jun 2001 04:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbRFQIHC>; Sun, 17 Jun 2001 04:07:02 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:47624 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id <S264698AbRFQIGv>; Sun, 17 Jun 2001 04:06:51 -0400
From: rjd@xyzzy.clara.co.uk
Message-Id: <200106170806.f5H86Nm10524@xyzzy.clara.co.uk>
Subject: Re: Newbie idiotic questions.
To: bpringle@sympatico.ca (Bill Pringlemeir)
Date: Sun, 17 Jun 2001 09:06:23 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m2d78352do.fsf@sympatico.ca> from "Bill Pringlemeir" at Jun 17, 2001 08:11:30 
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Bill Pringlemeir wrote:
> 
> I have been looking at the emu10k1 driver and I had a few questions
> about general idioms used there.

Warning I've not looked at that particular driver and would concider
myself a Linux kernel newbie. 20 years kernel hacking but only 9
months Linux with two drivers under my belt. One of which I'm now
trying to get into the standard tree.


> [main.c, line 175]
> 
> 	for (count = 0; count < sizeof(card->digmix) / sizeof(card->digmix[0]); count++) {
> 
> Isn't there some sort of `ALEN' macro available, or is this
> considered to muddy things by using a macro?

Some writers are good and some not so good. Personally I'd prefer an
ArrayLen style macro but some prefer to see it long hand. My usual style
would be to use the array size #def used to define the array. I'd shoot
whoever wrote digmix[9 * 6 * 2];  OK so I just peeked at the source :-)

I might be tempted to tidy this up whilst I was adding something
significant to the driver but not for the sake of it. If I tidied that
one up I'd have to change all the other occurances in a consistent manner,
seem like a lot of work for little or no gain.


> [main.c, line 223]
> 	if ((card->mpuout = kmalloc(sizeof(struct emu10k1_mpuout), GFP_KERNEL))
> 
> Why is the struct type referenced for the allocation size?  Why not,
> 
> 	if ((card->mpuout = kmalloc(sizeof(card->mpuout), GFP_KERNEL))
> 
> This seems to get the size for the actual object being allocated.

I prefer the struct construct and this also demonstrates why it's best
not to fiddle just for the sake of it. You've changed the allocation
from the size of the struct into the size of a pointer.


> [cardmi.c, line 42]
> 
> static struct {
> 	int (*Fn) (struct emu10k1_mpuin *, u8);
> } midistatefn[] = {
> ...
> 
> Why aren't all the gobs of constant data in this driver declared as
> constant?  Do it give a performance advantage by having the data in a
> different MMU section and better cache effects or something?

const is better but frequently forgotten :-(


> Thanks for any helpful pointers.  I did read the FAQ.  I am just
> wonder if I would get screamed at for changing things like this and
> why... so I will probably get yelled at for suggesting them anyway,
> but at least I won't have went through the effort.  Now that I have
> pointed that out, the will probably irk people even more...

Perhaps the biggest one is when making changes follow the style of the
existing file. Style changes in midstream only add to the confusion.
Don't change layout rules or methods of doing things unless you are
prepared to update the entire module and justify the changes to the
original module author who has every right to be highly critical.



-- 
        Bob Dunlop                      FarSite Communications
        rjd@xyzzy.clara.co.uk           bob.dunlop@farsite.co.uk
        www.xyzzy.clara.co.uk           www.farsite.co.uk
