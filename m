Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284951AbRLFDCK>; Wed, 5 Dec 2001 22:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284952AbRLFDCB>; Wed, 5 Dec 2001 22:02:01 -0500
Received: from mplspop4.mpls.uswest.net ([204.147.80.14]:10763 "HELO
	mplspop4.mpls.uswest.net") by vger.kernel.org with SMTP
	id <S284951AbRLFDB4>; Wed, 5 Dec 2001 22:01:56 -0500
Date: Wed, 5 Dec 2001 21:01:54 -0600
Message-ID: <20011206030154.GA5979@iucha.net>
From: "Florin Iucha" <florin@iucha.net>
To: linux-kernel@vger.kernel.org
Cc: faith@acm.org
Subject: Adaptec-2920 eats too much cpu time when reading from the CD-ROM
Mail-Followup-To: linux-kernel@vger.kernel.org, faith@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have recently purchased a Plextor 12x CD-RW and I have attached it to
and Adaptec-2920 SCSI card. The card uses the "Future Domain Corp. TMC-18C30
[36C70]" chip.

The problem I see: when reading from the CD-RW my system becomes very
unresponsive and top reveals 90-95% of the time is spent on "system".
My CPU is AMD K6-III/500MHz with 256 Mb RAM.

When reading the same CD using the IDE DVD-ROM the time spent in system
is 5%. Also when the CD-RW is connected to the Advansys SCSI controller
the CPU usage is also negligible. The Adaptec-2920 uses IRQ 10 and does
not share it with any other board.

I notice an unusual number of interrupts in /proc/interrupts: after the
machine has been up for a couple of hours and I have written three CDs,
the statistics are:
          CPU0       
 0:     638458          XT-PIC  timer
 1:      15325          XT-PIC  keyboard
 2:          0          XT-PIC  cascade
 5:          0          XT-PIC  es1371
 8:          1          XT-PIC  rtc
 9:      17004          XT-PIC  usb-uhci
10:    3032143          XT-PIC  fdomain
11:      58021          XT-PIC  advansys
12:    2995779          XT-PIC  eth0
14:     107542          XT-PIC  ide0
15:       6895          XT-PIC  ide1

When loading the fdomain module I get:
   scsi1: <fdomain> No BIOS; using scsi id 7
   scsi1: <fdomain> TMC-36C70 (PCI bus) chip at 0xdc00 irq 10
   Bad boy: fdomain (at 0xd08b7866) called us without a dev_id!

Is there anything I can try?

Thanks,
florin

-- 

"If it's not broken, let's fix it till it is."

41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
