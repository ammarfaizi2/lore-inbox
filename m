Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318500AbSHWHmF>; Fri, 23 Aug 2002 03:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318599AbSHWHmF>; Fri, 23 Aug 2002 03:42:05 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:46856
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318500AbSHWHmD>; Fri, 23 Aug 2002 03:42:03 -0400
Date: Fri, 23 Aug 2002 00:45:03 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: jgarzik@mandrakesoft.com, ebiederm@xmission.com,
       linux-kernel@vger.kernel.org
Subject: Re: IDE-flash device and hard disk on same controller
In-Reply-To: <200208230654.XAA02328@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.10.10208230022060.14761-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2002, Adam J. Richter wrote:

> 	1. Regardless of whatever specification you are referring to
> or Andre's "31 second rule of [Power On Self Test]", it is genuinely
> useful to boot faster by overlapping some other kernel work before the
> drive is.  Specifications ultimately exist only to serve this
> usefulness.  When a specification impedes usefulness, sometimes it's
> the right decision to violate it.  Of course, we're not talking about

Listen to yourself, and understand why 2.5 failed.

"When a specification impedes usefulness, sometimes it's the right
decision to violate it."

"Gee there is no traffic in the on coming lanes, maybe I should use them."

There are rules for how the hardware works, and if everything out there
comes up in 4 seconds great.  If everything returns faster than the worst
case great.  You start assuming everything behaves that way and you repeat
history.

You guys in 2.5 walked away from the rules because you thought you knew
better, where did it get you?  Lost interrupts, PIO command block
exectution failures, dropping EOT on PRD's because reading something into
the published documents which is not there, etc ...

> your IDE code violating such a specification, but rather not relying
> on this particular guarantee.
> 
> 	2. Besides, if this code is supposed to be a generic IDE core,
> it many need to run on platforms that do not provide that guarantee or
> where the boot code is not even capable of finding where all of the
> IDE controllers.

It is a means for probing signatures w/o identify to test for presence.
It to has a 31 second rule.  Break the worst case and device get lost.

We already have a problem with PPC and loosing devices.
This is where JG's hard work and my time with him explaining it will help
most.  Also case where RMK's ARM toys do fun things and the assumption by
the driver that POST is valid is DEAD WRONG.  I will repeat the assumption
of my code about POST is DEAD WRONG!  POST like events happen at different
times for various archs.

****

So if we were in the network stack and decided to chuck the "D-gram"
because it got in the way is that cool?

Better if we were in the scsi stack and blew off the queue list and
rammed an immediate SCB down the pipes that wastes the device queue tags
internal, is that okay.  The rules got in the way for this command I
wanted to beat down the controller.

> 	3. In the hierarchy of upgradability, it is generally easier
> to replace the kernel than the Power On Self Test, which is more often
> in flash or ROM, and which may require help from an unenthusiastic
> hardware vendor.  So, it is better to weight trade-offs a few notches
> in favor of avoid reliance on guarantees about the Power On Self Test.
> 
> 	If I understand correctly, the cost of this trade off would be
> adding one or two lines that add perhaps 20 bytes and as many CPU
> cycles at initiailzation (except when this change really is necessary).

Please do not take this personal, because it is a technical arguemnet.
We do it by the books and then we cheat when we can, but only after we
have all the proper stuff in place for compliance.

Cheers,


Andre Hedrick
LAD Storage Consulting Group

