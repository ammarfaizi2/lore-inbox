Return-Path: <linux-kernel-owner+w=401wt.eu-S1751401AbXAKSq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbXAKSq7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 13:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbXAKSq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 13:46:59 -0500
Received: from gate.crashing.org ([63.228.1.57]:54121 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbXAKSq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 13:46:58 -0500
In-Reply-To: <20070111182041.GA6243@coresystems.de>
References: <13426df10701110939k21f7bb1dy38d2b34ca37a5a36@mail.gmail.com> <20070111182041.GA6243@coresystems.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e31af5463dc2a8d051b632f54e65decf@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       ron minnich <rminnich@gmail.com>,
       "OLPC Developer's List" <devel@laptop.org>,
       Mitch Bradley <wmb@firmworks.com>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Thu, 11 Jan 2007 19:47:10 +0100
To: Stefan Reinauer <stepan@coresystems.de>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'd like to put in my $.02 in favor of having a way to pass the OF
>> device tree to the kernel, in much the same way we pass stuff like
>> ACPI and PIRQ and MP tables now.
>
> This works fine for just passing the device tree, but it will fail for
> the next step of being able to use the firmware in the OS, and 
> returning
> sanely to the firmware.

Not everyone wants/needs that.  Flexibility is key.

>> - any path that uses kexec (since the first kernel probably shut down
>>   OF)
>
> No, that path works fine. The first kernel uses OFW, so it wont shut it
> down. Only thing is you need to pass the callback to the loaded kernel.

Depends.  The kernel _can_ shut down OF; in that case, it
becomes responsible for passing the device tree along to
the kexec'd kernel.

>> - etherboot
>
> ok, well.

Heh :-)

>> OFW is open source now. I think it's time to reexamine the basic
>> assumptions about the need for a callback, and see if something better
>> can't be done.
>
> I fully agree. And I believe there are very good things that can be 
> done
> with callbacks. The reasons callbacks are evil is that you dont know
> what you call into. This is not at all the case here. It's a mere
> function call that calls some highly board specific code, not unlike 
> all
> the calls we do in LinuxBIOS already today. Since we're 100% open
> source, we don't "cross a border" anymore.

Oh you *do* cross a border, and that is a good thing here; it
is a stable API, and that makes a lot of sense here.

> - 16bit legacy callbacks
> - (u)efi legacy callbacks
> - existing openfirmware support code for non-x86 platforms.
>
> But: It is a first step that, as a mid-term goal, allows us to unify 
> OFW
> support on all platforms to some extent.

Yes.

>> Mitch, is there some way to get OF device tree to the kernel without
>> involving a callback? That would be quite nice.
>
> That is a nice idea, but unless there is any LinuxBIOS version that
> creates such a device tree and exports it as a data structure to the 
> OS,
> why would we want to add such support to the Linux kernel?

The PowerPC arch code already handles this.


Segher

