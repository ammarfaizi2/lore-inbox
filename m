Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278522AbRK1Rd1>; Wed, 28 Nov 2001 12:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278381AbRK1RdS>; Wed, 28 Nov 2001 12:33:18 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:47767 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S278522AbRK1RdI>; Wed, 28 Nov 2001 12:33:08 -0500
Message-ID: <3C051F2D.2030804@antefacto.com>
Date: Wed, 28 Nov 2001 17:30:21 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Christoph Rohland <cr@sap.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Documentation/filesystems/tmpfs
In-Reply-To: <m3y9kqon6w.fsf@linux.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Rohland wrote:

> Hi,
> 
> Apparently there is a lack of information about tmpfs out there.


I aggree, and ramfs et al.


> So I would like to reduce the Configure.help entry and instead
> introduce a file Documentation/filesystems/tmpfs with more details.
> 
> My proposal is appended. Feedback about content and english language
> is highly appreciated.
> 
> Greetings
> 		Christoph
> 
> ------------------------------------------------------------------------
> 
> Tmpfs is a file system which keeps all files in virtual memory.
> 
> Everything is temporary in the sense that no files will be created on
> your hard drive. If you reboot, everything in tmpfs will be lost.
> 
> In contrast to RAM disks, which get allocated a fixed amount of
> physical RAM, tmpfs grows and shrinks to accommodate the files it
> contains and is able to swap unneeded pages out to swap space. 


That isn't the case now since ramdisks were 

integrated with the buffer cache:


$ dd if=/dev/zero of=/tmp/use_mem bs=1024 count=20000
$ cat /proc/meminfo
         total:    used:    free:  shared: buffers:  cached:
Mem:  129966080 122720256  7245824    49152 65863680 28745728
Swap:        0        0        0
MemTotal:       126920 kB
MemFree:          7076 kB
MemShared:          48 kB
Buffers:         64320 kB
Cached:          28072 kB
SwapCached:          0 kB
Active:          10308 kB
Inact_dirty:     80196 kB
Inact_clean:      1936 kB
Inact_target:    26200 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       126920 kB
LowFree:          7076 kB
SwapTotal:           0 kB
SwapFree:            0 kB

$ rm /tmp/use_mem
$ cat /proc/meminfo
         total:    used:    free:  shared: buffers:  cached:
Mem:  129966080 101957632 28008448    49152 65863680  8290304
Swap:        0        0        0
MemTotal:       126920 kB
MemFree:         27352 kB
MemShared:          48 kB
Buffers:         64320 kB
Cached:           8096 kB
SwapCached:          0 kB
Active:          10352 kB
Inact_dirty:     60196 kB
Inact_clean:      1916 kB
Inact_target:    26200 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       126920 kB
LowFree:         27352 kB
SwapTotal:           0 kB
SwapFree:            0 kB

Padraig.

