Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbTEHIyd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 04:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbTEHIyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 04:54:33 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:52117 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261241AbTEHIyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 04:54:32 -0400
Date: Thu, 8 May 2003 11:06:53 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Timothy Miller <miller@techsource.com>
Cc: root@chaos.analogic.com, Roland Dreier <roland@topspin.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
Message-ID: <20030508090653.GG1469@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]> <Pine.LNX.4.53.0305071323100.13049@chaos> <52k7d2pqwm.fsf@topspin.com> <Pine.LNX.4.53.0305071424290.13499@chaos> <52bryeppb3.fsf@topspin.com> <Pine.LNX.4.53.0305071523010.13724@chaos> <52n0hyo85x.fsf@topspin.com> <Pine.LNX.4.53.0305071547060.13869@chaos> <3EB96FB2.2020401@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3EB96FB2.2020401@techsource.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003 16:42:26 -0400, Timothy Miller wrote:
> Richard B. Johnson wrote:
> >
> >When a caller executes int 0x80, this is a software interrupt,
> >called a 'trap'. It enters the trap handler on the kernel stack,
> >with the segment selectors set up as defined for that trap-handler.
> >It happens because software told hardware what to do ahead of time.
> >Software doesn't do it during the trap event. In the trap handler,
> >no context switch normally occurs. 
> 
> On typical processors, when one gets an interrupt, the current program 
> counter and processor state flags are pushed onto a stack.  Which stack 
> gets used for this?

I have no idea, what a 'typical processor' might look like. But the
thing most CPU seem to have in common is that they save two registers
either on the stack or into other registers that only exist for this
purpose (SRR on PPC).

Once that has happened, the OS has the job to figure out where it's
stack (or equivalent) is located, *without* clobbering the registers.
Once that is done, it can save all the registern on the stack,
including SRR. It might also move what the CPU has pushed to the
"stack" somewhere else.

After the interrupt has been handled, the reverse path is executed,
restoring registers in the correct order, possibly switching from
kernel to user stack, etc.

And there is one kernel stack per process. Please don't argue about
that, unless you have read the code.

Jörn

-- 
Do not stop an army on its way home.
-- Sun Tzu
