Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264105AbTEGRnV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 13:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbTEGRnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 13:43:21 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:4504 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264105AbTEGRnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 13:43:19 -0400
Date: Wed, 7 May 2003 19:55:31 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jonathan Lundell <linux@lundell-bros.com>
Cc: root@chaos.analogic.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
Message-ID: <20030507175531.GF19324@wohnheim.fh-wedel.de>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <p05210601badeeb31916c@[207.213.214.37]>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003 10:13:55 -0700, Jonathan Lundell wrote:
> At 10:16am -0400 5/7/03, Richard B. Johnson wrote:
> >Nope. Just don't steal thousands of CPU cycles to make something
> >"pretty". Obviously something called recursively with a 2k buffer
> >on the stack is going to break. However one has to actually
> >look at the code and determine the best (if any) way to reduce
> >stack usage. For instance, some persons may just "like" 0x400 for
> >the size of a temporary buffer when, in fact, 29 bytes are actually
> >used.
> >
> >FYI, one can make a module that will show the maximum amount
> >of stack ever used IFF the stack gets zeroed before use upon
> >kernel startup. Would this be useful or has it already been
> >done?
> 
> There's at least one patch floating around to do that; we've used it 
> to help track down some stack overflow problems.

Do you have a URL or can you post that patch? Sounds very useful for
information gathering.

> Does 2.5 use a separate interrupt stack? (Excuse my ignorance; I 
> haven't been paying attention.) Total stack-page usage in the 2.4 
> model, at any rate, is the sum of the task struct, the usage of any 
> task-level thread (system calls, pretty much), any softirq (including 
> the network protocol & routing handlers, and any netfilter modules), 
> and some number of possibly-nested hard interrupts.

Depends on the architecture. s390 does, ppc didn't as of 2.4.2, the
rest I'm not sure about. But this is another requirement for stack
reduction to 4k for most platforms, if not all.

> One thing that would help (aside from separate interrupt stacks) 
> would be a guard page below the stack. That wouldn't require any 
> physical memory to be reserved, and would provide positive indication 
> of stack overflow without significant runtime overhead.

Yes, that should work. It needs some additional code in the page fault
handler to detect this case, but that shouldn't slow the system down
too much.

Jörn

-- 
And spam is a useful source of entropy for /dev/random too!
-- Jasmine Strong
