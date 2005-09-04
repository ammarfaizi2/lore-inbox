Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbVIDRW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVIDRW2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 13:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbVIDRW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 13:22:28 -0400
Received: from alpha.polcom.net ([217.79.151.115]:48517 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S932076AbVIDRW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 13:22:27 -0400
Date: Sun, 4 Sep 2005 19:22:15 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Giampaolo Tomassoni <g.tomassoni@libero.it>, linux-kernel@vger.kernel.org,
       linux-atm-general@lists.sourceforge.net
Subject: Re: [ATMSAR] Request for review - update #1
In-Reply-To: <200509041754.54995.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.63.0509041904390.29195@alpha.polcom.net>
References: <NBBBIHMOBLOHKCGIMJMDGEHPEKAA.g.tomassoni@libero.it>
 <200509041720.55588.s0348365@sms.ed.ac.uk> <Pine.LNX.4.63.0509041830270.29195@alpha.polcom.net>
 <200509041754.54995.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Sep 2005, Alistair John Strachan wrote:

> On Sunday 04 September 2005 17:41, Grzegorz Kulewski wrote:
>> On Sun, 4 Sep 2005, Alistair John Strachan wrote:
>>> On Sunday 04 September 2005 12:05, Giampaolo Tomassoni wrote:
>>>> Dears,
>>>>
>>>> thanks to Jiri Slaby who found a bug in the AAL0 handling of the ATMSAR
>>>> module.
>>>>
>>>> I attach a fixed version of the atmsar patch as a diff against the
>>>> 2.6.13 kernel tree.
>>>
>>> [snip]
>>>
>>> Just out of curiosity, is there ANY reason why this has to be done in the
>>> kernel? The PPPoATM module for pppd implements (via linux-atm) a
>>> completely userspace ATM decoder.. if anything, now redundant ATM stack
>>> code should be REMOVED from Linux!
>>>
>>> Most distributions (to my knowledge) supporting the speedtouch modem do
>>> so using the method prescribed on speedtouch.sf.net; an entirely
>>> userspace procedure. pppd does all the ATM magic.
>>>
>>> Does this have real-world applications beyond the Speedtouch DSL modems?
>>> If not, I propose adding this code to linux-atm, not the kernel, since
>>> most users of USB speedtouch DSL modems will not be using the kernel's
>>> ATM.
>>
>> I am using SpeedTouch 330 modem with kernel driver (on Gentoo).
>>
>> The instalation is currently (with firmware loader instead of modem_run)
>> very simple: USE="atm" emerge ppp, download firmware and place it in
>> /lib/firmware, compile the kernel with speedtch support.
>
> Compared to "place the firmware in /lib/firmware" on many other distros, this
> sounds like a lot of work! The kernel speedtch provides no advantages to its
> userspace alternative.

Are you saying that you do not need to install ppp and compile (or install 
binary) kernel on other distros???


>> I tried to use userspace driver some time ago but it wasn't working for me
>> so I gave up. I was using modem_run with kernel driver for long time to
>> load the firmware but there were many problems with it too (nearly every
>> kernel or modem_run upgrade was breaking something, modem_run was hanging
>> in D state in most unapropriate moments and so on).
>
> This is not the case any longer.

Maybe. But there were many bugs in modem_run, usbfs, usb drivers in 
kernel, ACPI, IRQ routing and so on. They caused modem_run to hang or do 
something stupid without even telling user what is broken. In my 
experience when one bug was fixed other appeared in the next kernel. So 
even if now everything works ok you have no guarantee that next release 
won't break something... :)


>> Now I am using pure kernel driver and firmware loader and it works 100%
>> ok. There were no problems with it for long time. And I don't even want to
>> look at this userspace driver again.
>
> Conversely people (including myself) found the kernel implementation to be
> buggy, and when userspace breaks, you can simply restart it.. when the kernel
> breaks, you have to reboot.

1. But you still use the kernel even with userspace driver. So it still 
can break forcing you to reboot.
2. I have no problems with kernel driver. All problems that I saw in the 
past were problems in other subsystems (usbfs, usb drivers, ACPI, IRQ, ...).
3. Restarting modem_run was never enought for me. I always at least had to 
unplug the modem from USB port. Or more often reboot. So I see no gain 
here.

>> Since Linux newer was (or is going to be) userspace-driver OS, maybe we
>> should leave it that way...
>
> No.
>
> What can be done in userspace, within valid performance constraints, usually
> should be. This has always been the Linux kernel way.

But not device drivers. I do not think that Linux has good infrastructure 
for drivers in userspace (yes I know that there are some). Also are you 
sure that performance and latencies are ok with userspace driver even if 
system is under load?


> The speedtouch modem is a USB device, and there are many existing userspace
> "driver" implementations for USB devices. Including speedtouch.
>
> I'm not necessarily saying this code shouldn't be in the kernel, I'd just be
> interested to know why it has to be.

Well, as you are saing it hasn't... :)  But since it is there and works 
for me I am interested in not changing this state without really good 
reason.


Grzegorz Kulewski

