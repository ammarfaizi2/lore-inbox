Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131811AbQLIPdQ>; Sat, 9 Dec 2000 10:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131870AbQLIPdG>; Sat, 9 Dec 2000 10:33:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:64782 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S131811AbQLIPc7>; Sat, 9 Dec 2000 10:32:59 -0500
Date: Sat, 9 Dec 2000 16:04:03 +0100
From: Martin Mares <mj@suse.cz>
To: davej@suse.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pdev_enable_device no longer used ?
Message-ID: <20001209160403.A28562@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.21.0012091122460.3465-100000@neo.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.21.0012091122460.3465-100000@neo.local>; from davej@suse.de on Sat, Dec 09, 2000 at 11:30:44AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  I noticed a lot of drivers are setting the PCI_CACHE_LINE_SIZE
> themselves, some to L1_CACHE_BYTES/sizeof(u32), others
> to arbitrary values (4, 8, 16).
> 
> Then I spotted that we have a routine in the PCI subsystem
> (pdev_enable_device) that sets all these to L1_CACHE_BYTES/sizeof(u32)
> Further digging revealed that this routine was not getting called.
> 
> On my Athlon box, I've noticed some devices are getting their
> default values set to 8 (where (I think) it should be 16 ?)
> 
> Questions:
> 1. Is there reason for the drivers to be setting this themselves
>    to hardcoded values ?

Definitely not unless the devices are buggy and need a work-around.

For PC's, we've until now relied on the BIOS setting up cache line sizes
correctly. Are the "8"'s you've spotted due to drivers messing with the
cache line register or do they come from the BIOS?

> 2. Why is pdev_device_enable no longer used ?

I haven't written this function, but I guess it's expected to be called
from the architecture specific device enabling code and that some architectures
have to call it, some don't.

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
bug, n: A son of a glitch.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
