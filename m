Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319473AbSIMBMG>; Thu, 12 Sep 2002 21:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319474AbSIMBMG>; Thu, 12 Sep 2002 21:12:06 -0400
Received: from host.greatconnect.com ([209.239.40.135]:21522 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S319473AbSIMBMF>; Thu, 12 Sep 2002 21:12:05 -0400
Message-ID: <3D813CFB.7050200@rackable.com>
Date: Thu, 12 Sep 2002 18:18:51 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Austin Gonyou <austin@coremetrics.com>,
       Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.4.20pre5aa2
References: <20020911201602.A13655@pc9391.uni-regensburg.de> <1031768655.24629.23.camel@UberGeek.coremetrics.com> <20020911184111.GY17868@dualathlon.random> <3D81235B.6080809@rackable.com> <20020913002316.GG11605@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>On Thu, Sep 12, 2002 at 04:29:31PM -0700, Samuel Flory wrote:
>  
>
>> Your patch seem to solve only some  of the xfs issues for me.  Before 
>>the patch my system hung when booting.  This only occured I  had xfs 
>>compiled into the kernel.   After patching  things seemed fine, but 
>>durning "dbench 32" the system locked.  Upon rebooting and attempting to 
>>mount the filesystem I got this:
>>XFS mounting filesystem md(9,2)
>>Starting XFS recovery on filesystem: md(9,2) (dev: 9/2)
>>kernel BUG at page_buf.c:578!
>><and so on>
>>
>>PS- The results of ksymoops are attached.
>>    
>>
>
>that seems a bug in xfs, it BUG() if vmap fails, it must not BUG(), it
>must return -ENOMEM to userspace instead, or it can try to recollect and
>release some of the other vmalloced entries. Most probably you run into
>an address space shortage, not a real ram shortage, so to workaround it
>you can recompile with CONFIG_2G and it'll probably work, also dropping
>the gap page in vmalloc may help workaround it (there's no config option
>for it though). It could be also a vmap leak, maybe a missing vfree,
>just some idea.
>
>  
>

   The system has 4G of ram, and 4G of swap.  So real memory is not an 
issue.  The system is a intended to be an nfs server.   As a result nfs 
performance is my only real concern.  I should really use CONFIG_3GB as 
I'm not doing much in user space other a tftp, and dhcp server.

   In any case the system isn't in production so I can leave it as is 
till monday.

