Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129285AbRBHD0l>; Wed, 7 Feb 2001 22:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129620AbRBHD0c>; Wed, 7 Feb 2001 22:26:32 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:18950 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129285AbRBHD0Z>; Wed, 7 Feb 2001 22:26:25 -0500
Date: Wed, 7 Feb 2001 21:21:35 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: [ANNOUNCE] PCI-SCI Drivers v1.2-1 Released
Message-ID: <20010207212135.A30704@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linux Kernel,

The PCI-SCI Drivers for the Dolphin Scalable Coherent Interface
v1.2-1 has posted at vger.timpanogas.org:/sci/pci-sci-1.2-1.  This 
release corrects several hardware related bugs, and corrects 
several previously reported build and performance problems related 
to the RedHat 7.1 Fischer Release.  

These drivers are released under the GNU public license, and are 
freely downloadable and re-distributable.  These drivers are provided
in both .tar.gz and RPM formats.  

Please direct any questions, bug reports, or comments to either
jmerkey@timpanogas.org or linux-kernel@vger.kernel.org.  

Analysis of performance problems related to the gcc 2.96 compiler on the 
fischer release indicate that there are some problems with mixing 
powertools RPMs and egcs compatibility modules on a base release 
that may result in poor code generation.  We wiped the entire 
RedHat 7.1 Fischer system, and performed a clean install with just
the base compiler, and none of the compatibilty tools, and the 
performance numbers for sci_copy (scibench2) came back up to 
expected levels for the target system.  

Since SCI allows userspace -> userspace copying across systems,
the problem code was being generated in user space and not kernel.
We did not attempt to track any further than installing just the 
base RedHat 7.1 Fischer release -- the numbers were acceptable
for the target system.  The performance numbers attached to this 
release wer run on a PIII Intel System using the 440BX Bridge 
chipset on a system with a maximum PCI throughput of 87 MB/S.  


NOTES:

*Fixed concurrent DMA and PIO error detection bug for D330 adapters

*Linux:Fixed problems to allocate ATT tables for large SCI memsizes.    

*Linux:Added proper handling of driver unload if driver load fails.

*Linux:fixed sleepOk flags to allow __GFP_WAIT flags to be passed to 
 __get_free_pages() to correct alloc failures in Linux when 
 memory gets fragmented. 

*Linux:fixed ASSERT() macros for modversioned IRM builds on Linux 
 systems. 

*Added SIMD/MMX support / Windows 2000. Not ported to Linux yet.
  (coming to Linux soon)

*Added proper handling of SCIInitialize() failiure in all
 examples/demos.

*UNIX: Fixed SCIMapLocal/RemoteSegment() bug when mapping to a segment
 offset.

*Linux:added code to /src/adm/MAKE/CONFIG-LINUX to append the 
 -D__SMP__ build option when SMP support is detected in 
 kernel source tree to correct SMP build errors on 2.2/2.4 kernels JVM
 
Please note: call to SCIInitialize/SCITerminate will be mandatory from 
next version of SISCI. 

SISCI applications should update code ASAP. SCIInitialize() 
must be the first SISCI function used. SCITerminate() should be the 
last one used.
      

 /opt/DIS/bin/scibench2 compiled Feb  7 2001 : 19:15:19

Test parameters for client 
----------------------------

Local nodeId      	    : 4
Remote nodeId     	    : 8
Local adapter no. 	    : 0
Segment size      	    : 65536
Loops to execute  	    : 1
ILoops to execute 	    : 1000
Key Offset        	    : 0
Source buffer type	    : User malloc
Memcopy mode      	    : scicopy
Direction	  	    : PUSH
Error Check       	    : No
SISCI API version	    : SISCI API version 1.10.0 (  Feb  7 2001 )
Adapter type    	    : D320
Serial number   	    : 100963
Hostbridge                  : 440BX
IO Bus frequency            : 33 MHz
SCI Link frequency          : 100 MHz
B-Link frequency            : 66 MHz
----------------------------

Connect to remote segment (id=0x80400) .... connected
Remote segment (id=0x80400) is connected.
Remote segment (id=0x80400) is mapped to user space. 

-- Starting the data transfer -- 


----------------------------------------------------
Segment Size:	Average Transfer Time:		Throughput:
----------------------------------------------------
4		  2.14 us	  1.87 MBytes/s
8		  2.22 us	  3.61 MBytes/s
16		  2.53 us	  6.32 MBytes/s
32		  4.25 us	  7.53 MBytes/s
64		  3.42 us	 18.70 MBytes/s
128		  6.07 us	 21.09 MBytes/s
256		  6.34 us	 40.40 MBytes/s
512		  6.46 us	 79.28 MBytes/s
1024		 12.57 us	 81.46 MBytes/s
2048		 29.53 us	 69.36 MBytes/s
4096		 50.59 us	 80.96 MBytes/s
8192		100.85 us	 81.23 MBytes/s
16384		208.46 us	 78.60 MBytes/s
32768		404.03 us	 81.10 MBytes/s
65536		808.05 us	 81.10 MBytes/s
Node 4 triggering interrupt

Interrupt message sent to remote node
The remote segment is unmapped
The segment is disconnected

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
