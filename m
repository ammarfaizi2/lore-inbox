Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266995AbSKWM06>; Sat, 23 Nov 2002 07:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266996AbSKWM06>; Sat, 23 Nov 2002 07:26:58 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:9732 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266995AbSKWM05>; Sat, 23 Nov 2002 07:26:57 -0500
Date: Sat, 23 Nov 2002 13:34:04 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org, <vandrove@vc.cvut.cz>
Subject: Re: [RFC] module fs or how to not break everything at once
In-Reply-To: <200211230458.UAA17701@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.44.0211231308250.2113-100000@serv>
References: <200211230458.UAA17701@adam.yggdrasil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 22 Nov 2002, Adam J. Richter wrote:

> 	I will try to find that discussion.  In the meantime, I'll just
> point out that you can still use the linker with two .o files instead
> of one .o and an ld script.  At the very least, it you would be
> relying on one less GNUism (linker scripts).

If you manage to remove arch/*/vmlinux.lds, we can continue this 
discussion. I need the module linker script for very much the same 
reasons.

> >Why would you kill insmod with SIGKILL?
> 
> 	For example, you might be aborting a shutdown, or you might
> have decided to kill all processes on a certain terminal because
> you're trying to kill some runaway activity.

Well, if you kill processes with SIGKILL, you get exactly what you ask 
for.

> >You're trying here to assign tasks to insmod it shouldn't know about. The 
> >more insmod knows about the module layout the harder is it to change it 
> >from the kernel side and the more you loose flexibilty.
> >All this can be easily done by the kernel.
> 
> 	By that logic, we must go with Rusty's kernel module loader,
> perhaps with an interface like "int sys_insmod(char **argv)."

Think _very_ carefully about what I wrote earlier:
"Overall this means all module tasks become nicely separated. During build 
we prepare the module with all the information the kernel needs, the 
loader takes care of dependencies and just relocates the module, modfs 
maps it into the kernel and starts the module. If the interfaces are 
halfway flexible, changes in one part don't require a change somewhere 
else."
This is the basic design goal and I will not change it without a very good 
reason.

Otherwise I stop this discussion here, I doubt you will get _anyone_ to 
implement the features you want. It also makes little sense to discuss 
details of an implementation, which doesn't exist yet. As soon as it does 
exist, you are free to implement whatever you want on top of it. If you 
get anyone to look at it without a barf bag, I'll consider it. If you 
think you can do better, try to implement your own module loader, I think 
it will be an interesting learning experience for you.

bye, Roman

