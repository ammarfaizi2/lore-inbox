Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267468AbUHVPna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267468AbUHVPna (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 11:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267469AbUHVPna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 11:43:30 -0400
Received: from [213.188.213.77] ([213.188.213.77]:6549 "EHLO
	server1.navynet.it") by vger.kernel.org with ESMTP id S267468AbUHVPnZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 11:43:25 -0400
From: "Massimo Cetra" <mcetra@navynet.it>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Production comparison between 2.4.27 and 2.6.8.1
Date: Sun, 22 Aug 2004 17:43:18 +0200
Message-ID: <003f01c4885e$bf688d20$0600640a@guendalin>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
In-Reply-To: <4127F7FD.5060804@yahoo.com.au>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> I wouldn't worry too much about hdparm measurements. If you 
> want to test the streaming throughput of the disk, run dd 
> if=big-file of=/dev/null or a large write+sync.

Created a big file:
 -rw-r--r--    1 root     root     1073740800 Aug 22 17:22 /testfile

time dd if=/testfile of=/dev/null gives:
On 2.6.8.1 ext3 raid
  real    0m11.493s
  user    0m0.657s
  sys     0m2.796s
On 2.6.8.1 xfs:
  real    0m18.214s
  user    0m0.697s
  sys     0m3.778s

Tests on 2.6.8.1 has been done with elevator=deadline

On 2.4.7 ext3 raid:
  real    0m20.513s
  user    0m0.704s
  sys     0m2.626s

On 2.4.7 xfs:
  real    0m28.414s
  user    0m0.686s
  sys     0m3.320s

So it seems that read access to disks is better on 2.6 tree.


> Regarding your worse non-RAID XFS database results, try 
> booting 2.6 with elevator=deadline and test again. 

This are results obtained with deadline:

filippo:~# dmesg |grep deadline
Using deadline io scheduler

A) [schema]
2b) 2.6.8.1 and xfs
  real    0m0.551s
  user    0m0.027s
  sys     0m0.012s

B) [Importing data]
2b) 2.6.8.1 and xfs
  real    1m1.474s
  user    0m3.281s
  sys     0m1.505s

It seems performance does not get better.

I have tried other tests:
With ext2 FS results are: 



A)
1c) 2.4.7 and ext2 (no raid)
  real    0m0.625s
  user    0m0.028s
  sys     0m0.018s
2c) 2.6.8.1 and ext2 (no raid)
  real    0m1.667s
  user    0m0.026s
  sys     0m0.010s
B)
1c) 2.4.7 and ext2 (no raid)
  real    1m28.542s
  user    0m3.232s
  sys     0m1.384s
2c) 2.6.8.1 and ext2
  real    1m30.200s
  user    0m3.304s
  sys     0m1.461s

Still, even with ext2, 2.4.7 performs much better with postgres (and
likely other databases).

I have no idea nor no clue how to improve this.

> If yes, 
> are you using queueing (TCQ) on your disks?

How can i check ?


 Massimo Cetra


