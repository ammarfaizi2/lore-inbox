Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWH3VSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWH3VSY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 17:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWH3VSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 17:18:24 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:30169 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932071AbWH3VSX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 17:18:23 -0400
Date: Wed, 30 Aug 2006 14:11:51 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Sven Luther <sven.luther@wanadoo.fr>
cc: Olaf Hering <olaf@aepfle.de>, Michael Buesch <mb@bu3sch.de>,
       Greg KH <greg@kroah.com>, Oleg Verych <olecom@flower.upol.cz>,
       James Bottomley <James.Bottomley@steeleye.com>,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
In-Reply-To: <20060830205739.GA26475@powerlinux.fr>
Message-ID: <Pine.LNX.4.63.0608301408590.31356@qynat.qvtvafvgr.pbz>
References: <20060829183208.GA11468@kroah.com>  <200608292104.24645.mb@bu3sch.de>
 <20060829201314.GA28680@aepfle.de>  <Pine.LNX.4.63.0608291341060.30381@qynat.qvtvafvgr.pbz>
  <20060830054433.GA31375@aepfle.de>  <Pine.LNX.4.63.0608301048180.31356@qynat.qvtvafvgr.pbz>
  <20060830181310.GA11213@powerlinux.fr>  <Pine.LNX.4.63.0608301119170.31356@qynat.qvtvafvgr.pbz>
  <20060830191544.GA17203@powerlinux.fr>  <Pine.LNX.4.63.0608301219520.31356@qynat.qvtvafvgr.pbz>
 <20060830205739.GA26475@powerlinux.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006, Sven Luther wrote:

>> no, at least not in the current kernel. as was mentioned earlier in this
>> thread the ipw2200 needs the firmware at initialization, but some others
>> don't need it until open. I don't know if it's even possible to re-write
>> the driver to do this.
>
> Oh well, this doesn't explain why it is so, but i suppose you know what you
> speak about.

I'm a user, not a developer. I know what is, but not nessasarily why, and I have 
no idea how bad it would be to change.

>>> If we want to remove it, then we put, not the module, but the firmware
>>> itself
>>> with some basic userspace to load it on demand in the initramfs, and this
>>> is
>>> reason enough to create an initramfs. The fact that the builtin device is
>>> initialized before the initramfs is loaded seems like a bug to me, since
>>> the
>>> idea of the initramfs (well, one of them at least), was to initialize it
>>> early
>>> enough for this kind of things.
>>
>> this isn't my understanding.
>
> Indeed, in the initrd era, the ramdisk was initialized too late for this kind
> of stuff, but it was one of the features of the initramfs ramdisks to
> initialize it earlier, which made firmware loading possible.
>
>> my understanding is that the kernel fully initializes all built-in drivers,
>> then loads userspace and starts running it.
>
> Well, there is userspace and userspace.
>
>> that userspace can be on a device that it knows how to read, or it can be
>> userspace on initramfs so that you can load additional modules to give you
>> access to the hardware that you want to run on.
>
> Yep, but initramfs is initialized ways earlier than normal userspace.
>
>> however this is not soon enough to supply the firmware for devices like
>> this.
>
> Are you sure of this ? This is somewhat contrary to what i have heard, and it
> sure would make sense to be able to access the initramfs ramdisk much earlier.

I could easily be wrong about this. can someone who really knows weigh in on 
this?

>>> If on the other side, it is more important to not have an initramfs
>>> (because
>>> of security issues, or bootloader constraints or what not), then sure,
>>> there
>>> is not much choice than putting the firmware in the driver or in the kernel
>>> directly.
>>>
>>> But again, the initramfs is just a memory space available at the end of the
>>> kernel, and there is no hardware-related constraint to access it which are
>>> in
>>> any way different from having the firmware linked in together with the
>>> kernel,
>>> so it is only a matter of organisation of code, as well as taking a
>>> decision
>>> on the above, and to act accordyingly.
>>
>> if the firmware needed for any drivers compiled in was appended to the
>> kernel the same way that initramfs is, without requireing the other things
>> needed to make initrmfs useable I think that would be reasonable (bundling
>> them togeather as opposed to embedding the firmware in the kernel). it may
>> even be possible to have the firmware as files in a initramfs that contains
>> nothing else, and the kernel knows how to read the data directly (without
>> the hotplug firmware request userspace stuff)
>
> Indeed, and it seems to me that exactly this kind of use was indeed considered
> when the initramfs infrastructure was designed. Not sure about the latest bit
> concerning hotplug though.

this gets back to the question of how early this early userspace is

David Lang
