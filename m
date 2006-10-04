Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422645AbWJDRma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422645AbWJDRma (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422644AbWJDRmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:42:14 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:12765 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161469AbWJDRhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:37:51 -0400
Message-ID: <4523F16D.5060808@in.ibm.com>
Date: Wed, 04 Oct 2006 10:37:49 -0700
From: Suzuki Kp <suzuki@in.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060413 Red Hat/1.7.13-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Mouw <erik@harddisk-recovery.com>
CC: lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, andmike@us.ibm.com
Subject: Re: [RFC] PATCH to fix rescan_partitions to return errors properly
References: <452307B4.3050006@in.ibm.com> <20061004130932.GC18800@harddisk-recovery.com> <4523E66B.5090604@in.ibm.com> <20061004170827.GE18800@harddisk-recovery.nl>
In-Reply-To: <20061004170827.GE18800@harddisk-recovery.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:
> On Wed, Oct 04, 2006 at 09:50:51AM -0700, Suzuki Kp wrote:
> 
>>Erik Mouw wrote:
>>
>>>On Tue, Oct 03, 2006 at 06:00:36PM -0700, Suzuki Kp wrote:
>>>
>>>
>>>>Currently the rescan_partition returns 0 (success), even if it is unable
>>>>to rescan the partition information ( may be due to disks offline, I/O
>>>>error reading the table or unknown partition ). This would make ioctl()
>>>>calls succeed for BLKRRPART requests even if partitions were not scanned
>>>>properly, which is not a good thing to do.
>>>>
>>>>Attached here is patch to fix the issue. The patch makes
>>>>rescan_partition to return -EINVAL for unknown partitions and -EIO for
>>>>disk I/O errors ( or when disks are offline ).
>>>
>>>I don't think it's a good idea to return an error when there's an
>>>unknown partition table. How do you differentiate between a device that
>>>isn't partitioned at all and a device with an unknown partition table?
>>
>>Returning -EINVAL in both the above cases would inform the user that, 
>>the partition table was not read properly due to an invalid arguemnt 
>>(the disk) passed, which holds good for both the above cases.
>>
>>What do you think ?
> 
> 
> I disagree. It's perfectly valid for a disk not to have a partition
> table (for example: components of a RAID5 MD device) and we shouldn't
> scare users about that. Also an unrecognised partition table format
> (DEC VMS, Novell Netware, etc.) is not a reason to throw an error, it's
> just unrecognised and as far as the kernel knows it's unpartioned.

Erik,

Thank you very much for the clarification.

But don't you think that, we should let know the user that he/she is 
trying to re-read a partition table from a device, which doesn't have it 
or is not useful for the kernel or to him, rather than making him happy 
with a success ?
> 
> It's OK to tell the user that there was some kind of device error when
> scanning the partition table but IMHO an unpartitioned disk is not a
> device error.
> 
> 
> Erik
> 
Thanks,

Suzuki
