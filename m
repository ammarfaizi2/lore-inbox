Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281047AbRKOUos>; Thu, 15 Nov 2001 15:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281050AbRKOUol>; Thu, 15 Nov 2001 15:44:41 -0500
Received: from abasin.nj.nec.com ([138.15.150.16]:62984 "HELO
	abasin.nj.nec.com") by vger.kernel.org with SMTP id <S281047AbRKOUnv>;
	Thu, 15 Nov 2001 15:43:51 -0500
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15348.10494.577151.173831@abasin.nj.nec.com>
Date: Thu, 15 Nov 2001 15:43:42 -0500 (EST)
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Sven Heinicke <sven@research.nj.nec.com>, linux-kernel@vger.kernel.org
Subject: Re: /proc/stat description for proc.txt
In-Reply-To: <20011115133734.P5739@lynx.no>
In-Reply-To: <15347.57175.887835.525156@abasin.nj.nec.com>
	<20011115115939.I5739@lynx.no>
	<15348.8974.587924.655924@abasin.nj.nec.com>
	<20011115133734.P5739@lynx.no>
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Third times a charm I hope.  Patch to 2.4.15-pre4.

--- proc-copy.txt	Thu Nov 15 15:05:39 2001
+++ proc.txt	Thu Nov 15 15:41:19 2001
@@ -25,6 +25,7 @@
   1.5	SCSI info
   1.6	Parallel port info in /proc/parport
   1.7	TTY info in /proc/tty
+  1.8	Kernel Statistics in /proc/stat
 
   2	Modifying System Parameters
   2.1	/proc/sys/fs - File system data
@@ -223,7 +224,7 @@
  rtc         Real time clock                                   
  scsi        SCSI info (see text)                              
  slabinfo    Slab pool info                                    
- stat        Overall statistics                                
+ stat        Overall statistics                                 (1.8)
  swaps       Swap space utilization                            
  sys         See chapter 2                                     
  sysvipc     Info of SysVIPC Resources (msg, sem, shm)		(2.4)
@@ -566,9 +567,9 @@
 1.7 TTY info in /proc/tty
 -------------------------
 
-Information about  the  available  and actually used tty's can be found in the
-directory /proc/tty.You'll  find  entries  for drivers and line disciplines in
-this directory, as shown in Table 1-9.
+Information about the available and actually used tty's can be found
+in the directory /proc/tty.  You'll find entries for drivers and line
+disciplines in this directory, as shown in Table 1-9.
 
 
 Table 1-9: Files in /proc/tty 
@@ -595,6 +596,53 @@
   /dev/tty             /dev/tty        5       0 system:/dev/tty 
   unknown              /dev/tty        4    1-63 console 
 
+
+1.8 Kernel Statistics in /proc/stat
+-----------------------------------
+
+General statistics about what the kernel has been doing is available
+in the /proc/stat file.  To view the statistics simply;
+
+$ cat /proc/stat 
+cpu  58903 1 7337 221340
+cpu0 58903 1 7337 221340
+page 97604 92120
+swap 1 0
+intr 571041 287581 3738 0 0 3 0 2 0 0 0 0 56043 202215 0 21398 61 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
+disk_io: (3,0):(21459,9839,195208,11620,184240) 
+ctxt 1719440
+btime 1005238271
+processes 4997
+
+The individual "cpu" entry is will be the same as "cpu0" if you only
+have one CPU on your system.  Otherwise the "cpu" entry will be a
+total of all the separate CPU statistics.  The four numbers following
+"cpu" entries are: user, nice, system and idle usage.  These are
+stored in jiffies.
+
+The two numbers following the "page" entry are number of pages going
+in followed by the number of pages going out.  Same goes for the
+"swap" entry.
+
+The "intr" entry show the number of interrupts.  The first number is
+the total interrupts between all IRQs.  The remaining numbers are the
+interrupts for each IRQ in order.
+
+The "disk_io" shows data for each active disk.  The above example only
+shows one active disk.  The first pair is the major followed by the
+disk number entry.  The others are:
+     - total number of I/O operations on this drive
+     - read I/O operations
+     - read I/O sectors
+     - write I/O operations
+     - write I/O sectors
+
+"ctxt" the the contest switches.
+
+"btime" is the time the system booted.
+
+"processes" is the number of processes that have run since boot.  This
+includes forks, don't know if it includes threads.
 
 ------------------------------------------------------------------------------
 Summary
