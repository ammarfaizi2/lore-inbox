Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSIDSPU>; Wed, 4 Sep 2002 14:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSIDSPT>; Wed, 4 Sep 2002 14:15:19 -0400
Received: from pheriche.sun.com ([192.18.98.34]:27593 "EHLO pheriche.sun.com")
	by vger.kernel.org with ESMTP id <S313628AbSIDSPR>;
	Wed, 4 Sep 2002 14:15:17 -0400
Message-ID: <3D764EC7.2040306@sun.com>
Date: Wed, 04 Sep 2002 11:19:51 -0700
From: Tim Hockin <thockin@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Hockin <thockin@sun.com>
CC: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-390@vm.marist.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH} s390x sys32 duplicated code cleanup (was [PATCH RFC]
 s390x sys32...)
References: <OFAA4E270B.0BB4F82F-ONC1256C22.00285512@de.ibm.com> <3D6D6DDA.5080907@sun.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
> Martin Schwidefsky wrote:
> 
>>> It seems to me that if we do:
>>> * s390x defines CONFIG_UID16
>>> * typedef __kernel_old_gid_t to u16
>>> * get rid of all the sys32_*16 stuff and just call the uid16.c function
>>
>>
>> I checked the code and didn't find any reason why this shouldn't work.
>> In fact with the 31 bit emulation layer the 64 bit kernel does need the
>> 16 bit uid/gid system calls although only for the emulation. To make it
>> really perfect you could define CONFIG_UID16 dependent on
>> CONFIG_S390_SUPPORT. This saves a few bytes in the image if the emulation
>> support is not enabled.

Uggh, DaveM pointed out a very good issue with this fix (similar for 
Sparc64) and core files.  Core files will now have truncated uid/gid 
values because fs/binfmt_elf calls NEW_TO_OLD_UID().  May be other 
places, too.

I guess you should not apply this patch until I've had a better think 
about it.

Tim




-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Linux Kernel Engineering
thockin@sun.com

