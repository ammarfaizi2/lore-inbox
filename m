Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287862AbSBZPJv>; Tue, 26 Feb 2002 10:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288248AbSBZPJi>; Tue, 26 Feb 2002 10:09:38 -0500
Received: from [12.38.223.195] ([12.38.223.195]:38239 "HELO
	starentnetworks.com") by vger.kernel.org with SMTP
	id <S288800AbSBZPJV>; Tue, 26 Feb 2002 10:09:21 -0500
Message-ID: <3C7BA51C.8010900@sw.starentnetworks.com>
Date: Tue, 26 Feb 2002 10:09:16 -0500
From: Brian Ristuccia <bristucc@sw.starentnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Brian Ristuccia <bristucc@sw.starentnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: Re: kernel nfsd consuming 100% CPU on 2.4.17 and 2.4.18 with reiserfs?
In-Reply-To: <3C7B9212.5050400@sw.starentnetworks.com> <2305220000.1014735355@tiny>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> 
> On Tuesday, February 26, 2002 08:48:02 AM -0500 Brian Ristuccia
> <bristucc@sw.starentnetworks.com> wrote:
> 
> 
>>It seems that kernel nfsd consumes an inordinate amount of CPU time
>>during writes on this machine. With a few hundred kb/sec being written
>>over NFSv3 from a 2.2.17 client, all of the nfsd threads each consume as
>>much of the available CPU time as possible. On a similarly configured
>>machine with ext3 instead of reiserfs, nfsd consumes much less CPU time.
>>
>>Is there a known issue with NFSv3 performance and reiserfs?
>>
> 
> No, it is not a known issue.  Does it only happen with a 2.2.17 client, or
> can you reproduce with any kernel version on the client?
> 

I can get it to happen with 2.2.19 and 2.4.4-pre3 as well.

So I'm pretty sure the NFS server is doing too much work somewhere.

If it matters, it's a SMP kernel running on a dual 1ghz pIII system with 
2gb of memory. The filesystem resides on a linux kernel md RAID-5 array 
with 6 10,000 rpm disks. It's my understanding that the a machine this 
large should soak out the available network or disk bandwidth long 
before it became CPU bound serving NFS. I also did some raw IO tests to 
confirm that the md block device wasn't hogging up CPU time that was 
getting accounted to the nfsd kernel threads. I can soak that array 
pretty hard without soaking the CPU.

The closest machine configuration wise that I have access to is 
similarly configured, only with 3 disks instead of 6 and ext3 instead of 
reiserfs. Both machines were running exactly the same 2.4.17 image when 
I started having this problem. I can't reproduce the problem there, even 
when I do nasty things like run bonnie++ over NFS. (This isn't to say 
that nfsd is free on this other machine, but I'm seeing it use on the 
order of 2-4% CPU per nfsd thread with 8 threads and a load average of 
between 1 and 2 vs. 20+% and a load average of 8 on the other machine).

Thanks.

-- 
Brian Ristuccia


