Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbTKYSIh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 13:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbTKYSIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 13:08:37 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:8179 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262965AbTKYSIb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 13:08:31 -0500
Date: Tue, 25 Nov 2003 10:33:34 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: office@produktivit.com
Subject: [Bugme-new] [Bug 1591] New: umount from disconnected USB causes	kernel oops (fwd)
Message-ID: <52460000.1069785214@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1591

           Summary: umount from disconnected USB causes kernel oops
    Kernel Version: 2.6.0-test7
            Status: NEW
          Severity: low
             Owner: bugme-janitors@lists.osdl.org
         Submitter: office@produktivit.com


Distribution: Debian unstable (current) 
Hardware Environment: x86 UMP, K7 
Software Environment: bash, mount, usb-storage 
Problem Description: umount from disconnected USB causes kernel oops 
 
Steps to reproduce: 
 
Insert USB camera, let it time out (10 min of no activity) so it disconnects from bus. If 
it was mounted somewhere and it disconnects, umount gives a kernel oops. 
 
smartass:/home/lsa# mount 
/dev/ide/host0/bus0/target0/lun0/part5 on / type ext2 (rw,errors=remount-ro) 
proc on /proc type proc (rw) 
devpts on /dev/pts type devpts (rw,gid=5,mode=620) 
/dev/ide/host0/bus0/target0/lun0/part1 on /boot type ext3 (rw) 
/dev/ide/host0/bus0/target0/lun0/part6 on /var type ext3 (rw) 
/dev/ide/host0/bus0/target0/lun0/part3 on /var/log type ext3 (rw) 
/dev/ide/host0/bus0/target0/lun0/part7 on /home type ext3 (rw) 
/dev/ide/host0/bus0/target0/lun0/part8 on /data type ext3 (rw) 
/dev/ide/host0/bus0/target1/lun0/part1 on /video type ext3 (rw,nosuid,nodev) 
usbfs on /proc/bus/usb type usbfs (rw) 
none on /sys type sysfs (rw) 
/dev/scsi/host3/bus0/target0/lun0/part1 on /dimagex type vfat (rw) 
smartass:/home/lsa# umount /dimagex/ 
Speicherzugriffsfehler 
smartass:/home/lsa# umount /dimagex 
umount: /dev/scsi/host3/bus0/target0/lun0/part1: Nicht gefunden 
umount: /dimagex ist nicht eingehängt 
umount: /dev/scsi/host3/bus0/target0/lun0/part1: Nicht gefunden 
umount: /dimagex ist nicht eingehängt 
smartass:/home/lsa# umount /dimagex 
umount: /dimagex ist nicht eingehängt 
smartass:/home/lsa# mount 
/dev/ide/host0/bus0/target0/lun0/part5 on / type ext2 (rw,errors=remount-ro) 
proc on /proc type proc (rw) 
devpts on /dev/pts type devpts (rw,gid=5,mode=620) 
/dev/ide/host0/bus0/target0/lun0/part1 on /boot type ext3 (rw) 
/dev/ide/host0/bus0/target0/lun0/part6 on /var type ext3 (rw) 
/dev/ide/host0/bus0/target0/lun0/part3 on /var/log type ext3 (rw) 
/dev/ide/host0/bus0/target0/lun0/part7 on /home type ext3 (rw) 
/dev/ide/host0/bus0/target0/lun0/part8 on /data type ext3 (rw) 
/dev/ide/host0/bus0/target1/lun0/part1 on /video type ext3 (rw,nosuid,nodev) 
usbfs on /proc/bus/usb type usbfs (rw) 
none on /sys type sysfs (rw) 
 
(sysfs not used anywhere, devfsd running) 
 
dmesg output: 
 
hub 3-0:1.0: new USB device on port 2, assigned address 5 
scsi3 : SCSI emulation for USB Mass Storage devices 
  Vendor: MINOLTA   Model: MINOLTA DIMAGE X  Rev: 1.00 
  Type:   Direct-Access                      ANSI SCSI revision: 02 
SCSI device sdd: 246016 512-byte hdwr sectors (126 MB) 
sdd: Write Protect is off 
sdd: Mode Sense: 00 1c 00 00 
sdd: cache data unavailable 
sdd: assuming drive cache: write through 
 /dev/scsi/host3/bus0/target0/lun0: p1 
Attached scsi removable disk sdd at scsi3, channel 0, id 0, lun 0 
WARNING: USB Mass Storage data integrity not assured 
USB Mass Storage device found at 5 
usb 3-2: USB disconnect, address 5 
Unable to handle kernel NULL pointer dereference at virtual address 00000010 
 printing eip: 
e0b2dcc9 
*pde = 00000000 
Oops: 0000 [#1] 
CPU:    0 
EIP:    0060:[<e0b2dcc9>]    Not tainted 
EFLAGS: 00010286 
EIP is at scsi_device_put+0x15/0x94 [scsi_mod] 
eax: e0b47560   ebx: c0d85b40   ecx: e0b47574   edx: e0b47560 
esi: 00000000   edi: 00000003   ebp: dffe108c   esp: cc1fbee0 
ds: 007b   es: 007b   ss: 0068 
Process umount (pid: 24073, threadinfo=cc1fa000 task=d80486a0) 
Stack: c0d85b40 00000000 e09de657 00000000 dffe1080 d813fb80 c01521de 
dffe10cc 
       00000000 dffe10cc 00000000 dffe1280 cc1fa000 e09e1900 dffe128c c01521a4 
       dffe1080 00000003 dffe12cc 00000000 d62ba800 dffe1280 e0ac06c0 cc1fa000 
Call Trace: 
 [<e09de657>] sd_release+0x3f/0x74 [sd_mod] 
 [<c01521de>] blkdev_put+0x18e/0x1b0 
 [<c01521a4>] blkdev_put+0x154/0x1b0 
 [<c0150f87>] kill_block_super+0x23/0x2c 
 [<c0150302>] deactivate_super+0x42/0x80 
 [<c016383c>] sys_umount+0x34/0x7c 
 [<c01410e6>] do_munmap+0x106/0x148 
 [<c016388f>] sys_oldumount+0xb/0x10 
 [<c010b577>] syscall_call+0x7/0xb 
 
Code: 8b 46 10 8b 40 44 8b 00 85 c0 74 1f bb 00 e0 ff ff 21 e3 ff 
 <6>hub 3-0:1.0: new USB device on port 2, assigned address 6 
scsi4 : SCSI emulation for USB Mass Storage devices 
  Vendor: MINOLTA   Model: MINOLTA DIMAGE X  Rev: 1.00 
  Type:   Direct-Access                      ANSI SCSI revision: 02 
SCSI device sdd: 246016 512-byte hdwr sectors (126 MB) 
sdd: Write Protect is off 
sdd: Mode Sense: 00 1c 00 00 
sdd: cache data unavailable 
sdd: assuming drive cache: write through 
 
(last lines are for reconnecting the USB camera). 
 
then cat /proc/scsi/scsi just hangs forever. 
 2221 pts/0    S      0:00  |   \_ /bin/bash 
 2953 pts/0    S      0:00  |   |   \_ bash 
24399 pts/0    D      0:00  |   |       \_ cat /proc/scsi/scsi 
 
# uname -a 
Linux smartass 2.6.0-test7-1-386 #1 Sun Oct 12 10:29:56 EST 2003 i686 GNU/Linux 

