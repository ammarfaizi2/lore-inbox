Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965354AbWH2UtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965354AbWH2UtH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 16:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965284AbWH2UtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 16:49:00 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:30147 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S965329AbWH2Us7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 16:48:59 -0400
Date: Tue, 29 Aug 2006 13:42:56 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Olaf Hering <olaf@aepfle.de>
cc: Michael Buesch <mb@bu3sch.de>, Greg KH <greg@kroah.com>,
       Oleg Verych <olecom@flower.upol.cz>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Sven Luther <sven.luther@wanadoo.fr>, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
In-Reply-To: <20060829201314.GA28680@aepfle.de>
Message-ID: <Pine.LNX.4.63.0608291341060.30381@qynat.qvtvafvgr.pbz>
References: <1156802900.3465.30.camel@mulgrave.il.steeleye.com> 
 <Pine.LNX.4.63.0608290844240.30381@qynat.qvtvafvgr.pbz>  <20060829183208.GA11468@kroah.com>
 <200608292104.24645.mb@bu3sch.de> <20060829201314.GA28680@aepfle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2006, Olaf Hering wrote:

> On Tue, Aug 29, Michael Buesch wrote:
>
>> On Tuesday 29 August 2006 20:32, Greg KH wrote:
>>> On Tue, Aug 29, 2006 at 08:46:45AM -0700, David Lang wrote:
>>>> On Mon, 28 Aug 2006, Greg KH wrote:
>>>>
>>>>> I think the current way we handle firmware works quite well, especially
>>>>> given the wide range of different devices that it works for (everything
>>>>> from BIOS upgrades to different wireless driver stages).
>>>>
>>>> the current system works for many people yes, but not everyone.
>>>>
>>>> I'm still waiting to find a way to get the iw2200 working without having to
>>>> use modules.
>>>
>>> Sounds like a bug you need to pester the iw2200 developers about then.
>>> I don't think it has much to do with the firmware subsystem though :)
>>
>> Well, yes and no.
>> The ipw needs the firmware on insmod time (in contrast to bcm43xx
>> for example, which needs it on ifconfig up time).
>> So ipw needs to call request_firmware at insmod time. In case of
>> built-in, that is when the initcall happens. No userland is available
>> and request_firmware can not call the userspace helpers to upload
>> the firmware to sysfs.
>
> I dont use nor do I have access ipw hardware, but:
> If it is an initcall, the initramfs should be usable at that time.
> A creative CONFIG_INITRAMFS_SOURCE= will help, add the firmware and a
> small helper that does the cat(1).
>

you are assuming that

1. modules are enabled and ipw2200 is compiled as a module

2. initrd or initramfs are in use

besides, several kernel versions ago this used to work. the current requirement 
is a regression as far as the user is concerned.

David Lang
