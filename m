Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbVC3Wsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbVC3Wsp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 17:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbVC3Wsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 17:48:45 -0500
Received: from icecream.egps.com ([38.119.130.6]:25094 "EHLO mail.egps.com")
	by vger.kernel.org with ESMTP id S262470AbVC3Ws2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 17:48:28 -0500
Date: Wed, 30 Mar 2005 17:48:28 -0500
From: Nachman Yaakov Ziskind <awacs@ziskind.us>
To: linux-kernel@vger.kernel.org
Subject: Slow SCSI perf in RH 7.3
Message-ID: <20050330174828.B27631@egps.egps.com>
Reply-To: awacs@ziskind.us
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Mailer: Outlook stinks. Dump Outlook.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a server:
2.4.20-28.7 #1 Thu Dec 18 11:31:59 EST 2003 i686

with SCSI hard disks (not raid):

SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 3960D Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 3960D Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

blk: queue dfdbe014, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: FUJITSU   Model: MAP3367NP         Rev: 5605
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue dfdbe214, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: FUJITSU   Model: MAP3367NP         Rev: 5605
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue dfdbe614, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: SEAGATE   Model: ST373307LW        Rev: 0005
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue dfdbea14, I/O limit 4095Mb (mask 0xffffffff)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
scsi0:A:4:0: Tagged Queuing enabled.  Depth 32
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 4, lun 0
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
SCSI device sda: 71132959 512-byte hdwr sectors (36420 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 >
(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
SCSI device sdb: 71132959 512-byte hdwr sectors (36420 MB) sdb: sdb1
(scsi0:A:4): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sdc: 143374744 512-byte hdwr sectors (73408 MB) sdc: sdc1
Journalled Block Device driver loaded

used for graphic files server to Apples (via Netatalk 1.5.2-3) with ext3. OS 
on one disk, data files on the other two. IDE removable storage.

It's great with only one user, but with multiple Apple users, it does a
passable impression of a boat anchor. Even ssh then comes back one character 
at a time. Top shows nothing out the ordinary, I think. Here's some typical 
'sar -b' stuff:

03:20:00 PM       tps      rtps      wtps   bread/s   bwrtn/s
03:30:00 PM      3.97      1.97      2.00     75.65     37.09
03:40:00 PM      4.41      2.32      2.09    336.19    122.32
03:50:00 PM      2.93      1.87      1.05    326.00    131.52
04:00:00 PM      2.44      1.80      0.65    294.09     27.97
04:10:00 PM      2.16      0.58      1.57    107.37     53.69
04:20:00 PM      0.81      0.16      0.66     32.26     31.38
04:30:00 PM      1.78      0.72      1.06     84.34     94.09
04:40:00 PM      1.28      0.55      0.73     55.81     97.88
04:50:00 PM      0.69      0.21      0.48      3.78     13.29
05:00:01 PM      1.82      0.51      1.32      6.02     51.81
05:10:00 PM      1.22      0.04      1.18      0.72     89.07
05:20:00 PM      2.60      1.13      1.47     63.19     30.13
05:30:00 PM      1.36      0.31      1.05      3.44     46.59
Average:         2.51      1.57      0.94     42.79     32.36


which I wish I knew well enough to interpret. :-(

So, I'd like to do *something* to speed things up. The likely suspects are:

1) Tweak the kernel somehow, in the knowledge that I'll probably just make
things worse (caching?)

2) Buy RAID (which level do I want? Is SATA raid faster than SCSI non-raid?)

3) Buy nicer/more expensive hard disks on the current controller, or, perhaps,
a faster non-raid controller.

All the connections, terminators, etc. seem happy. 

I would consider trading a little reliability for a lot of performance.

The inevitable omitted information upon request. I was hoping for some
suggestions from some very kind list members.

Thanks!

-- 
_________________________________________
Nachman Yaakov Ziskind, FSPA, LLM       awacs@ziskind.us
Attorney and Counselor-at-Law           http://ziskind.us
Economic Group Pension Services         http://egps.com
Actuaries and Employee Benefit Consultants
