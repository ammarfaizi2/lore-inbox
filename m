Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266310AbTBCNbw>; Mon, 3 Feb 2003 08:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266318AbTBCNbw>; Mon, 3 Feb 2003 08:31:52 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:32014 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266310AbTBCNbv>; Mon, 3 Feb 2003 08:31:51 -0500
Date: Mon, 3 Feb 2003 14:40:11 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       <linux-kernel@vger.kernel.org>, <greg@kroah.com>, <jgarzik@pobox.com>
Subject: Re: [PATCH] Module alias and device table support. 
In-Reply-To: <200302030831.h138VZ4p011397@eeyore.valparaiso.cl>
Message-ID: <Pine.LNX.4.44.0302031145310.9900-100000@serv>
References: <200302030831.h138VZ4p011397@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > Consider another example: convenience aliases such as char-major-xxx.
> > Now, I'm not convinced they're a great idea anyway, but if people are
> > going to do this, I'd rather they did it in the kernel, rather than
> > some random userspace program.
> 
> The module munging programs and their configuration are (logically) a part
> of the kernel (configuration). So this goes against the current wave of
> exporting as much as possible from the kernel. And IMHO it places policy
> into the kernel, where it has no place. Plus it enlarges modules, which is
> a consideration for installation/rescue media.

Maybe it helps to put this into a larger perspective, because you both 
have valid points.
Currently the kernel has two mechanisms to request a module (modprobe and 
hotplug) and these also have different ways to map the request to a module 
name. modprobe needs a hardcoded list of module names, so it e.g. knows 
that it should map net-pf-1 to unix. OTOH we generate such a mapping for 
hotplug, but here the mapping is very device specific and requires 
knowledge about kernel structures.
If module loading were the only problem, the alias mechanism would be a 
good solution. We could remove hotplug and let modprobe do the job. 
Unfortunately it's not that easy, as we might want to extend hotplug to a 
more generic event mechanism, which e.g. could be used to replace devfs. 
This means we not only have "load the driver for this new device on this 
bus" events, but also "generate the device nodes for this new driver" 
events. In this context the module alias encoding would be very limited.
So what actually has to be discussed/decided, whether it's ok to special 
case module loading or if we want a generic kernel event mechanism, which 
can map any kind of event to some action. Until this isn't decided, it 
makes little sense to discuss details.

bye, Roman

