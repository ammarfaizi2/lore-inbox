Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbVKCCcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbVKCCcI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 21:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbVKCCcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 21:32:07 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:54203 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1030278AbVKCCcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 21:32:06 -0500
Message-ID: <43093.192.168.0.12.1130985101.squirrel@192.168.0.2>
In-Reply-To: <20051102095139.GB30220@elf.ucw.cz>
References: <20051101234459.GA443@elf.ucw.cz>
    <20051102024755.GA14148@home.fluff.org>
    <20051102095139.GB30220@elf.ucw.cz>
Date: Wed, 2 Nov 2005 20:31:41 -0600 (CST)
Subject: Re: best way to handle LEDs
From: "John Lenz" <lenz@cs.wisc.edu>
To: "Pavel Machek" <pavel@suse.cz>
Cc: "Ben Dooks" <ben@fluff.org.uk>, vojtech@suse.cz, rpurdie@rpsys.net,
       "kernel list" <linux-kernel@vger.kernel.org>,
       "Russell King" <rmk@arm.linux.org.uk>
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, November 2, 2005 3:51 am, Pavel Machek said:
> Hi!
>
>> > I think even slow blinking was used somewhere. I have some code from
>> > John Lenz (attached); it uses sysfs interface, exports led collor, and
>> > allows setting different frequencies.
>> >
>> > Is that acceptable, or should some other interface be used?
>>
>> there is already an LED interface for linux-arm, which is
>> used by a number of the extant machines in the sa11x0 and
>> pxa range.
>
> Where is that interface? I think that making collie use it is obvious
> first step...
> 								Pavel
>

I originally wrote the collie led code to use that interface, and you
might look at some of the old versions of the patch on my web site.  The
actual code is in arch/arm/kernel/time.c, but this code calls out to an
individual machine function through say arch/arm/mach-sa1100/leds.c... 
The problem for collie was that the device model for locomo did not allow
an easy way to do it... as you can see, in my patch it implements a driver
for those leds and the driver model takes care of it.

I just looked, and
http://www.cs.wisc.edu/~lenz/zaurus/files/patch-2.6.7-jl2.diff.gz contins
the implementation of the arm led interface for collie.... not sure if it
will still work anymore, but...

I then grew the led code to support more than four leds, multi color leds,
more than just the arm architecture, etc... Russell has been very critical
of my patch on the "waste" of memory (a struct device for each led, along
with a bunch of struct attributes for each led), where by contrast the arm
one has a single attribute.

But this led interface and the one arm provides can almost not even be
compared.  My patch correctly implements the sysfs model of one attribute,
one file (instead of all leds controlled through a single file).  My patch
also is more flexible and provides needed options for many leds.  The
downside is, it makes the leds hard to use for debugging, which is the
primary purpose of the original arm led code.

For debugging, the arm specific led code is a great tool, and I am not
meaning to replace it.  For debugging, you can just specifiy
CONFIG_CLASS_LEDS=n.

John

