Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbVL2PAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVL2PAV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 10:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVL2PAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 10:00:21 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:53176 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750752AbVL2PAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 10:00:20 -0500
Message-Id: <200512291458.jBTEwe23014458@laptop11.inf.utfsm.cl>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, arjan@infradead.org,
       linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers 
In-Reply-To: Message from Ingo Molnar <mingo@elte.hu> 
   of "Thu, 29 Dec 2005 08:32:59 BST." <20051229073259.GA20177@elte.hu> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Thu, 29 Dec 2005 11:58:40 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Thu, 29 Dec 2005 11:58:49 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> > Ingo Molnar <mingo@elte.hu> wrote:
> > > I think gcc should arguably not be forced to inline things when doing 
> > > -Os, and it's also expected to mess up much less than when optimizing 
> > > for speed. So maybe forced inlining should be dependent on 
> > > !CONFIG_CC_OPTIMIZE_FOR_SIZE?

> > When it comes to inlining I just don't trust gcc as far as I can spit 
> > it.  We're putting the kernel at the mercy of future random brainfarts 
> > and bugs from the gcc guys.  It would be better and safer IMO to 
> > continue to force `inline' to have strict and sane semamtics, and to 
> > simply be vigilant about our use of it.

> i think there's quite an attitude here - we are at the mercy of "gcc 
> brainfarts" anyway, and users are at the mercy of "kernel brainfarts" 
> just as much. Should users disable swapping and trash-talk it just 
> because the Linux kernel used to have a poor VM? (And the gcc folks are 
> certainly listening - it's not like they were unwilling to fix stuff, 
> they simply had their own decade-old technological legacies that made 
> certain seemingly random problems much harder to attack. E.g. -Os has 
> recently been improved quite significantly in to-be-gcc-4.2.)

Also, we do trust gcc not to screw up on lots of other stuff. I.e., we
trust it to use registers wisely (register anyone?), to set up sane
counting loops and related array handling (noone is using pointers to
traverse arrays "for speed" anymore), and to select the best code sequence
for the machine at hand in lots of cases, ... And not only for the kernel,
for the whole userspace too!

Sure, this is a large change, and it might be warranted to place it under
CONFIG_NEW_COMPILER_OPTIONS (Marked experimental, high explosive, etc if it
makes you too uneasy).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

