Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317858AbSHaR6m>; Sat, 31 Aug 2002 13:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317859AbSHaR6m>; Sat, 31 Aug 2002 13:58:42 -0400
Received: from ns.mpi-sb.mpg.de ([139.19.1.1]:65258 "EHLO
	interferon.mpi-sb.mpg.de") by vger.kernel.org with ESMTP
	id <S317858AbSHaR6l>; Sat, 31 Aug 2002 13:58:41 -0400
Message-ID: <3D7104D5.8AD2086B@mpi-sb.mpg.de>
Date: Sat, 31 Aug 2002 20:03:01 +0200
From: Roman Dementiev <dementiev@mpi-sb.mpg.de>
Reply-To: dementiev@mpi-sb.mpg.de
Organization: MPI for Computer Science
X-Mailer: Mozilla 4.79 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Multi disk performance (8 disks), limit 230 MB/s
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have been doing some benchmarking experiments on kernel 2.4.19 with 8
IDE disks. Due to poor performance of 2 disks at 1 IDE channels we have
bought 4 Promise Ultra 100 TX2 (32-bit 66 Mhz) controllers and to avoid
bus saturation Supermicro P4PDE motherboard with multiple PCI buses
(64-bit 66 Mhz) and 2-Xeons. I submitted already PCI slot placing
problems to the mailing list. But theoretically I can live with the
current IDE condrollers->PCI slots assighnment.

The assignment is the following: 3 IDE controllers are connected to the
one PCI 64-bit Hub with bandwidth 1 GByte/s and  4th controller is on
another hub with the same characteristics.

Theoretically with 6 IBM disks (47 MB/s from the first cylinders) I
should achieve a number about  266 MB/s (32 bit X 66 Mhz) < 6*47. AND
2*47 = 94 MB/s < 266 MB/s from the last two disks. Thus the rate should
be 94 + 266 = 360 MB/s.

BUT no matter from which set of the disks I read or write I have got the

following parallel read/write rates (raw access):


         write (MB/s) read (MB/s) systime (top)  real/user/sys(time) (s)

1 disk :        48    45          3  %           3.0 / 0.1 / 0.4
2 disks:        83    94          10 %           3.5 / 0.1 / 0.6
4 disks:        131   189         21 %           4.3 / 0.4 / 2.8
5 disks:        172   233                        4.5 / 0.5 / 4.5
6 disks:        197   234 ?       30 %           5.2 / 0.6 / 6.6
7 disks:        209 ? 230 ?                      5.9 / 0.6 / 8.8
8 disks:        214 ? 229 ?       40 %           6.7 / 0.8 /10.8

The method of the measurement:
1. Prespawn thread for every disk
2. signal threads to start write of 64 Mb of data
3. wait until all threads finished, measure time
4. signal threads to start read of 64 Mb of data
5. wait until all threads finished, measure time

All disks are in UDMA 100 mode

Has anyone else seen similar problems?
What limits the performance: IDE disk driver, bottleneck in the kernel
I/O subsystem?
How to improve?


Roman

