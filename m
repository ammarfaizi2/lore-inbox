Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262908AbVCJWBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbVCJWBy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbVCJWBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:01:53 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:39643 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263254AbVCJVml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 16:42:41 -0500
Message-ID: <4230BF5F.6060703@comcast.net>
Date: Thu, 10 Mar 2005 16:42:55 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: binary drivers and development
References: <423075B7.5080004@comcast.net> <423082BF.6060007@comcast.net> <20050310212133.GE17865@csclub.uwaterloo.ca>
In-Reply-To: <20050310212133.GE17865@csclub.uwaterloo.ca>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

People are still e-mailing me about this?

Lennart Sorensen wrote:
> On Thu, Mar 10, 2005 at 12:24:15PM -0500, John Richard Moser wrote:
> 
>>I've done more thought, here's a small list of advantages on using
>>binary drivers, specifically considering UDI.  You can consider a
>>different implementation for binary drivers as well, with most of the
>>same advantages.
>>
>> - Smaller kernel tree
>>   The kernel tree would no longer contain all of the drivers; they'd
>>   slowly have to bleed into UDI until most were there
> 
> 
> Users would have to go hunting for drivers to add to their kernel to get
> hardware supported.  Making a CD with a kernel and drivers for a wide
> variety of hardware would be a nightmare.
> 

/pub/kernel/2.6
/pub/drivers/

> 
>> - Better focused development
>>   The kernel's core would be the core.  Driver code would be isolated,
>>   so work on the kernel would affect the kernel only and not any
>>   drivers.  UDI is a standard interface that shouldn't be broken.  This
>>   means that work on the high-level drivers will not need to be sanity
>>   checked a thousand times against the PCI Bus interface or the USB
>>   host controler API or whatnot.
> 
> 
> But anything that runs in kernel memory space can still go trampling on
> memory in the kernel by accident and is very difficult to debug without
> the sources.
> 

True, but that only should happen if you code things to access exact
memory locations, rather than asking the kernel for memory or mappings.

> 
>> - Faster rebuilding for developers
>>   The isolation between drivers and core would make rebuilding involve
>>   the particular component (driver, core).  A "broken driver" would
>>   just require recoding and rebuilding the driver; a "broken kernel"
>>   would require building pretty much a skeletal core
> 
> 
> That can already be done basicly.  The makefiles work just fine for
> rebuilding only what has changed in general.
> 

I don't remember what I was thinking
> 
>> - UDI supplies SMP safety
>>   The UDI page brags[1]:
>>
>>   "An advanced scheduling model. Multiple driver instances can be run
>>    in parallel on multiple processors with no lock management performed
>>    by the driver. Free paralllism and scalability!"
>>
>>   Drivers can be considered SMP safe, apparently.  Inside the same
>>   driver, however, I have my doubts; I can see a driver maintaining a
>>   linked list that needs to be locked during insertions or deletions,
>>   which needs lock managment for the driver.  Still, no consideration
>>   for anything outside the driver need be made, apparently.
>> - Vendor drivers and religious issues
>>   Vendors can supply third party drivers until there are open source
>>   alternatives, since they have this religious thing where they don't
>>   want people to see their driver code, which is kind of annoying and
>>   impedes progress
> 
> 
> I imagine a driver writer could still easily do something not SMP safe,
> but I don't know that for sure.  It sounds like a very complex thing to
> promise a perfect solution for.
> 

internally drivers would need to be smp safe, eh.  Externally I guess
they're safe.

> 
>>Disadvantages:
>>
>> - Preemption
>>   Is it still possible to implement a soft realtime kernel that
>>   responds to interrupts quickly?
>> - Performance
>>   UDI's developers claim that the performance overhead is negligible.
>>   It's still added work, but it remains to be seen if it's significant
>>   enough to degrade performance.
>> - Religious battles
>>   People have this religious thing about binary drivers, which is kind
>>   of annoying and impedes progress
> 
> 
> Many of the disadvantages are a good reason why they have these opinions
> on binary drivers.  They do impede getting work done if you have to use
> them on your system and something isn't working right.
> 
> 
>> - Constriction
>>   This would of course create an abstraction layer that constricts the
>>   driver developer's ability to do low level complex operations for any
>>   portable binary driver
> 
> 
> You forgot the very important:
>    - Only works on architecture it was compiled for.  So anyone not
>      using i386 (and maybe later x86-64) is simply out of luck.  What do
>      nvidia users that want accelerated nvidia drivers for X DRI do
>      right now if they have a powerpc or a sparc or an alpha?  How about
>      porting Linux to a new architecture.  With binary drivers you now
>      start out with no drivers on the new architecture except for the
>      ones you have source for.  Not very productive.
> 
> [snip]
> 

yeah, I was thinking the open source drivers would be ubiquitous to all
architectures anyway though.  Closed drivers would be subject to lazy
venders.

> Len Sorensen
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCML9fhDd4aOud5P8RAglXAJ9hTu5jVZcZ/LLFFw41bjO73+ShhwCfUlma
iPcrJXwKP0ZfQ8jCsVhxhSQ=
=CknT
-----END PGP SIGNATURE-----
