Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131958AbRCVKSJ>; Thu, 22 Mar 2001 05:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131963AbRCVKR7>; Thu, 22 Mar 2001 05:17:59 -0500
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:30216 "HELO
	zcamail05.zca.compaq.com") by vger.kernel.org with SMTP
	id <S131958AbRCVKRw>; Thu, 22 Mar 2001 05:17:52 -0500
Message-ID: <1FF17ADDAC64D0119A6E0000F830C9EA04B3CD09@aeoexc1.aeo.cpqcorp.net>
From: "Cabaniols, Sebastien" <Sebastien.Cabaniols@Compaq.com>
To: "'Andrea Arcangeli'" <andrea@suse.de>
Cc: Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: AlphaServer with 4 GB RAM, kernel 2.2.19pre17aa1 patched with big
	mem... locks for 4 Gbytes, works for 2,6,8 Gbytes
Date: Thu, 22 Mar 2001 11:15:06 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello lkml,

I have two machines AlphaServers ES40

machine 1 with 4 Gbytes of RAM
machine 2 with 8 Gbytes of RAM

These two machines work perfectly with Tru64, The RAM is ok
on both of these machines.

1) I recompiled kernel 2.2.19pre17aa1 

==> The two machines boot well, but are limited to 2 Gbytes of RAM.

2) So I applyed the patch 2.2.19pre17aa1.b, configured with BIGMEM enabled,
recompiled and reboot.

The two machines boot, see respectively 4 Gbytes and 8 Gbytes of RAM. a 
little C program allocating writting and reading to the memory shows it is
really working. 

THE PROBLEM:
-------------------------

On the machine with 4 Gbytes the system freezes when doing /bin/lspci 
or more /proc/pci (2 equivalent system calls fopen(/proc/pci) ) and not 
on the machine with 8 GBytes!

Remark: When I say freezes, I don't see the kernel panic message on the 
console and when I was running in SMP multiusers I kept receiving spinlock 
messages every 2 minutes:

	opensched.c:30 spinlock stuck in httpd at fffffc000032d524(3) owner
lspci at fffffc000035155c(1) read_write.c:43
	sched.c:30 spinlock stuck in identd at fffffc000032d524(2) owner
lspci at fffffc000035155c(1) read_write.c:43
	sched.c:30 spinlock stuck in identd at fffffc000032d524(0) owner
lspci at fffffc000035155c(1) read_write.c:43

For the following I prefered to go back to Uni Processor kernel in single
user
mode because the system is more simple and the problems are the same:

3) If I try to reboot the 4 Gbytes machine giving mem=2048 M at boot time,
everything works fine again (except the 2 GBytes of RAM unavailable)

4) If I try to reboot the 8 Gbytes machine giving mem=4096 M at boot time,
I have the same behaviour, freezing when doing more /proc/pci , as the 4 
Gbytes machine

5) If I try to reboot the 8 Gbytes machine giving mem=2048 M or 6144 M,
everything works perfectly.


SMP/UP:
--------------

I HAVE EXACTLY THE SAME RESULTS WITH SMP/UP kernel so I guess 
investigating on Uni processor is simpler.


I have tried to go through the code source of the patch but I am new to
kernel
programming, it looks like there is a switching mecanism around the 4 Gbytes
value for RAM size... that could be it.... I am still investigating.


Any Ideas ?


----------------------------------------------------------------------------
--
Sebastien CABANIOLS
COMPAQ France 
HPTC Engineer
CustomSystems & Solutions  Annecy  
High Performance Technical Computing 
Office No.  +33 (0)4 50 09 44 10
Fax No.  +33 (0)4 50 64 01 39 
Email.   sebastien.cabaniols@compaq.com 
----------------------------------------------------------------------------
--

  
