Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbVBBSYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbVBBSYD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 13:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVBBSYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 13:24:03 -0500
Received: from alog0123.analogic.com ([208.224.220.138]:1152 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262312AbVBBSXb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 13:23:31 -0500
Date: Wed, 2 Feb 2005 13:23:43 -0500 (EST)
From: linux-os <root@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Joe User DOS kills Linux-2.6.10
Message-ID: <Pine.LNX.4.61.0502021314340.5410@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I compile and run the following program:

#include <stdio.h>
int main(int x, char **y)
{
     pause();
}
... as:

./xxx `yes`

... the following occurs after about 30 seconds (your mileage
may vary):

Additional sense: Peripheral device write fault
end_request: I/O error, dev sdb, sector 34605780
SCSI error : <0 0 1 0> return code = 0x8000002
Info fld=0x2100101, Deferred sdb: sense key Medium Error
Additional sense: Peripheral device write fault
end_request: I/O error, dev sdb, sector 34603748
SCSI error : <0 0 1 0> return code = 0x8000002
Info fld=0x2100103, Deferred sdb: sense key Medium Error
Additional sense: Peripheral device write fault
end_request: I/O error, dev sdb, sector 34606804
SCSI error : <0 0 1 0> return code = 0x8000002
Info fld=0x213d5cd, Deferred sdb: sense key Medium Error
Additional sense: Peripheral device write fault
end_request: I/O error, dev sdb, sector 33943668
SCSI error : <0 0 1 0> return code = 0x8000002
Info fld=0x213d5ce, Deferred sdb: sense key Medium Error
Additional sense: Peripheral device write fault
end_request: I/O error, dev sdb, sector 33943676
SCSI error : <0 0 1 0> return code = 0x8000002
Info fld=0x213d5cf, Deferred sdb: sense key Medium Error
Additional sense: Peripheral device write fault
end_request: I/O error, dev sdb, sector 33943684
SCSI error : <0 0 1 0> return code = 0x8000002
Info fld=0x213d5d0, Deferred sdb: sense key Medium Error
Additional sense: Peripheral device write fault
end_request: I/O error, dev sdb, sector 33943692
SCSI error : <0 0 1 0> return code = 0x8000002
Info fld=0x2149672, Deferred sdb: sense key Medium Error
Additional sense: Peripheral device write fault
end_request: I/O error, dev sdb, sector 9437375
Buffer I/O error on device sdb1, logical block 1179664
lost page write due to I/O error on sdb1
SCSI error : <0 0 1 0> return code = 0x8000002
Info fld=0x2149673, Deferred sdb: sense key Medium Error
Additional sense: Peripheral device write fault
end_request: I/O error, dev sdb, sector 34903668
SCSI error : <0 0 1 0> return code = 0x8000002
Info fld=0x214967c, Current sdb: sense key Medium Error
Additional sense: Peripheral device write fault
end_request: I/O error, dev sdb, sector 34903676

This device, /dev/sdb1 is one of the mounted file-systems.
It is not being accessed. The root filesystem is on
an IDE drive (/proc/mounts):

rootfs / rootfs rw 0 0
/dev/root.old /initrd ext2 rw 0 0
/dev/root / ext3 rw 0 0
/proc /proc proc rw,nodiratime 0 0
/sys /sys sysfs rw 0 0
none /dev/pts devpts rw 0 0
none /dev/shm tmpfs rw 0 0
/dev/sdb1 /home/project ext2 rw 0 0
/dev/sda1 /dos/drive_C msdos rw,nodiratime,fmask=0022,dmask=0022 0 0
/dev/sda5 /dos/drive_D msdos rw,nodiratime,fmask=0022,dmask=0022 0 0
sunrpc /var/lib/nfs/rpc_pipefs rpc_pipefs rw 0 0

This continues until the system is too sick to even be re-booted
from the console. It requires the reset switch.

It looks like the command-line argument is probably overflowing
something in the kernel, resulting in non-related problems.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
