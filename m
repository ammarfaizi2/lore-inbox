Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282228AbRK2BH0>; Wed, 28 Nov 2001 20:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282232AbRK2BHQ>; Wed, 28 Nov 2001 20:07:16 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:9746 "EHLO
	lazy.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S282228AbRK2BHI>; Wed, 28 Nov 2001 20:07:08 -0500
Date: Wed, 28 Nov 2001 18:53:40 -0600 (CST)
From: Manoj Iyer <manjo@austin.ibm.com>
X-X-Sender: <manjo@lazy>
To: ltp <ltp-list@lists.sourceforge.net>,
        kernelmailinglist <linux-kernel@vger.kernel.org>
cc: Linda J Scott <lindajs@us.ibm.com>
Subject: VM test on 2.4.16 (SMP)
Message-ID: <Pine.LNX.4.33.0111281847350.32156-100000@lazy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kernel:			2.4.16 (SMP)
Total mem:              9GB
Total Swap:             5GB
Total CPU:              2 (Pentium III coppermine)
Total exec time:        24Hrs
HIMEM:			4GB

I executed my memory management and NFS tests on linux-2.4.16

The tests can be found on ltp web site, ltp.sf.net, under ../testcases/kernel/
mem/... and .../testcases/kernel/network/nfs/nfsstress/...

The programs do the following:

   1) mmap a file of size = sizeof(char) * 1000000000; as shared and private
   mapping. (anonymous memory map)

   3) mmap a file of same size shared.

   4) memory race conditions tests.

   5) spawn 30 threads, each thread mallocs memory in a loop size is either
   powers of 2,3,or 7 or size = numbers in fibbanoci series.

   6) Also I am generating a lot of disk I/O and compiles (invoking cc) by
   running my make_tree (NFS client) test over NFS. (details about the test
   available in the source .../testcases/kernel/network/nfs/nfsstress/
   make_tree.c.)

The memory tests are executed as separate processes as a normal user "manjo".
The nfs test is executed as a root process on nfs version 2.

The tests were set to execute for a period of 24 hours. I noticed that the
network was taken down, my telnet sessions that were displaying out put of
top command hung. The reboot command hung after the message "shutting down
Now..." I waited for well over 30 mts and then had to hit the button to
reboot the machine.

Here are some statics I gathered with sar.

I/O  and transfer rate statistics.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
16:36:46          tps      rtps      wtps   bread/s   bwrtn/s
Average:       125.66     77.85     47.81   4841.12  18308.66

paging statistics.
~~~~~~~~~~~~~~~~~~
16:36:46     pgpgin/s pgpgout/s  activepg  inadtypg  inaclnpg  inatarpg
Average:      2420.56   9154.25     42606         0         0         0

process creation activity.
~~~~~~~~~~~~~~~~~~~~~~~~~~
16:36:46       proc/s
Average:         5.08

activity for each block device
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
16:36:46          DEV       tps    blks/s
Average:       dev8-0    125.66  23149.78

network statistics.
~~~~~~~~~~~~~~~~~~~
 * statistics from  the  network devices
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
16:36:46 IFACE   rxpck/s   txpck/s   rxbyt/s   txbyt/s   rxcmp/s   txcmp/s
rxmcst/s
Average: eth0     43.08     43.73   7272.78   6252.29      0.00      0.00
0.00

 * statistics  on  failures (errors) from the  network  devices
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
16:36:46 IFACE   rxerr/s   txerr/s    coll/s  rxdrop/s  txdrop/s  txcarr/s
rxfram/s  rxfifo/s  txfifo/s
Average: eth0      0.00      0.00      0.00      0.00      0.00      0.00
0.00      0.00      0.00

 * statistics on sockets in use
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
16:36:46       totsck    tcpsck    udpsck    rawsck   ip-frag
Average:           48        17        14         1         0

queue length and load averages.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
16:36:46      runq-sz  plist-sz   ldavg-1   ldavg-5
Average:           22       114     37.65     37.54

memory  and  swap space utilization statistics
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
16:36:46  kbmemfree kbmemused  %memused kbmemshrd kbbuffers  kbcached kbswpfree
 kbswpused  %swpused
Average:  173006    856350     83.19         0      1200    398900    429595
 108541     20.17

memory statistics.
~~~~~~~~~~~~~~~~~~
16:36:46      frmpg/s   shmpg/s   bufpg/s   campg/s
Average:         0.04      0.00     -0.00     -0.07

CPU  utilization.
~~~~~~~~~~~~~~~~~
16:36:46          CPU     %user     %nice   %system     %idle
Average:          all      5.89      0.00     64.94     29.17
Average:            0      5.99      0.00     64.66     29.35
Average:            1      5.78      0.00     65.23     28.99

status  of  inode,  file  and  other kernel tables
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
16:36:46  dentunusd   file-sz  %file-sz  inode-sz  super-sz %super-sz  dquot-sz
 %dquot-sz  rtsig-sz %rtsig-sz
Average:   17         53       0.63       921         0      0.00         0
  0.00         1      0.10

system switching activity.
~~~~~~~~~~~~~~~~~~~~~~~~~~~
16:36:46      cswch/s
Average:     20611.94

swapping  statistics.
~~~~~~~~~~~~~~~~~~~~~
16:36:46     pswpin/s pswpout/s
Average:         2.37    986.87

--
Manoj Iyer
*******************************************************************************
		The greatest risk is not taking one.
*******************************************************************************

