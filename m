Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261394AbSJYNFm>; Fri, 25 Oct 2002 09:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261395AbSJYNFl>; Fri, 25 Oct 2002 09:05:41 -0400
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:38115 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S261394AbSJYNFf>; Fri, 25 Oct 2002 09:05:35 -0400
From: "Pavan Kumar Reddy N.S." <pavan.kumar@wipro.com>
To: "'Linux-Kernel'" <linux-kernel@vger.kernel.org>
Subject: 2.5.xx kernel performance issue...
Date: Fri, 25 Oct 2002 18:41:34 +0530
Message-ID: <000a01c27c28$0baa6e50$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-bf3bb37a-2fb9-4cb5-b9e9-d3a64bf4a118"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 25 Oct 2002 13:11:35.0117 (UTC) FILETIME=[0B5FF7D0:01C27C28]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-bf3bb37a-2fb9-4cb5-b9e9-d3a64bf4a118
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi All,

Here is the summary of LMBench(patch2) performance tool results for
different Linux kernels.

There are some surprising results for 2.5.XX kernel.

There is a drastic change in the latency of system calls stat and
open/close between 2.5.xx kernels.

Local communication latencies have also increased for 2.5.44 kernel
compared to 2.5.43.

TCP and AF_UNIX socket stream bandwidth has also got drastic change.

Does any one have any idea why there is a spike in performance of 2.5.xx
kernel ??


Thanks,
pavan

========================================================================

                L M B E N C H  2 . 0 [PATCH 2]  S U M M A R Y
 
------------------------------------------------------------------------
----


Hardware Specifications:
--------------------------------------

# CPU's               = 1 - Intel PIII
Motherboard     = Intel 810
CPU Freq           = 868 MHz
RAM                     = 128MB
L1 I Cache          = 16K
L1 D Cache        = 16K
L2 Cache            = 256K
File System       = ext3
glibc ver.            = 2.2.5-34
eth0                     = RTL8139


Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------------
------------------------------------
 OS                         MHz null  null          open  selct  sig
sig     fork  exec sh
                                         call  I/O    stat close  TCP
inst hndl   proc proc proc
------------------------------- ----- -------- ------ ------- --------
-------- -------- -------- -------------
Linux 2.4.19           868 0.39 0.71 3.90 5.15   29.7   0.94  3.03  143.
734.  5051
Lin 2.4.20-pre11   868 0.39 0.70 3.84 5.08  32.4    0.94  3.03  154.
734.  5059


Linux 2.5.42            868 0.39 0.76 24.6 26.1  32.1   1.01 4.89  361.
1592  7710
Linux 2.5.43            868 0.39 0.75 4.38 5.53  28.9   1.02 3.32  348.
1284  6335
Linux 2.5.44            868 0.39 0.77 24.5 26.1  32.5   1.02 4.89  433.
1587  7634
------------------------------------------------------------------------
------------------------------------


Context switching - times in microseconds - smaller is better
------------------------------------------------------------------------
------------------------------------
 OS                         2p/0K  2p/16K  2p/64K  8p/16K 8p/64K
16p/16K 16p/64K
                                ctxsw   ctxsw    ctxsw     ctxsw
ctxsw      ctxsw      ctxsw
------------------------------ ----------- ----------- ------------
--------------- ----------- --------------- 
Linux 2.4.19            1.100  4.3700    13.2      7.3000   181.1
47.6      182.6
Lin 2.4.20-pre11   1.090  4.4000    13.2      9.9000   182.3      46.1
182.9


Linux 2.5.42            1.170  4.5100    13.2      7.4300   187.4
44.7      189.3
Linux 2.5.43            1.250  4.3000    13.2      6.9600   187.9
43.3      188.2
Linux 2.5.44            1.140  4.4000    13.2      7.0200   188.5
43.0      189.2
------------------------------------------------------------------------
-------------------------------------

*Local* Communication latencies in microseconds - smaller is better
------------------------------------------------------------------------
------------------------------------
 OS                         2p/0K    Pipe     AF      UDP   RPC/   TCP
