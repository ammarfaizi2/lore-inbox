Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTEHP0J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 11:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTEHP0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 11:26:09 -0400
Received: from watch.techsource.com ([209.208.48.130]:1410 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S261797AbTEHP0H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 11:26:07 -0400
Message-ID: <3EBA7AE2.9020401@techsource.com>
Date: Thu, 08 May 2003 11:42:26 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Roland Dreier <roland@topspin.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]> <Pine.LNX.4.53.0305071323100.13049@chaos> <52k7d2pqwm.fsf@topspin.com> <Pine.LNX.4.53.0305071424290.13499@chaos> <52bryeppb3.fsf@topspin.com> <Pine.LNX.4.53.0305071523010.13724@chaos> <52n0hyo85x.fsf@topspin.com> <Pine.LNX.4.53.0305071547060.13869@chaos> <3EB96FB2.2020401@techsource.com> <Pine.LNX.4.53.0305080729410.16638@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Richard B. Johnson wrote:
> 
> In protected mode, the kernel stack. And, regardless of implimentation
> details, there can only be one. It's the one whos stack-selector
> is being used by the CPU. So, in the case of Linux, with multiple
> kernel stacks (!?????), one for each process, whatever process is
> running in kernel mode (current) has it's SS active. It's the
> one that gets hit with the interrupt.

That's kinda what I figured.  I just didn't know if there was some 
(hardware) provision to do otherwise, or if there was some reason why 
the interrupt handler might immediately switch stacks, etc.

That is to say, some CPUs might have provision for a stack pointer to be 
associated with each interrupt vector.

Secondly, given so many unknowns about what might already be on the 
current kernel stack, it might be generally safer to move the processor 
state (saved by the CPU on interrupt) from the current stack to some 
"interrupt stack" which may have a more predictable amount of free 
space.  (Then again, if the CPU is currently executing in user space, 
the kernel stack is probably completely empty.)

I realize that, however small, that would be an undesirable amount of 
overhead, but it occurs to me that someone might do that anyhow for 
stability reasons.  I could imagine some interrupts needing more than a 
trivial amount of stack space.  I'm assuming, for instance, that things 
like the IDE block driver would need to do things like PIO a sector 
to/from an old CDROM drive, look up the next scheduled I/O operation to 
perform, etc.


