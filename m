Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132578AbRDKO0C>; Wed, 11 Apr 2001 10:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132584AbRDKOZL>; Wed, 11 Apr 2001 10:25:11 -0400
Received: from phoenix.datrix.co.za ([196.37.220.5]:25396 "EHLO
	phoenix.datrix.co.za") by vger.kernel.org with ESMTP
	id <S132579AbRDKOY5>; Wed, 11 Apr 2001 10:24:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marcin Kowalski <kowalski@datrix.co.za>
Reply-To: kowalski@datrix.co.za
Organization: Datrix Solutions
To: hahn@coffee.psychology.mcmaster.ca, tomlins@cam.org
Subject: Re: memory usage - continued - iCache/Dentry cacheing bug???
Date: Wed, 11 Apr 2001 16:23:06 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.10.10104110917410.28937-100000@coffee.psychology.mc>
In-Reply-To: <Pine.LNX.4.10.10104110917410.28937-100000@coffee.psychology.mc>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <0104111623060I.25951@webman>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
Here is my saga continued. I had as mentioned in the preceding post 500mb of 
Inode cache entries and about 80mb of dentry_cache entries, accounting for +- 
600mb if "missing" memory.

These should be dynamically de-allocatable, so if a program needs the ram it 
will be freed as necessary. So I ran a little memory hog perl script :
---
#!/usr/bin/perl
$fred=1;
@bob=('Test');
while ($fred==1)
{
	push (@bob,@bob);
}
------
This naturally started eating memory, unexpectedly the kernel started paging 
hectically to swap using 250mb in no time, (ie filling the 1.2gigs of ram). 
How can this be??? Shouldn't the cache tables simply be purged in the event 
of memory need....
Anyway I then kill the job, suddenly  most of my physical ram is freed (250mb 
used).
I then do a swapoff /dev/sda3 (250mb used), this completely locks the machine 
for 50 seconds and pushes the load to 31 when I can log back in. Then 
micraculously I am using only 170mb of physical ram. I turn swap back on and 
all is well.... 
Can anyone please explain this odd behaviour.. ???
Below is a free after this whole debacle..:::

------

             total       used       free     shared    buffers     cached
Mem:       1157444     126364    1031080          0      10924      60080
-/+ buffers/cache:      55360    1102084
Swap:       641016          0     641016
------

> > Regarding this issue, I have a similar problem if I do a free on my
> > system I get :
> > ---   total       used       free     shared    buffers     cached
> > Mem:       1157444    1148120       9324          0      22080     459504
> > -/+ buffers/cache:     666536     490908
> > Swap:       641016      19072     621944
>
> perfect, no problem there.
>
> > Now what I do a ps there seems no way to accound for the 500mb + of
> > memory used. No single or group of processes uses that amount of memory.
> > THis is
>
> of course: the kernel tries hard to keep nearly all memory in use,
> since otherwise it's wasted.
>
> > very disconcerting, coupled with extremely high loads when cache is
> > dumped to disk locking up the machine makes me want to move back to
> > 2.2.19 from 2.4.3.
>
> swapping does not cause high load unless your disk is misconfigured (PIO)

Netraid 4m  (AACRAID) card with 80mb of Cache and 6x 10000rpm SCSII III HDD, 
I can only hope that the driver is running in DMA.... :-|

> > I would also be curious to see how the kernel is using memory...
>
> caching files.

-- 
-----------------------------
     Marcin Kowalski
     Linux/Perl Developer
     Datrix Solutions
     Cel. 082-400-7603
      ***Open Source Kicks Ass***
-----------------------------
