Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129596AbQKVGOA>; Wed, 22 Nov 2000 01:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129821AbQKVGNv>; Wed, 22 Nov 2000 01:13:51 -0500
Received: from tetsuo.zabbo.net ([204.138.55.44]:20495 "HELO tetsuo.zabbo.net")
	by vger.kernel.org with SMTP id <S129596AbQKVGNm>;
	Wed, 22 Nov 2000 01:13:42 -0500
Date: Wed, 22 Nov 2000 14:13:41 -0500
From: Zach Brown <zab@zabbo.net>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.4.0-test11/drivers/sound/maestro.c port to new PCI interface
Message-ID: <20001122141341.E14640@tetsuo.zabbo.net>
In-Reply-To: <200011220223.SAA00416@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200011220223.SAA00416@baldur.yggdrasil.com>; from adam@yggdrasil.com on Tue, Nov 21, 2000 at 06:23:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[first off, thanks for kicking this stuff into gear Adam.  I'm way too
lazy to do this stuff of my own volition :)]

> >was to serialize access to the mixer, there are surely better ways to do
> >it.  Why are interrupts disabled?

the maestro has crappy register indirection that you must use to do
nearly anything.  when the locking was added we just went nutty with one
big lock :)  yes, this could be cleaned up with a mixer specific lock
as the mixer regs aren't atomic, but don't require the same indirection
as the rest of the maestro stuff.  the locking fix is still valid if
they're all under one big lock.

> 	As far as I can tell, I agree with you, but I do not think
> that is related to the move to the new PCI interface.

*nod*

> 	I also agree that the ioctl patch is kind of a bandaid over
> the problems that you described, and, while Zach Brown can speak

The biggest problem is that the current code is gross gross gross.
I've been avoiding dealing with it too much in the hopes that moving to
oss_audio will make things much more friendly across the board.

> problem permanent, and (2) it is an incremental improvement over
> the status quo.

*nod*  I'd like 2.2/2.4 to at least be solid for people so I can
disappear (again) to do the oss_audio work.  Really, I'd hope it
wouldn't take all that long.

> 	That said, I am willing to help try to clean up the
> locking code in maestro if Zach thinks it is worth doing right
> now, since I have a notebook computer with a maestro chip in

If you get me a patch thats obviously correct, I'd happily agree to
it going in.  I'm not sure its immeditately needed, but won't stop you
from playing with things :).  Jeff has the start of a patch that moves
maestro.c to be a consumer of ac97_codec.  It was really close, except
for some locking oopsies.  If you're dorking around with the locking, you
might be able to fix that up at the same time.  The new ac97 interface
cleans up the code a lot. you can look at how the maestro3 does it,
its almost identical to how maestro.c + ac97 would look.  [hah, except
that maestro3 hasn't had any locking applied to it at all.]

> >This driver needs __devxxx, I've heard mention of some hotpluggable
> >audio that is based on the maestro chipset (which chip I don't remember)

scary. :)

this all reminds me, the maestro3 driver is working well enough for most
people that I should get it going on 2.4 and submit it..

-- 
 zach
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
