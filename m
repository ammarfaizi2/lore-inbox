Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135706AbREBSFk>; Wed, 2 May 2001 14:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135711AbREBSFb>; Wed, 2 May 2001 14:05:31 -0400
Received: from 223-ZARA-X27.libre.retevision.es ([62.82.240.223]:43790 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S135706AbREBSFZ>;
	Wed, 2 May 2001 14:05:25 -0400
Message-ID: <3AF02049.1080901@zaralinux.com>
Date: Wed, 02 May 2001 16:57:13 +0200
From: Jorge Nerin <comandante@zaralinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4 i586; en-US; 0.8) Gecko/20010226
X-Accept-Language: es-es, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Linux SMP <linux-smp@vger.kernel.org>
Subject: Memory management issues with 2.4.4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Short version:
Under very heavy thrashing (about four hours) the system either lockups 
or OOM handler kills a task even when there is swap space left.

Long version:
My system is a dual 2x200MMX in a Gigabyte 586DX with 96Mb and 226Mb of 
swap this way:

[root@quartz ~]# swapon -s
Filename                        Type            Size    Used    Priority
/dev/hda7                       partition       96348   6456    1
/dev/hdc6                       partition       130276  6460    1

Well, I have tried to compile Mozilla 0.8.1 since the day it came out, 
but I always lockup in the same place, wich it's begining to be a bit 
frustrating ;-)

The problem is that compiling the file  
content/base/src/nsStyleContext.o makes cc1plus grow up to a size of 
141M, at this point the system is in heavy thrashing, kswapd is using 
about 7-12% of CPU time and cc1plus is using 8-14%.

If I use a SMP kernel the system always ends up frozen, some times after 
about almost one day of uptime and compiling since booting, and another 
times  it gets frozen in much less time, three or four hours.

If I use a non SMP kernel the system doesn't lokup but after some hours, 
it varies between 6-8h, the cc1plus procces get a kill signal by OOM 
killer, althought there is plenty of swap space left ((96Mb RAM + 226Mb 
swap) - (140Mb - tiny amount used by the system) = plenty ;-).

For this tries I have left the system in single user, so no cron jobs, 
no network trafic, no etc...

I suspect there is a race in the swap handling in SMP, and that the OOM 
doesn't take into account the swap space left sometimes.

I don't know what to try next, suggestions?

-- 
Jorge Nerin
<comandante@zaralinux.com>

