Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262077AbSJIVkW>; Wed, 9 Oct 2002 17:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262080AbSJIVkW>; Wed, 9 Oct 2002 17:40:22 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:64786 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262077AbSJIVkV>; Wed, 9 Oct 2002 17:40:21 -0400
Date: Wed, 9 Oct 2002 23:45:49 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>, Patrick Mochel <mochel@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.GSO.4.21.0210091550150.8980-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0210092246040.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 9 Oct 2002, Alexander Viro wrote:

> > As to the "can_unload()" thing, I really suspect that the reason it shows
> > up is because module unloading is fundamentally broken - again regardless
> > of any driverfs issues. Talk to Rusty some day about it ;)
>
> I did and I'm less than impressed by his arguments.  Filesystem module
> unloading works fine, thank you very much.

I agree, that it works, but it's more complex than necessary.
We need module pointers everywhere, which are needed for reference
counting. To make this worse this only works for modules, so you possibly
need another reference count (e.g. see struct proc_dir_entry).
On the other hand can_unload() isn't really a solution either. From the
point can_unload() returns true, the module must not be called anymore. So
without some big lock this would only work if can_unload also calls
module_exit() and the whole thing gets even more complex.
Anyway, the module pointers can be easily replaced with a normal ref
count, but this requires that module_exit() can fail and so a new module
API, but IMO this can wait for 2.7, try_inc_mod_count() will do until
then.

bye, Roman

