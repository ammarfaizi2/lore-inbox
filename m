Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312498AbSDNXqd>; Sun, 14 Apr 2002 19:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312499AbSDNXqc>; Sun, 14 Apr 2002 19:46:32 -0400
Received: from 39.159.252.64.snet.net ([64.252.159.39]:3712 "EHLO
	stinkfoot.org") by vger.kernel.org with ESMTP id <S312498AbSDNXqc>;
	Sun, 14 Apr 2002 19:46:32 -0400
Message-ID: <3CBA14E0.7080600@stinkfoot.org>
Date: Sun, 14 Apr 2002 19:46:40 -0400
From: Ethan <e-d0uble@stinkfoot.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Segfaulting programs with CONFIG_HIMEM on SMP PowerPC
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I've noticed recently that kernels >=2.4.18 on my SMP G4 began to say 
this at boottime:
Apr 13 15:03:20 spicymeatball kernel: Memory BAT mapping: BAT2=256Mb, 
BAT3=256Mb, residual: 256Mb
Apr 13 15:03:20 spicymeatball kernel: Warning, memory limited to 512 Mb, 
use CONFIG_HIGHMEM to reach 512 Mb
Apr 13 15:03:20 spicymeatball kernel: Total memory = 512MB; using 2048kB 
for hash table (at c0400000)

This machine has 768M, so I happily checked CONFIG_HIMEM (although I 
thought CONFIG_HIMEM was for systems with >2G but I suppose that only 
applies on x86), recompiled, and got the full 768M.  

Memory BAT mapping: BAT2=256Mb, BAT3=256Mb, residual: 256Mb
Total memory = 768MB; using 2048kB for hash table (at c0400000)
Linux version 2.4.18 (root@spicymeatball) (gcc version 2.95.3 19991030 
(prerelease/franzo/20001125)) #2  SMP Sat Apr 13 15:06:45 EDT 2002

A few hours later, I fired up dig to do a query.. it subsequently dumped 
a core..
I was a little suprised by this.. so I ran it again.. no crash this 
time.  Looking around the system, I found a few more core files.. one 
from bash here, another from sshd there.. it began to get a little 
unnerving.. they all weren't signal 11's either.. Some were SIGILL, some 
were SIGTRAP, etc. odd. So, after deleting the various cores.. I 
rebooted to the non config_himem kernel and tried to get these utilities 
to crash.. no dice.. everything was hunky-dory (except that I only had 
512M..)  How should I proceed here?  So far I've gone back to a 
bitkeeper pull of 2.4.18-pre1, which doesn't ask me to use CONFIG_HIMEM, 
detects all of my memory and seems rock-solid.  Newer kernels that want 
CONFIG_HIMEM all behave the same, with seemingly random coredumping 
executables.
I'm using glibc-2.2.4, gcc version 2.95.3 19991030 
(prerelease/franzo/20001125), BFD 2.11.2

Pleas CC me any replies, as I don't subscribe to the list.

thanks,

Ethan


