Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267545AbTA3Qsn>; Thu, 30 Jan 2003 11:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267547AbTA3Qsn>; Thu, 30 Jan 2003 11:48:43 -0500
Received: from fw-az.mvista.com ([65.200.49.158]:40188 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S267545AbTA3Qsm>; Thu, 30 Jan 2003 11:48:42 -0500
Message-ID: <3E39596E.4090300@mvista.com>
Date: Thu, 30 Jan 2003 09:57:18 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
CC: LKML <linux-kernel@vger.kernel.org>, brand@eeyore.valparaiso.cl
Subject: Re: New model for managing dev_t's for partitionable block devices
References: <200301291425.h0TEPQ9o001322@eeyore.valparaiso.cl>
In-Reply-To: <200301291425.h0TEPQ9o001322@eeyore.valparaiso.cl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Horst von Brand wrote:

>Steven Dake <sdake@mvista.com> said:
>  
>
>>I was thinking of an entirely new model for partitionable block devices. 
>>Here is how it would work:
>>
>>Each physical disk would be assigned a minor number in a group of 
>>majors.  So assume a major was chosen of 150, 151, 152, 153, there would 
>>be a total of 1024 physical disks that could be mapped.  Then the device 
>>mapper code could be used to provide partition devices in another 
>>major/group of majors.
>>
>>The advantage of this technique is that instead of wasting tons of 
>>minors on partitions that are never used, partitions could be 
>>dynamically allocated out of the minor list, allowing for thousands of 
>>disks with varying numbers of partitions each.  Further instead of each 
>>block device (such as i2o, scsi, etc) having their own set of majors for 
>>each partitionable disk (which wastes dev_t address space) everything 
>>would be compressed into the same set of majors.
>>    
>>
>
>Great idea! Add another partition, and the minors for everything else on
>the system change. Not!
>
It isn't minors that shouldn't change, it is the mapping of the 
filesystem device node to those minors.  This can be achieved by 
properly managing device naming in userspace automatically on partition 
updates, instead of using static naming such as /dev/sda which already 
has significant problems when devices are removed/inserted in hotswap 
environments.

The fact that minors change is irrelevant if proper steps are taken to 
ensure that those minors always map to the correct named device in user 
space.

Thanks
-steve

>  
>

