Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263572AbTDWTfo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbTDWTfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:35:42 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:7685 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263572AbTDWTel
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:34:41 -0400
Date: Wed, 23 Apr 2003 15:41:46 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@digeo.com>
cc: Philippe =?ISO-8859-1?B?R3JhbW91bGzp?= 
	<philippe.gramoulle@mmania.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm4 & IRQ balancing
In-Reply-To: <20030419133837.0118907b.akpm@digeo.com>
Message-ID: <Pine.LNX.3.96.1030423153128.4451E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Apr 2003, Andrew Morton wrote:

> It's a little radical to go placing userspace daemons into the kernel tree,
> but I think it is appropriate - this thing is very tightly coupled to the
> kernel.
> 
> The proposal has these advantages:
> 
> - No version skew problems: if the format of /proc/interrupts changes, we
>   patch the irq balance daemon at the same time.
> 
> - Can build irqbalanced into the intial initramfs image as part of kernel
>   build. (lacking klibc, we would need to statically link against glibc)

Why, please? Unless you postulate that (a) the default kernel balance
would be so bad the machine wouldn't boot, or (b) that the interface would
be done only once at boot time, there's no reason for the user program to
be in initramfs, is there? Let the distribution put it where other system
things like ifconfig live.

Feel free to explain what I'm missing.

> - Doing it in userspace means that we can do more things.
> 
>   - The balancer can "know about" the differences between NICs, disk
>     controllers, etc.
> 
>   - The balancer can be controlled by config files: "I am a router"
> 
>   - The balancer can support non-x86 architectures
> 
> 
> Anyway, that's the theory.  None of it has been done yet.

I do agree that the program would have to match the /proc if done as you
propose, but wouldn't it be better to design an interface once and then
NOT have it change? And does it belong in /proc at all, given that other
things are being moved out?

I like the idea of being able to tune the int processing with a user
program. I don't think I share your vision of making a user program part
of the kernel to allow diddling an interface which might be better getting
right the first time, and protecting against "features" being added.
Hopefully it will be minimalist, and may well benefit from a totally
different user program for various machine types.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

