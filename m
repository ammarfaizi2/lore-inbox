Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270492AbRHISHI>; Thu, 9 Aug 2001 14:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270491AbRHISG7>; Thu, 9 Aug 2001 14:06:59 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:2041 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S270233AbRHISGx>; Thu, 9 Aug 2001 14:06:53 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108091806.f79I6ong023560@webber.adilger.int>
Subject: Re: can't get buffer cache to flush with /dev/ram with 2.4.4 using "update"/"sync"
In-Reply-To: <6a.11d48002.28a42627@aol.com> "from Floydsmith@aol.com at Aug 9,
 2001 01:45:11 pm"
To: Floydsmith@aol.com
Date: Thu, 9 Aug 2001 12:06:50 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Floyd Smith writes:
> I boot linux using "loadlin" with an "initrd" ram disk image ("minix" type 
> fs) of size 32 Meg with kernel 2.4.4. The /linuxrc (a C executable) runs and 
> it shows that the mounted file sysem is of proper type and size. Then my 
> "linuxrc" extracts a "tar" achrive (to populate the mounted /dev/ram [on 
> "/"]) with a small subset of  "linux" about (18 Meg) (as a "rescue" floppy 
> boot). Before the "extract", debug code shows that the "cached" entry in 
> "/proc/meminfo" to be practically zero (and thus plenty of "freemem"). 
> However, after the "extract", the "cached" line shows about "18Meg"  and I 
> can find nothing that works to "flush" it. I have tried "spawing" 
> "/sbin/update" and waiting several min. and running "/bin/sync" and also 
> waiting - no change in the "cahed" entry (or and increase in the "freemem").  
> (ps -ef shows a process "bdflush" running [spawned] on its own.) Thus, trying 
> to bring up a "logon" shell (and its "init" scripts) results in that process 
> being killed do to lack of "freemem". I have only 64M and less than 4 Meg 
> free after the "extract". Any suggestions greatly appreciated in advance. If 
> there any "syscall" I can make in "linuxrc" that will flush "all" buffers 
> without knowing anything like "file descriptors"? Is this "syscall" 
> "synchronus" - or do do I have wait several seconds for it to work?

I would "suggest" that the "cache" has nothing to do with the "problem".
It is just a "cache", and _should_ be "released" when it is not needed.
However, the "ramdisk" is using up a fair amount of "memory", and your
"initrd" is using up "memory" as well.  This "adds up" to about "50MB"
right there.  Maybe you need to make a "smaller" "initrd" or use "ramfs"
instead of "ramdisk" so you don't "waste" ram on the "empty" part of the
"filesystem" from the "tar".  You may also want to use a smaller "shell"
like "ash" for limited boot environments, or even something like "Tom's
Root Boot" which is "very small" to start with.

That said, there were "problems" in older "kernels" with respect to the
"VM subsystem", so you are best off using "2.4.8-pre8" or whatever is the
most recent "kernel" (or even the next one, which has yet more fixes).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

