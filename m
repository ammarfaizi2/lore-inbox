Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVC2QJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVC2QJw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 11:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVC2QJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 11:09:52 -0500
Received: from main.gmane.org ([80.91.229.2]:41176 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261178AbVC2QJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 11:09:48 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed L Cashin <ecashin@coraid.com>
Subject: Re: [PATCH 2.6.11] aoe [7/12]: support configuration of
 AOE_PARTITIONS from Kconfig
Date: Tue, 29 Mar 2005 11:06:16 -0500
Message-ID: <87hdiuv3lz.fsf@coraid.com>
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com>
	<1111677688.29912@geode.he.net> <20050328170735.GA9567@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
Cc: Christoph Hellwig <hch@infradead.org>, Greg K-H <greg@kroah.com>
X-Gmane-NNTP-Posting-Host: adsl-34-234-30.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:b+KNK0BJnW2VQ/f+NjmIPpiXTxg=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Thu, Mar 24, 2005 at 07:21:28AM -0800, ecashin@noserose.net wrote:
>> 
>> support configuration of AOE_PARTITIONS from Kconfig
>> 
>> Signed-off-by: Ed L. Cashin <ecashin@coraid.com>
>> 
>> diff -uprN a/drivers/block/Kconfig b/drivers/block/Kconfig
>> --- a/drivers/block/Kconfig	2005-03-07 17:37:58.000000000 -0500
>> +++ b/drivers/block/Kconfig	2005-03-10 12:19:54.000000000 -0500
>> @@ -506,4 +506,19 @@ config ATA_OVER_ETH
>>  	This driver provides Support for ATA over Ethernet block
>>  	devices like the Coraid EtherDrive (R) Storage Blade.
>>  
>> +config AOE_PARTITIONS
>> +	int "Partitions per AoE device" if ATA_OVER_ETH
>> +	default "16"
>> +	help
>> +	  The default is to support 16 partitions per aoe device. Some
>> +	  systems lack good support for devices with large minor
>> +	  numbers.
>> +
>> +	  Such systems will be able to use more aoe disks when
>> +	  AOE_PARTITIONS is set to one, but you won't be able to
>> +	  partition the disks, and you must make sure your device
>> +	  nodes are created to work with the value you select.
>> +
>> +	  If unsure, use 16.
>> +
>
> NACK.  this changes devices nodes based on a compile-time option.  

I'm not sure I follow.  This configuration option sets the number of
partitions per device in the driver.  It doesn't create device nodes.

If the user has udev, then the device nodes are created correctly (on
Fedora Core 3), so that if the driver is configured with 1 partition
per device, the minor numbers for the disks are low.  

The folks I've talked to who aren't using udev but want one partition
per device already know that they have to re-create their device
files.

> Just tell people to update their userland to a 2.6-copatible
> version.

Even if the glibc, coreutils, etc., get it right, some programs try to
parse the device node bits themselves and fail to find all the minor
number bits.

Making this configurable makes it possible for a debian sarge user or
a Slackware 10 user to run a 2.6.11 kernel and use up to 256 disks.
Even a Fedora Core 3 user has an mdadm that balks at minor numbers
like 1120.  By using one partition per device, I can use FC3's mdadm
and have everything work.

The AoE users started doing this themselves, but this configuration
option allows non-C-programmers to do the same.  It's helpful during
the transitional period and should be removed when the userland
software that people are actually running has caught up.

-- 
  Ed L Cashin <ecashin@coraid.com>

