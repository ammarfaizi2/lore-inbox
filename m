Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbTEGOB5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 10:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTEGOB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 10:01:56 -0400
Received: from chaos.analogic.com ([204.178.40.224]:50050 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262908AbTEGOBy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 10:01:54 -0400
Date: Wed, 7 May 2003 10:16:20 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
In-Reply-To: <20030507135657.GC18177@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.53.0305071008080.11871@chaos>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de>
 <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, [iso-8859-1] Jörn Engel wrote:

> On Wed, 7 May 2003 09:45:13 -0400, Richard B. Johnson wrote:
> >
> > You know (I hope) that allocating stuff on the stack is not
> > "bad". In fact, it's the quickest way to allocate data that
> > will automatically go away when the function returns. One
> > just subtracts a value from the stack-pointer and you have
> > the data area. I sure hope that these temporary allocations
> > are not being replaced with kmalloc()/kfree(). If so, the
> > code is badly broken and you are eating my CPU cycles for
> > nothing.
>
> Agreed, partially. There is the current issue of the kernel stack
> being just 8k in size and no decent mechanism in place to detect a
> stack overflow. And there is (arguably) the future issue of the kernel
> stack shrinking to 4k.
>
> Stuff like intermezzo will break with 4k, no discussion about that.
> Other stuff may or may not work. What I'm trying to do is pave the way
> to shrink the kernel stack during 2.7 sometime.
>
> If there is large agreement that the kernel stack should not shrink,
> I'll stop this effort any day. But so far, I am under the impression
> that the agreement is to do the shink. Am I wrong?
>
> Jörn

Nope. Just don't steal thousands of CPU cycles to make something
"pretty". Obviously something called recursively with a 2k buffer
on the stack is going to break. However one has to actually
look at the code and determine the best (if any) way to reduce
stack usage. For instance, some persons may just "like" 0x400 for
the size of a temporary buffer when, in fact, 29 bytes are actually
used.

FYI, one can make a module that will show the maximum amount
of stack ever used IFF the stack gets zeroed before use upon
kernel startup. Would this be useful or has it already been
done?


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

