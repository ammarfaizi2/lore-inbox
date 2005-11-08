Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbVKHA1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbVKHA1p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 19:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbVKHA1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 19:27:44 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:42909 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1030205AbVKHA1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 19:27:44 -0500
Message-ID: <52781.192.168.0.12.1131409634.squirrel@192.168.0.2>
In-Reply-To: <20051107233000.GC2034@elf.ucw.cz>
References: <20051101234459.GA443@elf.ucw.cz>
    <20051102024755.GA14148@home.fluff.org>
    <20051102095139.GB30220@elf.ucw.cz>
    <43093.192.168.0.12.1130985101.squirrel@192.168.0.2>
    <20051107233000.GC2034@elf.ucw.cz>
Date: Mon, 7 Nov 2005 18:27:14 -0600 (CST)
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

On Mon, November 7, 2005 5:30 pm, Pavel Machek said:
> Hi!
>
>> >> > I think even slow blinking was used somewhere. I have some code
>> from
>> >> > John Lenz (attached); it uses sysfs interface, exports led collor,
>> and
>> >> > allows setting different frequencies.
>> >> >
>> >> > Is that acceptable, or should some other interface be used?
>> >>
>> >> there is already an LED interface for linux-arm, which is
>> >> used by a number of the extant machines in the sa11x0 and
>> >> pxa range.
>> >
>> > Where is that interface? I think that making collie use it is obvious
>> > first step...
>>
>> I originally wrote the collie led code to use that interface, and you
>> might look at some of the old versions of the patch on my web site.  The
>> actual code is in arch/arm/kernel/time.c, but this code calls out to an
>> individual machine function through say arch/arm/mach-sa1100/leds.c...
>> The problem for collie was that the device model for locomo did not
>> allow
>> an easy way to do it... as you can see, in my patch it implements a
>> driver
>> for those leds and the driver model takes care of it.
>>
>> I just looked, and
>> http://www.cs.wisc.edu/~lenz/zaurus/files/patch-2.6.7-jl2.diff.gz
>> contins
>> the implementation of the arm led interface for collie.... not sure if
>> it
>> will still work anymore, but...
>
> It does, after kconfig fixups. Do you think we could get that merged?
> Some led driver is better than none at all.

I wonder, because we are exporting an API to userspace.  I don't think the
openembedded people want to use this API, and will hold off doing anything
with the leds till we get something else straigtend out.  If we have this
API now, we will have issues breaking it later (or we will have to do some
wierd locking scheme to allow both interfaces control, and crap like
that).

Secondly, leds aren't that importent unless they are supported by the
userspace programs (to do things like blink when email shows up).  And
before the userspace starts using leds, I think they might want to clear
up the interface API issue first.

John

