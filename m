Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbTGBBrK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 21:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbTGBBrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 21:47:10 -0400
Received: from [62.75.136.201] ([62.75.136.201]:49858 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S264537AbTGBBrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 21:47:05 -0400
Message-ID: <3F023CF6.2090901@g-house.de>
Date: Wed, 02 Jul 2003 04:01:26 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20030624
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: scsi timeout with 2.4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i don't know if it is a kernel issue at all, it could be a hardware 
issue too, but i can't tell so please have a look.

i am using linux 2.4.20 on a PowerPC (PReP) with a "LSI Logic / Symbios 
Logic (formerly NCR) 53c825 (rev 13)" scsi controller (onboard). i am 
using the symbios driver (CONFIG_SCSI_SYM53C8XX) because the other 
alternatives (NCR53C8XX, timeouts during boot, booting stops. 
SYM53C8XX_2, timeouts during use, unuseable) are not working.

i have these timouts when there is heavy traffic on the controller, it's 
reproduceable, it happens only *sometimes* during "normal" use. when 
these timeouts occur, load goes up to 10-16, the system is unuseable, 
then, after a few seconds, the system status seems to be ok again, load 
is going down to normal.

i know, the controller and the machine is a bit old, but it serves my 
needs. on the controller there are 3 scsi disks (2x18 GB IBM xServer, 
1x36GB eServer -- yes High-End scsi disks on a low-end controller, but 
the disks were cheap, somehow.)

here are the timeouts:

scsi : aborting command due to timeout : pid 3463623, scsi0, channel 0,\ 
id 1, lun 0 Read (10) 00 01 d0 1e 9a 00 01 00 00
sym53c8xx_abort: pid=3463623 serial_number=3463623 
serial_number_at_timeout=3463623
SCSI host 0 abort (pid 3463623) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
sym53c8xx_reset: pid=3463623 reset_flags=2 serial_number=3463623\ 
serial_number_at_timeout=3463623
sym53c825a-0-<0,*>: FAST-10 WIDE SCSI 20.0 MB/s (100.0 ns, offset 8)
sym53c825a-0-<1,*>: FAST-10 WIDE SCSI 20.0 MB/s (100.0 ns, offset 8)
sym53c825a-0-<2,*>: FAST-10 WIDE SCSI 20.0 MB/s (100.0 ns, offset 8)


the first line ("scsi: abort...") is sometimes repeated, 2 or up to 7 
times. the last 3 lines are always repeated 3 times, as you can see 
above. and the "id" is not always "1" but all three id's are affected.
while i don't believe that the disks are bad, i suspect the scsi 
controller perhaps, or is it a driver issue and can i tune something?
the driver is statically compiled into the kernel with default settings.
(DEFAULT_TAGS=8, MAX_TAGS=32, SYNC=20).

what is your opinion on that? the controller, the disks (perhaps too new 
for the controller?) or the driver?

Thank you for your time,
Christian.

root@sheep:~# cat /proc/scsi/sym53c8xx/0
General information:
   Chip sym53c825a, device id 0x3, revision id 0x13
   On PCI bus 0, device 12, function 0, IRQ 15
   Synchronous period factor 25, max commands per lun 32
root@sheep:~#
root@sheep:~# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: IBM-ESXS Model: ST318305LW    !# Rev: B245
   Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
   Vendor: IBM-ESXS Model: ST318305LW    !# Rev: B244
   Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
   Vendor: IBM-ESXS Model: ST336607LW    FN Rev: B258
   Type:   Direct-Access                    ANSI SCSI revision: 03
root@sheep:~#
root@sheep:~# cat /proc/cpuinfo
cpu		: 604r
clock		: ???
revision	: 49.2 (pvr 0009 3102)
bogomips	: 299.00
machine		: PReP Utah (Powerstack II Pro4000)
L2		: 512Kb, parity disabled SRAM:synchronous,pipelined,no parity
root@sheep:~#

-- 
BOFH excuse #274:

It was OK before you touched it.

