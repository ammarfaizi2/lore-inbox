Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262840AbVGAUx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262840AbVGAUx1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 16:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVGAUvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 16:51:35 -0400
Received: from alog0205.analogic.com ([208.224.220.220]:24758 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262277AbVGAUsh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 16:48:37 -0400
Date: Fri, 1 Jul 2005 16:47:06 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Andi Kleen <ak@suse.de>
cc: Christoph Lameter <christoph@lameter.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Read only syscall tables for x86_64 and i386
In-Reply-To: <20050701202805.GF21330@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0507011637460.5213@chaos.analogic.com>
References: <Pine.LNX.4.62.0506281141050.959@graphe.net.suse.lists.linux.kernel>
 <p73r7emuvi1.fsf@verdi.suse.de> <Pine.LNX.4.62.0506281238320.1734@graphe.net>
 <20050629024903.GA21575@bragg.suse.de> <Pine.LNX.4.62.0507011302090.19234@graphe.net>
 <20050701202805.GF21330@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2005, Andi Kleen wrote:

> On Fri, Jul 01, 2005 at 01:10:12PM -0700, Christoph Lameter wrote:
>>> I think it would make sense in theory to write protect them
>>> together with the kernel code and the modules
>>> (just to make root kit writing slightly harder)
>>
>> Seems that you are evading the question that I asked. Are syscall tables
>> supposed to be writable?
>
> I did answer it. But again: yes I think it makes sense in theory
> to make them read only.
>
> Just we cannot do it right now on i386/x86-64 due to the reasons I lined out
> in my previous mail.
>
>
>>
>>> BTW the kernel actually needs to write to code once
>>> to apply alternative(), but it would't be a problem to use
>>> a temporary mapping for this.
>>
>> What does this have to do with the syscall table???
>
>
> It is directly related to writable .text.
>
>>
>>>> The ability to protect a readonly section may be another issue.
>>>
>>> Well, it's the overriding issue here. Just pretending it's readonly
>>> when it isn't doesn't seem useful.
>>
>> This is all are off-topic talking about a different issue. And we are
>> already "pretending" that lots of other stuff in the readonly section is
>> readonly.
>
> Putting it into a "ro section" when it isn't actually read only is completely
> useless and does not do anything useful. So unless you figure out
> a way to make a true ro section without performance penalty I wouldn't bother.
>
> If you really want it for cosmetic reasons you can still do it,
> but it is about at the same usefullness level as shuffling white space in
> the source around.
>
> -Andi

The fact that the syscall table is R/W can be used to an advantage
for security. Yes!

After all modules are loaded, you (startup) loads a module that
makes the module-loader stuff return -ENOSYS. Then, nobody can
load any new modules. The running kernel is (more) secure.

You just need to make sure that all modules that you will need
are loaded before you do this. Also, you don't need to disable
auto module unloading because, nothing can be unloaded as
well.


Script started on Fri 01 Jul 2005 04:43:17 PM EDT
[root@chaos driver]# insmod LastDev.ko
[root@chaos driver]# insmod LastDev.ko
insmod: error inserting 'LastDev.ko': -1 Function not implemented
[root@chaos driver]# insmod LastDev.ko
insmod: error inserting 'LastDev.ko': -1 Function not implemented
[root@chaos driver]# insmod LastDev.ko
insmod: error inserting 'LastDev.ko': -1 Function not implemented
[root@chaos driver]# exit
Script done on Fri 01 Jul 2005 04:44:29 PM EDT


Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
