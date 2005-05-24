Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbVEXPdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVEXPdq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVEXPcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:32:32 -0400
Received: from alog0402.analogic.com ([208.224.222.178]:29070 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262105AbVEXPbJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:31:09 -0400
Date: Tue, 24 May 2005 11:30:28 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Paul Rolland <rol@as2917.net>
cc: Linux kernel <linux-kernel@vger.kernel.org>, rol@witbe.net
Subject: Re: Linux and Initrd used to access disk : how does it work ?
In-Reply-To: <200505241519.j4OFJUR24338@tag.witbe.net>
Message-ID: <Pine.LNX.4.61.0505241125500.16448@chaos.analogic.com>
References: <200505241519.j4OFJUR24338@tag.witbe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 May 2005, Paul Rolland wrote:

> Hello Dick,
>
>> initrd means Initial RAM disk.
>>
>> The boot image is put onto your Hard disk. The hard disk needs
>> to be accessible from the BIOS to boot from it. Most controllers
>> have a BIOS module that lets it be accessed during boot so you
>> don't need a chicken before the egg to start the boot.
>
> Ok, basically, the trick is that the BIOS knows how to access the
> disk, and Linux doesn't because it doesnt use the BIOS ? Or is it
> some more subtle (though I doubt) thing in which only a part of the
> disk can be accessed by the BIOS.
>

Linux needs to load a driver before it can access the disk. The
BIOS only works for 16-bit real-mode access.

>> Then, when booting, LILO or grub starts linux which uncompresses
>> a RAM disk and mounts it instead of your hard disk. A special
>> version of `init` (called nash) gets started which reads a script
>> called linuxrc. It contains commands like:
> Yes, I've seen that in my .img file...
>
>> The module(s) are in the /lib directory of the RAM disk.
>> They are put there by a build-script that installs initrd.
>> This script gets executed when you do 'make install' in
>> the kernel directory. If you have private modules, you
>> can copy them to the appropriate /lib/modules/`uname
>> -r`/kernel/drivers
>> directory. You put the module(s) name(s) you need to boot
>> in /etc/modprobe.conf or /etc/modules.conf (depends upon the
>> module tools version) as:
>>
>> alias scsi_hostadapter aic7xxx
>> alias scsi_hostadapter1 ata_piix
>>
>> ... any scsi_hostadapter stuff will be put into initrd when
>> you execute the script, /sbin/mkinitrd.
>>
>
> Hmmm... I didn't know this part, thanks for the details.
>
> So, it seems that I'm stuck with my binary module unless I can find a
> way to tell the kernel to use the BIOS to access the disk ;-)))
>

No. You are "stuck with a driver" just like everybody else. You
either have drivers built-in (getting rare, because there are so
many), or you load a driver while booting. This is the usual
way. From the boot perspective, it doesn't matter if the module
is a 'binary' one or a GPL one.

> Cheers,
> Paul
>
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
