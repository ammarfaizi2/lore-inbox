Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbUKCQs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUKCQs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 11:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbUKCQs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 11:48:27 -0500
Received: from alog0495.analogic.com ([208.224.223.32]:8576 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261718AbUKCQqv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 11:46:51 -0500
Date: Wed, 3 Nov 2004 11:46:15 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Gene Heskett <gene.heskett@verizon.net>
cc: linux-kernel@vger.kernel.org, bert hubert <ahu@ds9a.nl>
Subject: Re: is killing zombies possible w/o a reboot?
In-Reply-To: <200411031124.19179.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.61.0411031133590.14117@chaos.analogic.com>
References: <200411030751.39578.gene.heskett@verizon.net>
 <20041103143348.GA24596@outpost.ds9a.nl> <200411031124.19179.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Nov 2004, Gene Heskett wrote:

> On Wednesday 03 November 2004 09:33, bert hubert wrote:
>> On Wed, Nov 03, 2004 at 07:51:39AM -0500, Gene Heskett wrote:
>>> But I'd tried to run gnomeradio earlier to listen to the
>>> elections,
>>
>> Depressing enough.
>>
>>> I'd tried to kill the zombie earlier but couldn't.
>>> Isn't there some way to clean up a &^$#^#@)_ zombie?
>>
>> Kill the parent, is the only (portable) way.
>
> The parent would have been the icon.  It opened its usual sized small
> window, but never did anything to it. I clicked on closing the
> window, but 10 seconds later the system asked me if I wanted to kill
> it as it wasn't responding. I said yes, the window disappeared, but
> kpm said gomeradio was still present as process 8162, and that wasn't
> killable.  Funny thing is, on the reboot, it automaticly self
> restored and ran just fine.
>
> I consider this as one of linux's achilles heels.  Such a hung and
> dead process can be properly disposed of by a primitive os called os9
> because it keeps track of all resources in tables in the kernel
> memory space.  Issueing a kill procnumber removes the process from
> the exec queue, reclaims all its memory to the system free memory
> pool, and removes it from the IRQ service tables if an entry exists
> there.  Near instant, total cleanup, nothing left, in about 250
> microseconds max. 1.79 mhz cpu's aren't quite instant :)
>
> Lets just say that I think having to reboot because of a zombie that
> has resources locked up, and have the reboot fubared by it too,
> aren't exactly friendly actions.

[SNIPPED....]

There is no problem killing a task and freeing its resources.
The problem is that Linux and other Unix variations need to
do this in a specific manner. That manner being that some
parent (or ultimately init) needs to receive the terminating
status. A task that has been otherwise killed, but is awaiting
its status to be obtained is in the 'Z' or zombie state. If
the code for either the child task or its parent was improperly
written, the death of a parent could allow a child to wait
forever (zombie).

The fix is to fix the code. Your temporary fix is to use
Ctrl-Alt-backspace to kill the X11 server (the parent).
If it doesn't restart (it's not a kernel problem, it's
a distribution problem), you can log in as root and
execute:

 	/etc/X11/prefdm &

All these little windows and icons are the 'children' of
the X server. The above is a temporary work-around for
a non-kernel problem.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
