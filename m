Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266595AbRGEA1r>; Wed, 4 Jul 2001 20:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266587AbRGEA1i>; Wed, 4 Jul 2001 20:27:38 -0400
Received: from dfw-smtpout1.email.verio.net ([129.250.36.41]:6037 "EHLO
	dfw-smtpout1.email.verio.net") by vger.kernel.org with ESMTP
	id <S266591AbRGEA1a>; Wed, 4 Jul 2001 20:27:30 -0400
Message-ID: <3B43B470.9544B543@bigfoot.com>
Date: Wed, 04 Jul 2001 17:27:28 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.20p6ai i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: John Guthrie <guthrie@home.martnet.com>
Subject: Re: unable to read from IDE tape
In-Reply-To: <200107042248.SAA06196@home.martnet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upgrade to mt-st version .5b or greater.  Older mt versions had known
bugs particularly with positioning.  I suggest scsi emulation + scsi
tape rather than ATAPI tape.

rgds,
tim.


...
hdd: HP COLORADO 20GB, ATAPI TAPE drive
...
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
scsi : 1 host.
  Vendor: HP        Model: COLORADO 20GB     Rev: 4.01
  Type:   Sequential-Access                  ANSI SCSI revision: 02
Detected scsi tape st0 at scsi0, channel 0, id 0, lun 0
...

[17:12] abit:/etc/dump > mt -v
mt-st v. 0.5b
[17:12] abit:/etc/dump > tar --version | head -1
tar (GNU tar) 1.13.17
[17:12] abit:/etc/dump > ls -l /dev/tape
lrwxrwxrwx    1 root     root            4 Jul 14  2000 /dev/tape ->
nst0
[17:12] abit:/etc/dump > mt status
SCSI 2 tape drive:
File number=0, block number=0, partition=0.
Tape block size 512 bytes. Density code 0x47 (unknown to this mt).
Soft error count since last status=0
General status bits on (41010000):
 BOT ONLINE IM_REP_EN
[17:12] abit:/etc/dump > tar cvf /dev/tape /boot
tar: Removing leading `/' from member names
boot/
boot/kernel.h
boot/vmlinuz-2.2.14-12
boot/vmlinuz.prev
boot/System.map.prev
boot/linux-2.2.14-12
boot/linux-prev
boot/linux-2.2.20p6ai
boot/module-info
boot/boot.b
boot/chain.b
...
[17:12] abit:/etc/dump > mt status
SCSI 2 tape drive:
File number=1, block number=0, partition=0.
Tape block size 512 bytes. Density code 0x47 (unknown to this mt).
Soft error count since last status=0
General status bits on (81010000):
 EOF ONLINE IM_REP_EN
[17:12] abit:/etc/dump > mt tell
At block 11421.
[17:12] abit:/etc/dump > mt rewind
[17:13] abit:/etc/dump > mt status
SCSI 2 tape drive:
File number=0, block number=0, partition=0.
Tape block size 512 bytes. Density code 0x47 (unknown to this mt).
Soft error count since last status=0
General status bits on (41010000):
 BOT ONLINE IM_REP_EN
[17:13] abit:/etc/dump > mt tell
At block 0.
[17:13] abit:/etc/dump > tar tvf /dev/tape
drwxr-xr-x root/root         0 2001-06-25 22:21:52 boot/
-rw-r--r-- root/root       237 2001-05-03 23:04:36 boot/kernel.h
-r--r--r-- root/root    589225 2000-05-09 05:43:45
boot/vmlinuz-2.2.14-12
-rw-rw-r-- root/root    606292 2001-06-25 18:08:21 boot/vmlinuz.prev
-rw-rw-r-- root/root    195903 2001-06-25 18:08:21 boot/System.map.prev
lrwxrwxrwx root/root         0 2001-05-03 23:10:10 boot/linux-2.2.14-12
-> vmlinuz-2.2.14-12
lrwxrwxrwx root/root         0 2001-06-25 18:08:21 boot/linux-prev ->
vmlinuz.prev
lrwxrwxrwx root/root         0 2001-06-25 18:08:21 boot/linux-2.2.20p6ai
-> vmlinuz-2.2.20p6ai-0625-18:08:09
lrwxrwxrwx root/root         0 2000-04-10 21:15:54 boot/module-info ->
module-info-2.2.14-5.0
-rw-r--r-- root/root      4568 2000-02-02 14:03:10 boot/boot.b
-rw-r--r-- root/root       612 2000-02-02 14:03:10 boot/chain.b
...
[17:13] abit:/etc/dump > mt tell
At block 11420.
[17:14] abit:/etc/dump > mt status
SCSI 2 tape drive:
File number=0, block number=11420, partition=0.
Tape block size 512 bytes. Density code 0x47 (unknown to this mt).
Soft error count since last status=0
General status bits on (1010000):
 ONLINE IM_REP_EN
[17:14] abit:/etc/dump > mt fsf 1
[17:14] abit:/etc/dump > mt tell
At block 11421.
[17:14] abit:/etc/dump > mt status
SCSI 2 tape drive:
File number=1, block number=0, partition=0.
Tape block size 512 bytes. Density code 0x47 (unknown to this mt).
Soft error count since last status=0
General status bits on (81010000):
 EOF ONLINE IM_REP_EN

--
