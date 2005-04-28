Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbVD1Nwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVD1Nwj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 09:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVD1Nwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 09:52:37 -0400
Received: from [151.12.57.13] ([151.12.57.13]:2822 "EHLO
	mail2.it.atosorigin.com") by vger.kernel.org with ESMTP
	id S262134AbVD1Nvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 09:51:42 -0400
From: Rao Davide <davide.rao@atosorigin.com>
Cc: dl8bcu@dl8bcu.de, linux-kernel@vger.kernel.org, ink@jurassic.park.msu.ru
Message-ID: <4270E6A9.4040204@atosorigin.com>
Date: Thu, 28 Apr 2005 15:35:37 +0200
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Re: Linux Alpha port: LVM
References: <42569BC7.5030709@atosorigin.com> <20050408190709.GB27845@twiddle.net> <425A2442.8090607@atosorigin.com> <4263ACA9.4080507@atosorigin.com> <20050418195351.GA32124@Marvin.DL8BCU.ampr.org> <4264D77C.6010605@atosorigin.com>
In-Reply-To: <4264D77C.6010605@atosorigin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Apr 2005 13:57:44.0890 (UTC) FILETIME=[40ACC9A0:01C54BFA]
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to bother you all ... the problem was that I issued some options 
during configuration to specify where the kernel was, apparently I 
should only do that on 2.4 series kernels.

I re-extracted the kernel sources and started over again. It's nor 
working fine now.

Thanks anyway
--
Regards
Davide Rao
   Client/server Unix
   Atos Origin
   Via C.Viola - Pont St. Martin (AO) Italy
   Cell :  +39 3357599151
   Tel  :  +39 125810433
   Email:  davide.rao@atosorigin.com


Davide Rao wrote:
>>> Is LVM working on the alpha port 2.6 kernel series ?
>>
>>  
>> works fine for me.
> 
> 
> Are you using a redhat based distro (like suse, mandrake, alpha core or 
> indeed redhat )?
> Are you using stock kernel, libraries and tools or did you haveto build 
> them yourself ?
> Debian comes with LVM1 tools that do not work with 2.6 kernels so I need 
> to compile them myself or install some ready build binary package for 
> alpha processor and compatible with the libraries that come with debian3.
> What alpha architecture are you running on ?
> 
> 
>>> If so where do I get libdevmapper so that I can build the userspace 
>>> LVM utils ?
>>>
>>> I tryied downloading 
>>> ftp://sources.redhat.com/pub/dm/multipath-toolsmultipath-tools-0.4.3.tar.bz2 
>>>
>>
>>
>> what do you think the 'dm' in that url stands for, hm?
>>
>>
>>> But I fail to compile it so I'm also unable tu build the userspace 
>>> lvm utils.
>>
>>
>>
>> 'userspace lvm utils' can be found here:
>>
>> ftp://sources.redhat.com/pub/lvm2
>>
>> multipath tools might be something different ... :)
> 
> 
> It may also have something more but it has libdevmapper in it ...
> In any case I also tried downloading and compiling 
> device-mapper.1.00.07.tgz from the link in the LVM2.
> It builds and installe fine but I still get compilation errore when I 
> build LVM2.
> Configute is fine, here are a few lines concerning libdevmapper
> 
> checking libdevmapper.h usability... yes
> checking libdevmapper.h presence... yes
> checking for libdevmapper.h... yes
> 
> but when I try to compile:
> 
> gcc -c -I. -I../include -DLVM1_INTERNAL -DPOOL_INTERNAL 
> -DCLUSTER_LOCKING_INTERNAL -DSNAPSHOT_INTERNAL -DMIRRORED_INTERNAL 
> -DDEVMAPPER_SUPPORT -DO_DIRECT_SUPPORT -DHAVE_LIBDL -DHAVE_GETOPTLONG 
> -fPIC -Wall -Wundef -Wshadow -Wcast-align -Wwrite-strings 
> -Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Winline 
> -O2 cache/lvmcache.c -o cache/lvmcache.o
> activate/activate.c: In function `target_present':
> activate/activate.c:303: error: `DM_DEVICE_LIST_VERSIONS' undeclared 
> (first use in this function)
> activate/activate.c:303: error: (Each undeclared identifier is reported 
> only once
> activate/activate.c:303: error: for each function it appears in.)
> activate/activate.c:314: warning: implicit declaration of function 
> `dm_task_get_versions'
> activate/activate.c:314: warning: nested extern declaration of 
> `dm_task_get_versions'
> activate/activate.c:314: warning: assignment makes pointer from integer 
> without a cast
> activate/activate.c:319: error: dereferencing pointer to incomplete type
> ...
> same message repeated many times
> ...
> make[1]: *** [activate/activate.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make[1]: Leaving directory `/usr/src/LVM2.2.01.09/lib'
> make: *** [lib] Error 2
> 
> I'm using kernel 2.6.11.7 downloaded from kernel.org.
> Here's the relevent section for raid/lvm in config:
> # Multi-device support (RAID and LVM)
> #
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=y
> CONFIG_MD_LINEAR=y
> CONFIG_MD_RAID0=y
> CONFIG_MD_RAID1=y
> # CONFIG_MD_RAID10 is not set
> CONFIG_MD_RAID5=y
> # CONFIG_MD_RAID6 is not set
> CONFIG_MD_MULTIPATH=y
> CONFIG_MD_FAULTY=y
> CONFIG_BLK_DEV_DM=y
> # CONFIG_DM_CRYPT is not set
> # CONFIG_DM_SNAPSHOT is not set
> # CONFIG_DM_MIRROR is not set
> # CONFIG_DM_ZERO is not set
> 
> Do I need to patch kernel ?
> 
>>
>>
>>> -- 
>>> Regards
>>> Davide Rao
>>>  Client/server Unix
>>>  Atos Origin
>>>  Via C.Viola - Pont St. Martin (AO) Italy
>>>  Cell :  +39 3357599151
>>>  Tel  :  +39 125810433
>>>  Email:  davide.rao@atosorigin.com
>>
>>
>>
>>
>> 73 Thorsten
>>
