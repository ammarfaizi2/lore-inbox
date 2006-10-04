Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161599AbWJDQu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161599AbWJDQu6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161600AbWJDQu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:50:57 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:18900 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161599AbWJDQu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:50:56 -0400
Message-ID: <4523E66B.5090604@in.ibm.com>
Date: Wed, 04 Oct 2006 09:50:51 -0700
From: Suzuki Kp <suzuki@in.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060413 Red Hat/1.7.13-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Mouw <erik@harddisk-recovery.com>
CC: lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, andmike@us.ibm.com
Subject: Re: [RFC] PATCH to fix rescan_partitions to return errors properly
References: <452307B4.3050006@in.ibm.com> <20061004130932.GC18800@harddisk-recovery.com>
In-Reply-To: <20061004130932.GC18800@harddisk-recovery.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:
> On Tue, Oct 03, 2006 at 06:00:36PM -0700, Suzuki Kp wrote:
> 
>>Currently the rescan_partition returns 0 (success), even if it is unable
>>to rescan the partition information ( may be due to disks offline, I/O
>>error reading the table or unknown partition ). This would make ioctl()
>>calls succeed for BLKRRPART requests even if partitions were not scanned
>>properly, which is not a good thing to do.
>>
>>Attached here is patch to fix the issue. The patch makes
>>rescan_partition to return -EINVAL for unknown partitions and -EIO for
>>disk I/O errors ( or when disks are offline ).
> 
> 
> I don't think it's a good idea to return an error when there's an
> unknown partition table. How do you differentiate between a device that
> isn't partitioned at all and a device with an unknown partition table?

Returning -EINVAL in both the above cases would inform the user that, 
the partition table was not read properly due to an invalid arguemnt 
(the disk) passed, which holds good for both the above cases.

What do you think ?

> Better return 0 on an unknown partition table.
> 
> 
> Erik
> 

Suzuki
