Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWAVW1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWAVW1t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 17:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWAVW1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 17:27:49 -0500
Received: from savages.net ([66.93.39.90]:10933 "EHLO mail.savages.net")
	by vger.kernel.org with ESMTP id S932171AbWAVW1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 17:27:48 -0500
Message-ID: <43D4BF29.5090208@savages.net>
Date: Mon, 23 Jan 2006 03:34:01 -0800
From: Shaun Savage <savages@savages.net>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1.centos4 (X11/20051007)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phillip Susi <psusi@cfl.rr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: CBD Compressed Block Device, New embedded block device
References: <43D3467C.7010803@tvlinux.org> <43D3A9D1.2060800@cfl.rr.com>
In-Reply-To: <43D3A9D1.2060800@cfl.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CBD is designed for embedded systems.  The compression starts off the 
similar to cloop, The filesystem partitions are created in files,  These 
partition files are broken into 32K blocks( the window size of gzip).   
Now there is a compressed file  and a array of start  locations. This is 
placed into a  CBD  partition package  (CBDpp), by adding a header. This 
header includes version, hash, signature,.... 

The flash device is divided 64K blocks,  you can think of these as 
sectors.  There is a user program that writes new CBDpp  to these 
blocks.  The CBDpp are run length encoded. There is a table of which 
blocks are used by the CBDpp in the header of the CBDpp.  On startup the 
driver searches the blocks for the MAGIC header.  When it finds one it 
read the header and maps which blocks holds the CBDpp.  The driver then 
does not search thoses blocks.  Empty block devices are slow to boot 
while full ones are fast.

There is a patch for GRUB that know about the CBD headers.  It search 
for the latest and greatest version of the CBDpp.  The allows for in the 
field system update.

partition 0 is the bootloader and kernel, and othe global system stuff.
partition 1 is the root file system

The one unique feature is any filesystem can be on top AND it support 
writes!!   Now the write never make it to the physical device, but the 
write data is locked in buffer cache.  Yes I know this can be a memory 
leak, but in an embedded device the writes are configuration and patches.

I received lots of email on how to improve the code, Which I am doing.  
I will answer your emails in how fast I can make those changes.

shaun


Phillip Susi wrote:

> How is this different from cloop or dm-crypt?
>
> Shaun Savage wrote:
>
>> HI
>>
>> Here is a patch for 2.6.14.5 of CBD
>> CBD is a compressed block device that is designed to shrink the file 
>> system size to 1/3 the original size.  CBD is a block device on a 
>> file system so, it also allows for in-field upgrade of file system.  
>> If necessary is also allows for secure booting, with a GRUB patch.
>>
>> Reply to email please.
>>
>> Shaun Savage
>
>

