Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262631AbSKTVXD>; Wed, 20 Nov 2002 16:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbSKTVXD>; Wed, 20 Nov 2002 16:23:03 -0500
Received: from whfirewall.nwtel.ca ([199.85.228.1]:15233 "EHLO
	whfirewall.nwtel.ca") by vger.kernel.org with ESMTP
	id <S262631AbSKTVXB>; Wed, 20 Nov 2002 16:23:01 -0500
Message-Id: <5.1.1.6.0.20021120131444.02482858@gnat.nwtel.ca>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Wed, 20 Nov 2002 13:30:03 -0800
To: linux-kernel@vger.kernel.org
From: Richard Whittaker <rwhittak@gnat.nwtel.ca>
Subject: Semaphore and Shared memory questions...
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings:

I'm building a Linux box up for use with Oracle 8i.

The machine I'm using is a Dell Poweredge 2650 server with a pair of Xeon 
Processors, 2GB of RAM, a disk array, etc, etc...

Part of building this machine up is tuning the kernel parameters for 
shmmax, semmni, semmsl, semmns, etc...

In reading, this should be fairly ieasy... Make some changes to 
/usr/include/linux/sem.h and /usr/include/linux/shm.h, recompile, install, 
LILO, reboot, and yer done... Well, my experience wasn't that simple...

Here's a clip of my /usr/include/linux/shm.h

#define SHMMAX 0x3E00000                 /* max shared seg size (bytes) */
#define SHMMIN 1                         /* min shared seg size (bytes) */
#define SHMMNI 4096                      /* max num of segs system wide */
#define SHMALL (SHMMAX/PAGE_SIZE*(SHMMNI/16)) /* max shm system wide (pages) */
#define SHMSEG SHMMNI                    /* max shared segs per process */

...and what sysctl shows...

root@tom:/usr/include/linux# sysctl -a | grep shmmax
kernel/shmmax = 33554432
root@tom:/usr/include/linux#

I can change this value with sysctl -p at boot time, but I would really 
prefer it to be built into the kernel...

...now for semaphores...

/usr/include/linux/sem.h

#define SEMMNI  128             /* <= IPCMNI  max # of semaphore identifiers */
#define SEMMSL  450             /* <= 8 000 max num of semaphores per id */
#define SEMMNS  1000            /* <= INT_MAX max # of semaphores in system */
#define SEMOPM  100             /* <= 1 000 max num of ops per semop call */
#define SEMVMX  32767           /* <= 32767 semaphore maximum value */
#define SEMAEM  SEMVMX          /* adjust on exit max value */

The only values I've changed are SEMMSL, and SEMMNS...

Looking at the semaphores, here's what I see...

root@tom:/usr/include/linux# cat /proc/sys/kernel/sem
250     32000   32      128
root@tom:/usr/include/linux#

How would I sysctl these values?...

I would prefer them to be statically built into the kernel...

I know that the kernel SHOULD be the right version, and I've done a make 
dep ; make clean ; make bzImage

My kernel version info...

root@tom:/usr/include/linux# cat /proc/sys/kernel/osrelease
2.4.19
root@tom:/usr/include/linux# cat /proc/sys/kernel/version
#4 SMP Tue Nov 19 16:21:21 PST 2002

Thanks muchly in advance!!!

Regards,
Richard.
---

Richard Whittaker,
System Manager,
NorthwesTel Inc.
Whitehorse, Yukon, Canada.

