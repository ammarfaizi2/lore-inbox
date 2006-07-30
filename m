Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWG3KMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWG3KMT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 06:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWG3KMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 06:12:19 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:6533 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751382AbWG3KMR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 06:12:17 -0400
Message-ID: <44CC85FD.1050000@drzeus.cx>
Date: Sun, 30 Jul 2006 12:12:13 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Alex Dubov <oakad@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash
 card readers
References: <20060730062942.29644.qmail@web36706.mail.mud.yahoo.com>
In-Reply-To: <20060730062942.29644.qmail@web36706.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Dubov wrote:
> They are magic numbers. I have only the vague idea on
> what most of these numbers mean. I digged them out
> from TI's/everest's binary driver.
>   

Then try to make qualified guesses. Even if the constants are
TIFM_INTFLAG_2, that still makes the code more readable as you see which
values are the same constant.

By "magic", in the valid sense, I do not mean "unknown". What I mean is
"purposely random", as in values used to identify file systems and file
formats.

>
> I already have "socket". "card" is something that is
> plugged into the "socket". It's hard to think about
> short name that fits here nicely.
>
>   

I assume "socket" is a structure for one of the card type subfunctions
of the controller and that "card" is something you create once that
subfunction is activated by a card insertion. Why can't you have the
"card" portions allocated at all times as part of the "socket"
structure? Is it possible for a "socket" to have multiple "card":s
associated with it? Otherwise I see little need for the dynamic behaviour.

> Unfortunately, hardware does care. Output of
> tifm_sd_op_flag is set into upper half of command
> register. 
>   

Sorry, I was a bit unclear. Of course hardware cares about what kind of
response it will get. What I meant was that hardware shouldn't care if
it's R1, R2 or R666. What it should care about is if it's "Short
response with CRC and embedded opcode" or something similar. If you look
at the meaning of the response types and try to compare the different
bit combinations, you can usually see patterns. Just remember that most
controllers do not usually support checking every little aspect.

> The fall-back is 0 (implied default for both
> switches).
>   

And you are sure this will be valid for response type RFooBar,
consisting of only a new combination of the existing response
attributes, that I will come up with tomorrow?

> The TI binary drivers tests for the command type
> before setting the appropriate bit in command register
> (similar to tifm_sd_op_flags).
>   

Please do a BUG_ON() or fail the request or something similar. If you
would happen to get a request where cmd->data is set, but type isn't
ADTC, then I assume all hell will break loose.

> In general: while I'm using code flow different from
> this used in TI's binary drivers, I tried very hard to
> preserve register access semantics. 
>   

Careful. People get a bit edgy with such reasoning around reverse
engineering. ;)

> When I failed to
> do so, very bad things happened - sporadic and brutal
> kernel crashes and run-aways. I think they were caused
> by device writing random junk to some memory address
> at arbitrary times.
>
>   

Baby steps. If you test carefully enough (and do some qualified
guessing), you usually can figure out what most bits of a register are for.

Great work figuring out the hardware as much as you have though. This
driver will be a nice addition.

Rgds
Pierre

