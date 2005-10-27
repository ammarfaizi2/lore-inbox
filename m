Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVJ0MtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVJ0MtN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 08:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVJ0MtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 08:49:13 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:32787 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750731AbVJ0MtN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 08:49:13 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <436026F2.1030206@rhla.com>
References: <435FC886.7070105@rhla.com> <Pine.LNX.4.61.0510261523350.6174@chaos.analogic.com> <4360261E.4010202@rhla.com> <436026F2.1030206@rhla.com>
X-OriginalArrivalTime: 27 Oct 2005 12:49:08.0468 (UTC) FILETIME=[D2472340:01C5DAF4]
Content-class: urn:content-classes:message
Subject: Re: Kernel Panic + Intel SATA
Date: Thu, 27 Oct 2005 08:49:06 -0400
Message-ID: <Pine.LNX.4.61.0510270839130.9512@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel Panic + Intel SATA
Thread-Index: AcXa9NJOgzSiKPLISKCajdMNN7DTxQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Marcio Oliveira" <moliveira@rhla.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Oct 2005, Marcio Oliveira wrote:

> linux-os (Dick Johnson) wrote:
>
>> On Wed, 26 Oct 2005, [iso-8859-1] Márcio Oliveira wrote:
>>
>>
>>
>>> Hi there!
>>>
>>> I have a IBM ThinkPad t43 running Fedora Core  Linux 4 and kernel
>>> 2.6.12-1.146_FC4. I recompiled the kernel (2.6.13.4 - kernel.org) and I
>>> am geting the following message when the computer boots:
>>>
>>> Creating root device
>>> mkrootdev: label / not found
>>>
>>>
>>
>> This label was no good it needs to be /dev/sda6 from your fstab
>> You will need to put the device name in /boot/*/*.conf lilo or
>> grub instead on "label"
>>
>>
> yeah, I try to boot it using "root=/dev/sda6" instead "root=LABEL=/"
> parameter, but the system still not booting...
>
>>
>>
>>> Mounting root filesystem
>>> mount: error 2 mouting ext3
>>>
>>>
>>
>> Error 2 == ENOENT
>>
>>
>
> ENOENT? What it means?

Was 'no such file', perhaps the device file was not created by `mkrootdev`
because it errored out???

This is all 'Fedora' stuff, not Linux stuff. You should upgrade
your 'mkinitrd' (or rewrite it) so it doesn't use Fedora-specific
stuff if you intend to install an un-patched kernel.


>
>>
>>
>>> Switchimg to new root
>>> ERROR opening /dev/console!!!!: 2
>>> switchroot: mount failed: 22
>>>
>>>
>>
>> Error 22 = EINVAL
>>
>>
>
> EINVAL? What it means?
>

Means 'wrong value'. Probably because the new root wasn't
mounted.

[SNIPPED...]


In the meantime do:

mknod /dev/sda6 b 8 6
mknod /dev/root b 8 6

.. in your initrd script. This should get you past the errors.


>>> mount -o mode=0755 -t tmpfs /dev /dev
>>> mknod /dev/console c 5 1
>>> mknod /dev/null c 1 3
>>> mknod /dev/zero c 1 5
>>> mkdir /dev/pts
>>> mkdir /dev/shm
>>> echo Starting udev
>>> /sbin/udevstart
>>> echo -n "/sbin/hotplug" > /proc/sys/kernel/hotplug
>>> echo "Loading scsi_mod.ko module"
>>> insmod /lib/scsi_mod.ko
>>> echo "Loading sd_mod.ko module"
>>> insmod /lib/sd_mod.ko
>>> echo "Loading libata.ko module"
>>> insmod /lib/libata.ko
>>> echo "Loading ata_piix.ko module"
>>> insmod /lib/ata_piix.ko
>>> echo "Loading dm-mod.ko module"
>>> insmod /lib/dm-mod.ko
>>> sleep 10
>>> /sbin/fdisk -l
>>> sleep 10
>>> /sbin/udevstart
>>> echo Creating root device
>>> mkrootdev /dev/root
>>> echo Mounting root filesystem
>>> mount -o defaults --ro -t ext3 /dev/root /sysroot
>>> echo Switching to new root
>>> switchroot --movedev /sysroot

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
