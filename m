Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269675AbUISAGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269675AbUISAGn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 20:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269681AbUISAGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 20:06:43 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:731 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S269675AbUISAGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 20:06:38 -0400
Message-ID: <414CCD88.30001@softhome.net>
Date: Sun, 19 Sep 2004 02:06:32 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla Thunderbird 0.8 (Macintosh/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: udev is too slow creating devices
References: <414C9003.9070707@softhome.net> <20040918213023.GB1901@kroah.com>
In-Reply-To: <20040918213023.GB1901@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Well, I got your point.
   I promise I will not use udev ;-)

   For last embedded system where I have had external usb storage used 
for firmware upgrade, I used preloading of usb-storage - and everything 
worked well. Seems it worked better than udev will ever worked - with 0 
user space calls and immediate accessibility of /dev/sda ;-)))

   I will not try to argue, it is rather pointless for me at moment, 
being unemployed and far from any of my systems.

P.S. Funny diversion from OpenBSD thinking. OpenBSD intentionally do not 
support loadale modules, to prevent _any_ user space attempt to modify 
running kernel.

P.P.S. Another day, I hope, you will understand that right system need 
to provide people with two opposite ways of doing things. Sometimes it 
is advantage to be event-based and asynchronous, sometimes it is very 
convient to be dumb & synchronous. This two options are not mutually 
exclusive. I/O subsystem does both ways: you can be dumb and synchronous 
with read() (as most applications do - regardless of actual I/O being 
event-driven), or asynchronous with aio_* stuff (sacrificing simplicity 
of application). Giving a choice is right way to go.

Greg KH wrote:
> On Sat, Sep 18, 2004 at 09:44:03PM +0200, Ihar 'Philips' Filipau wrote:
> 
>>>That will be soon going away with my multi-threaded device discovery
>>>work.  And I run pci hotplug boxes (and so do all of the PCMCIA/CardBus
>>>users), so don't discard PCI from being a async bus type :)
>>>
>>>Async is now the norm, and drivers like the microcode module are the
>>>exception.
>>
>>  I wanted you to say that.
>>
>>  That's wrong attitude. I'm working on workstation where 95% of 
>>hardware plugged 100% of time. That's not exception. Not eerything is 
>>hot-pluggable USB/FireWire/whatever.
> 
> 
> Do you have PCI devices?  pnp-isa devices?  Ok, those all are
> "hotpluggable" as far as the kernel is concerned.  They are loaded on
> demand by userspace when the kernel sees the device.
> 
> If not, what kind of devices do you have?  The only place the
> "on-demand" loading of modules doesn't work is for embedded systems that
> have no way of discovering their devices, and need to be hardcoded in
> the kernel.  But people are working on that :)
> 
> 
>>  Event-based hot-plug scripts are great thing. As an implementation. 
>>But user cares about one thing: 'modprobe usb-storage; mount /whatever' 
>>working reliably.
> 
> 
> No, they want to plug in their device and have the proper module
> automatically loaded, and then the device mounted and the icon show up
> on their desktop all automatically.  With hotplug and its helpers (udev,
> /etc/dev.d/ and HAL) this all works just fine today.
> 
> 
>>  /etc/dev.d probably great thing - but I'm not going to implement FSM 
>>into every shell script which does modprobe for sake being Ok with 
>>dynamic /dev/.
> 
> 
> Fine, I'm not forcing you to do anything you don't want to do.  It
> sounds like you like polling for your device nodes.  Great, live with
> that, it is one way to do this :)
> 
> 
>>  You need to change your attitude for first.
> 
> 
> Change it to what?  A combative one?  Gladly :)
> 
> 
>>For second - come up with a way for user space to block until device
>>is here, and if it is not here/error detected - fail.
> 
> 
> Please explain (with code) how to do that for something as "simple" as
> the usb-storage driver.  Then we can continue this discussion.
> 
> 
>>  As it was said before - /all/ we need, is to be able to tell 
>>discovery phase from idle state of driver. "/All/" is quite much here - 
>>but it must be a goal.
> 
> 
> Wrong.  Our goal is to make Linux "just work".  And that is what is
> happening today.  This "wait for modprobe" stuff helps no one.
> 
> 
>>  I'm absolutely sure, that for PCI devices it is implementable quite 
>>easy - probing is already done outside of modules. And we know precisely 
>>are we Ok, or are we not. And we know when we are done. If it is not so 
>>for USB yet - then it is bug which must be fixed.
> 
> 
> PCI and USB both use the same probe core code.  So it works the same :)
> 
> You think you are grumpy now, just wait till I add threads to the probe
> code...
> 

   If you are not  yet threaded - so that must be done.
