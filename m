Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316229AbSEVQG4>; Wed, 22 May 2002 12:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316233AbSEVQGz>; Wed, 22 May 2002 12:06:55 -0400
Received: from [195.63.194.11] ([195.63.194.11]:47633 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316229AbSEVQGv>; Wed, 22 May 2002 12:06:51 -0400
Message-ID: <3CEBB342.6060303@evision-ventures.com>
Date: Wed, 22 May 2002 17:03:30 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.16 IDE 68
In-Reply-To: <Pine.LNX.4.44.0205220848100.7580-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Linus Torvalds napisa?:
> 
> On Wed, 22 May 2002, Martin Dalecki wrote:
> 
>>- Make the different ATAPI device type drivers use a unified packet command
>>   structure. We have to start to push them together.
> 
> 
> Good.
> 
> However, I suggest you really look at the big picture, and realize that
> this is NOT an ATA-only issue.

Linus I agree fully with you!

> The unified packet command thing should be started at a higher level,
> where the command creation itself should create them into "rq->cmd[]", and
> the interfaces to the _user_ should also be unified.

Well you should have seen me already hopping between differnt
layers with stuff like this quite frequently. I'm just not going
to "jump down" (well in this case up) this cliff in one big step.
I will try to push it step but step where it belongs. OK?

> If you think it's stupid to have different packet mechanisms for IDE CD vs
> disk, imagine how stupid it is to have different packet interfaces for
> SCSI CD vs IDE CD and expose those different interfaces to user mode.
> 
> This is why I think you made a mistake to move ll_10byte_cmd_build() into
> the IDE layer. We want to move the packet building _up_, not down.

No I didn't.
It's nearly always a mistake to push the methods (well functions),
before the objects (well structs) are in place.
Pushing methods before objects makes no semantical anvances, becouse
it's just tossing code lines around and obfuscating the code by adding
#include <> interdependancies.

> And you should put the command into "rq->cmd[]", _not_ into "pc->c[]" like
> the curren code does. And strive to standardize on a command set (where

Applying the same cure to struct atapi_packet_command as has been
applyed (well by me - who else) to the struct atapi_packed_command
is of course the next "cheap" goal! It has been exerciesed once in ide-cd.c
and the problems are well known. But even by way of this simple
example one can see immediately that it is better to first target
the structural part (structs) and then the code. Not the other way around.
(Next thing should be to ake rq->buffer and rq->special in line too for
example.)

> the obvious target is a very SCSI-like one - for all the same reasons
> that ATAPI commands themselves tend to look like SCSI commands).
> 
> So please don't lose sight of the fact that there is more than just IDE
> out there, and _please_ get rid of the atapi-specific command. Think ahead
> a bit, and notice how you have the "scsi" parts in the
> "atapi_packet_command", and realize that you shouldn't need to have that,
> if you were just to share the same request cmd layout.

Sure I realize it. ide-cd.c should make it clean that
struct atapi_packet_comman will be "melted down" step by step
the same way the ide-cd stuff got metled down if possible :-).

I hope the "hawkeye" view layered out above makes clear why I'm
doing the stuff in the order I do and why it has more
chances to succeed. At least there are no dissagreements about
the goals. OK?

