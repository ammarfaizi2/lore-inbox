Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbULQNIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbULQNIq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 08:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbULQNIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 08:08:46 -0500
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:22032 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S262802AbULQNI3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 08:08:29 -0500
Message-ID: <41C2DA43.9070900@tebibyte.org>
Date: Fri, 17 Dec 2004 14:08:19 +0100
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-ac16
References: <1103222616.21920.12.camel@localhost.localdomain>
In-Reply-To: <1103222616.21920.12.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox escreveu:
> Further small fixes for different minor things. A merge of some of the small
> cleanups from Fedora work and also the fixes for the igmp and vc holes. 

This kernel still suffers from the faulty OOM killing troubles of 
vanilla 2.6.9. Could you please pick up at least one of the recent fixes 
for this problem, such as as Rik van Riel's? As it stands -ac16 is 
unusable on a machine with as "little" as 64MB RAM, and bigger machines 
will just run into the same problems later.


  For example the following happens when trying to compile UML on a 64MB 
machine, whereas the same build completes without incident on 2.6.10-rc2-mm4

   LD      init/built-in.o
   LD      .tmp_vmlinux1
collect2: ld terminated with signal 9 [Killed]
make[2]: *** [.tmp_vmlinux1] Error 1
make[2]: Leaving directory `/home/chris/src/umlsim-65/kernel/linux-2.6.9'
make[1]: *** [linux-2.6.9/vmlinux] Error 2
make[1]: Leaving directory `/home/chris/src/umlsim-65/kernel'
make: *** [all] Error 1


The entry in the system log for this is

Dec 17 13:46:39 sleepy oom-killer: gfp_mask=0xd2
Dec 17 13:46:40 sleepy DMA per-cpu:
Dec 17 13:46:40 sleepy cpu 0 hot: low 2, high 6, batch 1
Dec 17 13:46:40 sleepy cpu 0 cold: low 0, high 2, batch 1
Dec 17 13:46:40 sleepy Normal per-cpu:
Dec 17 13:46:40 sleepy cpu 0 hot: low 4, high 12, batch 2
Dec 17 13:46:40 sleepy cpu 0 cold: low 0, high 4, batch 2
Dec 17 13:46:40 sleepy HighMem per-cpu: empty
Dec 17 13:46:40 sleepy
Dec 17 13:46:40 sleepy Free pages:         244kB (0kB HighMem)
Dec 17 13:46:40 sleepy Active:12016 inactive:499 dirty:0 writeback:0 
unstable:0
free:61 slab:1349 mapped:12003 pagetables:130
Dec 17 13:46:40 sleepy DMA free:60kB min:60kB low:120kB high:180kB 
active:11960k
B inactive:256kB present:16384kB
Dec 17 13:46:40 sleepy protections[]: 0 0 0
Dec 17 13:46:40 sleepy Normal free:184kB min:188kB low:376kB high:564kB 
active:3
6104kB inactive:1740kB present:49144kB
Dec 17 13:46:40 sleepy protections[]: 0 0 0
Dec 17 13:46:40 sleepy HighMem free:0kB min:128kB low:256kB high:384kB 
active:0k
B inactive:0kB present:0kB
Dec 17 13:46:40 sleepy protections[]: 0 0 0
Dec 17 13:46:40 sleepy DMA: 1*4kB 1*8kB 1*16kB 1*32kB 0*64kB 0*128kB 
0*256kB 0*5
12kB 0*1024kB 0*2048kB 0*4096kB = 60kB
Dec 17 13:46:40 sleepy Normal: 0*4kB 1*8kB 1*16kB 1*32kB 0*64kB 1*128kB 
0*256kB
0*512kB 0*1024kB 0*2048kB 0*4096kB = 184kB
Dec 17 13:46:40 sleepy HighMem: empty
Dec 17 13:46:40 sleepy Swap cache: add 2428, delete 2095, find 168/191, 
race 0+0
Dec 17 13:46:40 sleepy Out of Memory: Killed process 11648 (ld).


Regards,
Chris R.
