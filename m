Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129805AbQKTTXr>; Mon, 20 Nov 2000 14:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129884AbQKTTXj>; Mon, 20 Nov 2000 14:23:39 -0500
Received: from 118-ZARA-X11.libre.retevision.es ([62.82.226.118]:34821 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S130187AbQKTTXZ>;
	Mon, 20 Nov 2000 14:23:25 -0500
Message-ID: <3A193A4A.32F21209@zaralinux.com>
Date: Mon, 20 Nov 2000 15:50:50 +0100
From: Jorge Nerin <comandante@zaralinux.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: es-ES, es, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Documentacion proc.txt update (2.4.x)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, this is a little update to the proc.txt file, it's based in 2.2 kernel, and I have updated it a little to the 2.4 series, I have updated all the thing I have been told in lk, so I submit this in order to include this in the main tree in order to have a better updated info.


diff -urN linux.old/Documentation/filesystems/proc.txt linux/Documentation/filesystems/proc.txt
--- linux.old/Documentation/filesystems/proc.txt	Mon Nov 20 15:41:53 2000
+++ linux/Documentation/filesystems/proc.txt	Mon Nov 20 15:41:44 2000
@@ -3,8 +3,11 @@
 ------------------------------------------------------------------------------
 /proc/sys         Terrehon Bowden <terrehon@pacbell.net>        October 7 1999
                   Bodo Bauer <bb@ricochet.net>
+
+2.4.x update	  Jorge Nerin <comandante@zaralinux.com>      November 14 2000
 ------------------------------------------------------------------------------
-Version 1.2                                              Kernel version 2.2.12
+Version 1.3                                              Kernel version 2.2.12
+					      Kernel version 2.4.0-test11-pre4
 ------------------------------------------------------------------------------
 
 Table of Contents
@@ -42,17 +45,18 @@
 0.1 Introduction/Credits
 ------------------------
 
-This documentation  is  part  of a soon (or so we hope) to be released book on
-the SuSE  Linux  distribution.  As  there is no complete documentation for the
-/proc file  system and we've used many freely available sources to write these
-chapters, it  seems  only  fair  to give the work back to the Linux community.
-This work is based on the 2.2.* kernel version. I'm afraid it's still far from
-complete, but  we  hope  it will be useful. As far as we know, it is the first
-'all-in-one' document  about the /proc file system. It is focused on the Intel
-x86 hardware,  so if you are looking for PPC, ARM, SPARC, APX, etc., features,
-you probably  won't  find  what  you are looking for. It also only covers IPv4
-networking, not  IPv6  nor  other protocols - sorry. But additions and patches
-are welcome and will be added to this document if you mail them to Bodo.
+This documentation is  part of a soon (or  so we hope) to be  released book on
+the SuSE  Linux distribution. As  there is  no complete documentation  for the
+/proc file system and we've used  many freely available sources to write these
+chapters, it  seems only fair  to give the work  back to the  Linux community.
+This work is  based on the 2.2.*  kernel version and the  upcomming 2.4.*. I'm
+afraid it's still far from complete, but we  hope it will be useful. As far as
+we know, it is the first 'all-in-one' document about the /proc file system. It
+is focused  on the Intel  x86 hardware,  so if you  are looking for  PPC, ARM,
+SPARC, APX, etc., features, you probably  won't find what you are looking for.
+It also only covers IPv4 networking, not IPv6 nor other protocols - sorry. But
+additions and patches  are welcome and will  be added to this  document if you
+mail them to Bodo.
 
 We'd like  to  thank Alan Cox, Rik van Riel, and Alexey Kuznetsov and a lot of
 other people for help compiling this documentation. We'd also like to extend a
@@ -65,9 +69,13 @@
 contact Bodo  Bauer  at  bb@ricochet.net.  We'll  be happy to add them to this
 document.
 
-The latest  version  of  this  document  is  available  online  at
+The   latest   version    of   this   document   is    available   online   at
 http://skaro.nightcrawler.com/~bb/Docs/Proc as HTML version.
 
+If  the above  direction does  not works  for you,  ypu could  try the  kernel
+mailing  list  at  linux-kernel@vger.kernel.org  and/or try  to  reach  me  at
+comandante@zaralinux.com.
+
 0.2 Legal Stuff
 ---------------
 
@@ -92,7 +100,7 @@
 
 The proc  file  system acts as an interface to internal data structures in the
 kernel. It  can  be  used to obtain information about the system and to change
-certain kernel parameters at runtime.
+certain kernel parameters at runtime (sysctl).
 
 First, we'll  take  a  look  at the read-only parts of /proc. In Chapter 2, we
 show you how you can use /proc/sys to change settings.
@@ -111,16 +119,17 @@
 ..............................................................................
  File    Content                                        
  cmdline Command line arguments                         
- environ Values of environment variables                
+ cpu	 Current and last cpu in wich it was executed		(2.4)(smp)
+ cwd	 Link to the current working directory
+ environ Values of environment variables      
+ exe	 Link to the executable of this process
  fd      Directory, which contains all file descriptors 
+ maps	 Memory maps to executables and library files		(2.4)
  mem     Memory held by this process                    
+ root	 Link to the root directory of this process
  stat    Process status                                 
- status  Process status in human readable form          
- cwd     Link to the current working directory          
- exe     Link to the executable of this process         
- maps    Memory maps                                    
- root    Link to the root directory of this process     
  statm   Process memory status information              
+ status  Process status in human readable form          
 ..............................................................................
 
 For example, to get the status information of a process, all you have to do is
@@ -131,6 +140,7 @@
   State:  R (running) 
   Pid:    5452 
   PPid:   743 
+  TracerPid:      0						(2.4)
   Uid:    501     501     501     501 
   Gid:    100     100     100     100 
   Groups: 100 14 16 
@@ -187,13 +197,20 @@
  devices     Available devices (block and character)           
  dma         Used DMS channels                                 
  filesystems Supported filesystems                             
+ driver	     Various drivers grouped here, currently rtc	(2.4)
+ execdomains Execdomains, related to security			(2.4)
+ fb	     Frame Buffer devices				(2.4)
+ fs	     File system parameters, currently nfs/exports	(2.4)
  ide         Directory containing info about the IDE subsystem 
  interrupts  Interrupt usage                                   
+ iomem	     Memory map						(2.4)
  ioports     I/O port usage                                    
- kcore       Kernel core image (can be ELF or A.OUT)           
+ irq	     Masks for irq to cpu affinity			(2.4)(smp?)
+ isapnp	     ISA PnP (Plug&Play) Info				(2.4)
+ kcore       Kernel core image (can be ELF or A.OUT(deprecated in 2.4))   
  kmsg        Kernel messages                                   
  ksyms       Kernel symbol table                               
- loadavg     Load average                                      
+ loadavg     Load average of last 1, 5 & 15 minutes                
  locks       Kernel locks                                      
  meminfo     Memory info                                       
  misc        Miscellaneous                                     
@@ -201,14 +218,19 @@
  mounts      Mounted filesystems                               
  net         Networking info (see text)                        
  partitions  Table of partitions known to the system           
+ pci	     Depreciated info of PCI bus (new way -> /proc/bus/pci/, 
+             decoupled by lspci					(2.4)
  rtc         Real time clock                                   
  scsi        SCSI info (see text)                              
  slabinfo    Slab pool info                                    
  stat        Overall statistics                                
  swaps       Swap space utilization                            
  sys         See chapter 2                                     
+ sysvipc     Info of SysVIPC Resources (msg, sem, shm)		(2.4)
+ tty	     Info of tty drivers
  uptime      System uptime                                     
  version     Kernel version                                    
+ video	     bttv info of video resources			(2.4)
 ..............................................................................
 
 You can,  for  example,  check  which interrupts are currently in use and what
@@ -230,6 +252,68 @@
    15:          7          XT-PIC  ide1 
   NMI:          0 
 
+In 2.4.* a couple of lines where added to this file LOC & ERR (this time is the
+output of a SMP machine):
+
+  > cat /proc/interrupts 
+
+             CPU0       CPU1       
+    0:    1243498    1214548    IO-APIC-edge  timer
+    1:       8949       8958    IO-APIC-edge  keyboard
+    2:          0          0          XT-PIC  cascade
+    5:      11286      10161    IO-APIC-edge  soundblaster
+    8:          1          0    IO-APIC-edge  rtc
+    9:      27422      27407    IO-APIC-edge  3c503
+   12:     113645     113873    IO-APIC-edge  PS/2 Mouse
+   13:          0          0          XT-PIC  fpu
+   14:      22491      24012    IO-APIC-edge  ide0
+   15:       2183       2415    IO-APIC-edge  ide1
+   17:      30564      30414   IO-APIC-level  eth0
+   18:        177        164   IO-APIC-level  bttv
+  NMI:    2457961    2457959 
+  LOC:    2457882    2457881 
+  ERR:       2155
+
+NMI is incremented in this case because every timer interrupt generates a NMI
+(Non Maskable Interrupt) which is used by the NMI Watchdog to detect lookups.
+
+LOC is the local interrupt counter of the internal APIC of every CPU.
+
+ERR is incremented in the case of errors in the IO-APIC bus (the bus that
+connects the CPUs in a SMP system. This means that an error has been detected,
+the IO-APIC automatically retry the transmision, so it should not be a big
+problem, but you should read the SMP-FAQ.
+
+In this context it could be interesting to note the new irq directory in 2.4.
+It could be used to set IRQ to CPU affinity, this means that you can "hook" an
+IRQ to only one CPU, or to exclude a CPU of handling IRQs. The contents of the
+irq subdir is one subdir for each IRQ, and one file; prof_cpu_mask
+
+For example 
+  > ls /proc/irq/
+  0  10  12  14  16  18  2  4  6  8  prof_cpu_mask
+  1  11  13  15  17  19  3  5  7  9
+  > ls /proc/irq/0/
+  smp_affinity
+
+The contents of the prof_cpu_mask file and each smp_affinity file for each IRQ
+is the same by default:
+
+  > cat /proc/irq/0/smp_affinity 
+  ffffffff
+
+It's a bitmask, in wich you can specify wich CPUs can handle the IRQ, you can
+set it by doing:
+
+  > echo 1 > /proc/irq/prof_cpu_mask
+
+This means that only the first CPU will handle the IRQ, but you can also echo 5
+wich means that only the first and fourth CPU can handle the IRQ.
+
+The way IRQs are routed is handled by the IO-APIC, and it's Round Robin
+between all the CPUs which are allowed to handle it. As usual the kernel has
+more info than you and does a better job than you, so the defaults are the
+best choice for almost everyone.
 
 There are  three  more  important subdirectories in /proc: net, scsi, and sys.
 The general  rule  is  that  the  contents,  or  even  the  existence of these
@@ -1306,6 +1390,15 @@
 
 TCP settings
 ------------
+
+tcp_ecn
+-------
+
+This file controls the use of the ECN bit in the IPv4 headers, this is a new
+feature about Explicit Congestion Notification, but some routers and firewalls
+block trafic that has this bit set, so it could be necessary to echo 0 to
+/proc/sys/net/ipv4/tcp_ecn, if you want to talk to this sites. For more info
+you could read RFC2481.
 
 tcp_retrans_collapse
 --------------------


-- 
Jorge Nerin
<comandante@zaralinux.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
