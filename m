Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268547AbRHAWhA>; Wed, 1 Aug 2001 18:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268551AbRHAWgu>; Wed, 1 Aug 2001 18:36:50 -0400
Received: from ns.starentnetworks.com ([64.240.141.2]:37717 "HELO
	starentnetworks.com") by vger.kernel.org with SMTP
	id <S268547AbRHAWgp>; Wed, 1 Aug 2001 18:36:45 -0400
Message-ID: <3B688480.7090704@starentnetworks.com>
Date: Wed, 01 Aug 2001 18:36:48 -0400
From: Brian Ristuccia <bristuccia@starentnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolinux.com>
CC: linux-kernel@vger.kernel.org, djohnson@starentnetworks.com
Subject: Re: repeated failed open()'s results in lots of used memory [Was: [Fwd: memory consumption]]
In-Reply-To: <200108012204.f71M4Bo0007352@webber.adilger.int>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Aug 2001 22:36:44.0718 (UTC) FILETIME=[712EF4E0:01C11ADA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

> You write:
> 
>>We've been experiencing a problem where an errant process would run in a 
>>tight loop trying to create files in a directory where it did not have 
>>access. While this errant process was running, we'd notice all of the 
>>available memory shift from buffers/cache (or free) to used and stay 
>>that way while the process was running. vmstat also reports heavy in/out 
>>traffic on the swap, but swap consumption does not grow past a few dozen 
>>megabytes. The memory used by the process itself does not grow.
>>
>>Note that we increase the default values for certain FS parameters:
>>
>>echo '16384' >/proc/sys/fs/super-max
>>echo '32768' >/proc/sys/fs/file-max
>>echo '65535' > /proc/sys/fs/inode-max
>>
> 
> You are probably creating negative dentries.  Check /proc/slabinfo for
> the number of dentries, and it will confirm this.  I'm not sure why
> that would cause swapping, but then again I haven't checked the policy
> for shrinking the dentry cache recently, and there have been a number
> of changes in that area lately.
> 

Yow! Right on. On 2.2.19 and 2.4.7, the  line for dentry_cache in 
/proc/slabinfo skyrockets while the test program is running. Also, on 
2.2.19 but not 2.4.7 the line for size-32 climbs steadily at around the 
same pace as dentry_cache when the test program is running. After I stop 
the test program, the number slowly declines as other processes allocate 
memory.

-- 
Brian Ristuccia

