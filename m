Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262939AbTCSHao>; Wed, 19 Mar 2003 02:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262940AbTCSHao>; Wed, 19 Mar 2003 02:30:44 -0500
Received: from franka.aracnet.com ([216.99.193.44]:35549 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262939AbTCSHam>; Wed, 19 Mar 2003 02:30:42 -0500
Date: Tue, 18 Mar 2003 23:41:30 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 471] New: Root on software raid don't boot on new 2.5 kernel since after 2.5.45 
Message-ID: <779600000.1048059690@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=471

           Summary: Root on software raid don't boot on new 2.5 kernel since
                    after 2.5.45
    Kernel Version: 2.5.65
            Status: NEW
          Severity: high
             Owner: bugme-janitors@lists.osdl.org
         Submitter: tlb@rapanden.dk


Distribution: 
 Linux Mandrake 9.0 (std kernel 2.4.21-pre1)
Hardware Environment:
 ASUS A7M266-D ACPI BIOS Revision 1006
 Promise 20268 PCI IDE Controler
 Intel Ethernet Pro 100
 ATI Radeon QD

Problem Description:
 The software raid setup I have boots on 2.4 but not on newer 2.5 kernels, i
have everything need compiled in and the 2.5 kernel also rapports that it has
found /dev/md2 but it rapports that is's unable to mount the root partition for
this device. I have tried to pass /dev/md0 as the root but this hangs the
kernel, is root on raid broaken in kernel 2.5 or am I doing something wrong?

 lilo:
  image=/boot/vmlinuz-2.4.21-pre1
        label=linux
        root=/dev/md2
        read-only
        append=" devfs=mount"

  image=/boot/vmlinuz-2.5.65
        label=linux25
        root=/dev/md2
        read-only
        append=" devfs=mount"

 fdisk:
  /dev/hda1             1     20318  10240240+   7  HPFS/NTFS
  /dev/hda2         20319    116301  48375432    5  Extended
  /dev/hda5         20319     20522    102784+  83  Linux
  /dev/hda6         20523     22554   1024096+  83  Linux
  /dev/hda7         22555    116301  47248456+  fd  Linux raid autodetect

  mdadm: # UUID removed
   #devices=/dev/hdd5,/dev/hdc5
   ARRAY /dev/md0 level=raid1 num-devices=2 
   #devices=/dev/hdd6,/dev/hdc6
   ARRAY /dev/md1 level=raid1 num-devices=2
   #devices=/dev/hdd7,/dev/hdc7
   ARRAY /dev/md2 level=raid1 num-devices=2 
   #devices=/dev/hdg5,/dev/hde5
   ARRAY /dev/md3 level=raid0 num-devices=2

  mount:
  /dev/md0 on /boot type ext3 (rw)
  /dev/md2 on / type reiserfs (rw,notail)
  /dev/md3 on /dist type reiserfs (rw,notail)

  fstab:
   /dev/md2 / reiserfs notail 1 1
   /dev/md0 /boot ext3 defaults 1 2
   /dev/md1 swap swap defaults 0 0
   /dev/md3 /dist reiserfs notail 1 1

