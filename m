Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135670AbREIVhS>; Wed, 9 May 2001 17:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135676AbREIVhI>; Wed, 9 May 2001 17:37:08 -0400
Received: from dfw-smtpout2.email.verio.net ([129.250.36.42]:61588 "EHLO
	dfw-smtpout2.email.verio.net") by vger.kernel.org with ESMTP
	id <S135670AbREIVg5>; Wed, 9 May 2001 17:36:57 -0400
Message-ID: <3AF9B876.FDB1B6DD@bigfoot.com>
Date: Wed, 09 May 2001 14:36:54 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19-amd-via-ide i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Bratcher <bratcher@tpr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ATAPI Tape Driver Failure in Kernel 2.4.4, More
In-Reply-To: <3AF9558F.9C76953C@tpr.com> <3AF9B411.2A0F3F43@tpr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use SCSI emulation instead of ATAPI for the tape device.  Also make sure
your mt is >= 0.5.

[tim@abit tim]# mt -v
mt-st v. 0.5b
[tim@abit linux]# dump -v
dump 0.4b
[tim@abit linux]# restore -v
restore 0.4b17


[dmesg exerpts - tape is /dev/st0]
...
hdd: HP COLORADO 20GB, ATAPI TAPE drive
...
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
scsi : 1 host.
  Vendor: HP        Model: COLORADO 20GB     Rev: 4.01
  Type:   Sequential-Access                  ANSI SCSI revision: 02
Detected scsi tape st0 at scsi0, channel 0, id 0, lun 0
...

for 2.2.x .config:

CONFIG_BLK_DEV_IDESCSI
#CONFIG_BLK_DEV_IDETAPE
CONFIG_SCSI
CONFIG_CHR_DEV_ST


> immediately after the backup completes and I try to write a file mark with "mt":
> 
> May  9 16:50:49 isaiah kernel: ide-tape: Reached idetape_chrdev_open
> May  9 16:52:05 isaiah kernel: hdd: irq timeout: status=0xd0 { Busy }
> May  9 16:52:05 isaiah kernel: hdd: ATAPI reset complete
> May  9 16:52:05 isaiah kernel: ide-tape: Couldn't write a filemark
> May  9 16:52:06 isaiah kernel: ide-tape: Reached idetape_chrdev_open
> May  9 16:54:06 isaiah kernel: ide-tape: ht0: DSC timeout
> May  9 16:54:06 isaiah kernel: hdd: ATAPI reset complete
> ...

-- 
  |  650.390.9613  |  6502247437@messaging.cellone-sf.com
