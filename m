Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287838AbSAIR10>; Wed, 9 Jan 2002 12:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288830AbSAIR1U>; Wed, 9 Jan 2002 12:27:20 -0500
Received: from mailgate.bodgit-n-scarper.com ([62.49.233.146]:52999 "HELO
	mould.bodgit-n-scarper.com") by vger.kernel.org with SMTP
	id <S287838AbSAIR1D>; Wed, 9 Jan 2002 12:27:03 -0500
Date: Wed, 9 Jan 2002 17:36:33 +0000
From: Matt Dainty <matt@bodgit-n-scarper.com>
To: linux-kernel@vger.kernel.org
Subject: Where's all my memory going?
Message-ID: <20020109173633.A26559@mould.bodgit-n-scarper.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 on i686 SMP (mould)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've fashioned a qmail mail server using an HP NetServer with an HP NetRaid
4M & 1GB RAM, running 2.4.17 with aacraid, LVM, ext3 and highmem. The box
has 6x 9GB disks, one for system, one for qmail's queue, and the remaining
four are RAID5'd with LVM. ext3 is only on the queue disk, ext2 everywhere
else.

Before I stick the box live, I wanted to test that it doesn't fall over
under any remote kind of stress, so I've run postal to simulate lots of mail
connections.

Nothing too hard to begin with, but I'm seeing a degradation in performance
over time, using a maximum message size of 10KB, 5 simultaneous connections,
and limiting to 1500 messages per minute.

Initially the box memory situation is like this:

root@plum:~# free
             total       used       free     shared    buffers     cached
Mem:       1029524      78948     950576          0      26636      23188
-/+ buffers/cache:      29124    1000400
Swap:      2097136          0    2097136

...running postal, it seems to cope fine. Checking the queue using
qmail-qstat shows no messages being delayed for delivery, everything I chuck
at it is being delivered straight away.

However, over time, (30-45 minutes), more and more memory seems to just
disappear from the system until it looks like this, (note that swap is
hardly ever touched):

root@plum:~# free
             total       used       free     shared    buffers     cached
Mem:       1029524    1018032      11492          0      49380     245568
-/+ buffers/cache:     723084     306440
Swap:      2097136        676    2096460

...and qmail-qstat reports a few thousand queued messages. Even if I stop
the postal process, let the queue empty and start again, it never attains
the same performance as it did initially and the queue gets slowly filled.

I haven't left it long enough to see if the box grinds itself into the
ground, but it appears to stay at pretty much the same level as above, once
it gets there. CPU load stays at about ~5.0, (PIII 533), but it's still
very reponsive to input and launching stuff.

Looking at the processes, the biggest memory hog is a copy of dnscache that
claims to have used ~10MB, which is fine as I specified a cache of that size.
Nothing else shows any hint of excessive memory usage.

Can anyone offer any advice or solution to this behaviour, (or more tricks
or settings I can try)? I'd like the mail server to be able to handle 1500
messages instead of 150 a minute! :-) Any extra info required, please let me
know, I'm not sure what else to provide atm.

Cheers

Matt
-- 
"Phased plasma rifle in a forty-watt range?"
"Hey, just what you see, pal"
