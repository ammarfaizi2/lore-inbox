Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbTAJMK2>; Fri, 10 Jan 2003 07:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264886AbTAJMK2>; Fri, 10 Jan 2003 07:10:28 -0500
Received: from h-64-105-35-49.SNVACAID.covad.net ([64.105.35.49]:24195 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262469AbTAJMKZ>; Fri, 10 Jan 2003 07:10:25 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 10 Jan 2003 04:18:58 -0800
Message-Id: <200301101218.EAA03840@baldur.yggdrasil.com>
To: rusty@rustcorp.com.au
Subject: Re: Another idea for simplifying locking in kernel/module.c
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
>In message <200301100910.BAA31409@adam.yggdrasil.com> you write:
>> Rusty Russell wrote:
>> >In message <200301070219.SAA12905@adam.yggdrasil.com> you write:
>> >> 	Here is a way to replace all of the specialized "stop CPU"
>> >> locking code in kernel/module.c with an rw_semaphore by using
>> >> down_read_trylock in try_module_get() and down_write when beginning to
>> >> unload the module.
>> 
>> >And now you can't modularize netfilter modules.
>> 
>> 	Why not?  Last time you went looking in the networking code
>> for an example of something that had to increment a module reference
>> in a context where blocking was not allowed you ended up conceding
>> that you example was incorrect.

>No, you're thinking of the IPv4 stack.  I didn't use netfilter as an
>example, because that opens me to "well, FIX NETFILTER then!".  If it
>were the only case, it's probably arguable.

>The problems with netfilter modules are exactly why I started looking
>at module locking over two years ago.

>> 	I just booted my gateway machine to a kernel using my
>> aforemetioned patch and various netfilter modules.  I've surfed the
>> web, FTP'ed file and run irc through it.  It seems to be okay.

>Sure!  That's because the netfilter modules use a horrific hack, by
>keeping their own "usage" counts and then spinning (potentially
>forever) on unload until it hits zero.
[...]

	Although I suspect that this could be fixed so that the
spinning is guanteed not to be forever, it happens that my
module_put(), which is the same as your module_put() is non-blocking
(as is my try_module_get(), by the way).  So I don't see what the
problem is.  You should still be able to call try_module_get and
module_put from an interrupt context.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

	
