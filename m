Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSGMT0H>; Sat, 13 Jul 2002 15:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSGMT0G>; Sat, 13 Jul 2002 15:26:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60677 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315370AbSGMT0F>;
	Sat, 13 Jul 2002 15:26:05 -0400
Message-ID: <3D307F68.7080703@mandrakesoft.com>
Date: Sat, 13 Jul 2002 15:28:40 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Matt_Domsch@Dell.com, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Removal of pci_find_* in 2.5
References: <F44891A593A6DE4B99FDCB7CC537BBBB0724D1@AUSXMPS308.aus.amer.dell.com>	<3D2FAF94.7070100@mandrakesoft.com>	<1026570939.9958.92.camel@irongate.swansea.linux.org.uk> 	<3D304940.7020207@mandrakesoft.com> <1026579995.13885.8.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sat, 2002-07-13 at 16:37, Jeff Garzik wrote:
> 
>>My point is that depending on any method of internal kernel ordering is 
>>fragile.
> 
> Its actually -extremely- reliable. Simply because we've kept the
> behaviour constant over time.

For the user, agreed.  For the kernel hacker, it's a fragile balance 
trying to keep the user presentation constant.  And we haven't always 
been successful.


>>I would rather have the kernel export which drives are listed in CMOS / 
>>BIOS ROM, and let userspace say "my boot drive is the nth BIOS-listed 
>>drive."  For example, looking through the aic7xxx (or was it 
> 
> 
> There is a BIOS extension for this (EDID 3.0 I believe). It only
> addresses where the boot device went, not how to sort the IDE device
> ordering and the like
> 
> 
>>Depending on pci_find_* ordering is very situation-dependent, and only 
>>covers N cases.  Then you have another N cases covered by the order in 
>>which you modprobe key drivers.  Then you have another N cases covered 
> 
> 
> Forget about modprobe. The areas this bites people are areas where the
> ordering is compiled in stuff (eg IDE) and where you have multiple of
> the same controller.

sorry for the confusion, I really equate modprobe and link order -- they 
both define overall order of initialization.


> A good example here is that many systems order devices internally based
> on mainboard versus external. Dell do this a lot. That ordering happens
> not to be the pci scan order some times.
> 
> Even with BIOS help you have to know this. And with only the basic BIOS
> you have to know the full ROM initialisation ordering, which is -very-
> non trivial for complex systems.
[...]
> Finding the rootfs by label is a minor problem, figuring out how to name
> the controllers consistently between 2.2/2.4/2.6 is a showstopper in the
> real world even if its not in happy hackerdom.


Everything you are saying here just convinces me more than we should do 
this stuff in initramfs.  At the summit Linus endorsed using 
/sbin/hotplug when storage devices appear... combine that with 
initramfs, and you should have all you need to handle whatever complex 
scenario you come up with.  It sounds straightforward to have some 
find-the-root-device code in initramfs that can contain "if 
(dell_mainboard)" code all over the place.

	Jeff