RPC/   TCP
                                ctxsw                UNIX
UDP                  TCP    conn
------------------------------- ---------- ---------- ----------
---------- ----------- --------- ------------
Linux 2.4.19            1.120   6.236   11.2    16.5     37.3     24.1
49.9    83.2
Lin 2.4.20-pre11   1.090   6.426   11.3    18.6     39.7     25.3
52.1    86.1


Linux 2.5.42            1.170   6.913   19.2    28.1     52.4     113.6
145.7  146.
Linux 2.5.43            1.250   6.876   12.9    20.7     42.3     29.5
56.2    94.1
Linux 2.5.44            1.140   6.928   19.6    31.1     55.3     113.7
145.4  142.
------------------------------------------------------------------------
-------------------------------------


File & VM system latencies in microseconds - smaller is better
------------------------------------------------------------------------
------------------------------------
 OS                                 0K File       10K File
Mmap    Prot    Page
                                Create Delete  Create Delete  Latency
Fault   Fault
------------------------------- ----------------------
----------------------- ------------- --------------
Linux 2.4.19            70.8    23.6        235.4   48.4   274.0   0.780
3.00000
Lin 2.4.20-pre11   71.2    25.3        239.8   49.9   269.0   0.784
3.00000


Linux 2.5.42            98.4    52.6        298.4   87.9   511.0   0.972
4.00000
Linux 2.5.43            72.7    26.4        249.1   56.0   505.0   0.917
4.00000
Linux 2.5.44            98.5    53.4        295.2   88.3   503.0   0.956
4.00000
------------------------------------------------------------------------
-----------------------------------


*Local* Communication bandwidths in MB/s - bigger is better
------------------------------------------------------------------------
------------------------------------------------
OS                          Pipe     AF     TCP      File      Mmap
Bcopy   Bcopy   Mem    Mem
                                           UNIX              reread
reread   (libc)     (hand)     read    write
------------------------------- ------- ----------- --------
-------------- ------------- ----------- ----------- --------- 
Linux 2.4.19            715.     604.   152.    317.6     352.0   111.6
102.6   352.   141.4
Lin 2.4.20-pre11   725.     449.   147.    315.7     352.1   111.6
102.5   351.   141.4

Linux 2.5.42            475.     148.   17.4    307.2     344.5   110.8
102.5   344.   139.5
Linux 2.5.43            387.     617.   38.2    298.1     345.4   111.2
102.4   345.   139.7
Linux 2.5.44            442.     147.   17.0    300.1     344.9   111.0
102.4   345.   139.6
------------------------------------------------------------------------
--------------------------------------------------


Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
------------------------------------------------------------------------
-----------------
OS                          Mhz   L1 $     L2 $    Main mem      Guesses
----------------------------- -------- ----------- -------------
-------------------------
Linux 2.4.19            868  3.456   8.0640   178.1
Lin 2.4.20-pre11   868  3.456   8.0690   178.2


Linux 2.5.44            868  3.490   8.1560   181.2
Linux 2.5.43            868  3.491   8.1530   180.6
Linux 2.5.44            868  3.490   8.2170   180.4
------------------------------------------------------------------------
----------------

Note: All results are average of five iterations.

============================================

============================================
PAVAN KUMAR REDDY N.S.
Sr.Software Engineer
Wipro Technologies
53/1, Hosur road, Madivala
Bangalore - 68.
Phone Off: +91-80-5502001-8 extn: 5086.
           Res: +91-80-6685179
http://www.wipro.com/linux/
============================================  


------=_NextPartTM-000-bf3bb37a-2fb9-4cb5-b9e9-d3a64bf4a118
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer**************************************************    
 
 Information contained in this E-MAIL being proprietary to Wipro Limited is 'privileged' 
and 'confidential' and intended for use only by the individual or entity to which it is 
addressed. You are notified that any use, copying or dissemination of the information 
contained in the E-MAIL in any manner whatsoever is strictly prohibited.

****************************************************************************************

------=_NextPartTM-000-bf3bb37a-2fb9-4cb5-b9e9-d3a64bf4a118--
