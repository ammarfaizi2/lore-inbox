Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVHCQbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVHCQbZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 12:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVHCQbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 12:31:25 -0400
Received: from mx1.invoca.ch ([157.161.91.34]:31174 "EHLO ns1.invoca.ch")
	by vger.kernel.org with ESMTP id S261349AbVHCQbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 12:31:24 -0400
Message-ID: <45138.213.188.237.106.1123086677.squirrel@localhost>
Date: Wed, 3 Aug 2005 18:31:17 +0200 (CEST)
Subject: File corruption on LVM2 on top of software RAID1
From: "Simon Matter" <simon.matter@invoca.ch>
To: linux-kernel@vger.kernel.org
Cc: kernel-maint@redhat.com, simon.matter@invoca.ch
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please CC me as I'm not subscribed to the kernel list.

I had a hard time identifying a serious problem in the 2.6 linux kernel.
It all started while evaluating RHEL4 for new servers. My data integrity
tests gave me bad results - which I couldn't believe - and my first idea
was - of course - bad hardware. I ordered new SCSI disks instead of the
IDE disks, took another server, spent some money again, tried again and
again. That's all long ago now...

In my tests I get corrupt files on LVM2 which is on top of software raid1.
(This is a common setup even mentioned in the software RAID HOWTO and has
worked for me on RedHat 9 / kernel 2.4 for a long time now and it's my
favourite configuration). Now, I tested two different distributions, three
kernels, three different filesystems and three different hardware. I can
always reproduce it with the following easy scripts:

LOGF=/root/diff.log
while true; do
  rm -rf /home/XXX2
  rsync -a /home/XXX/ /home/XXX2
  date >> $LOGF
  diff -r /home/XXX /home/XXX2 >> $LOGF
done

the files in /home/XXX are ~15G of ISO images and rpms.

diff.log looks like this:
Wed Aug  3 13:45:57 CEST 2005
Binary files /home/XXX/ES3-U3/rhel-3-U3-i386-es-disc3.iso and
/home/XXX2/ES3-U3/rhel-3-U3-i386-es-disc3.iso differ
Wed Aug  3 14:09:14 CEST 2005
Binary files /home/XXX/8.0/psyche-i386-disc1.iso and
/home/XXX2/8.0/psyche-i386-disc1.iso differ
Wed Aug  3 14:44:17 CEST 2005
Binary files /home/XXX/7.3/valhalla-i386-disc3.iso and
/home/XXX2/7.3/valhalla-i386-disc3.iso differ
Wed Aug  3 15:15:05 CEST 2005
Wed Aug  3 15:45:40 CEST 2005


Tested software:
1) RedHat EL4
kernel-2.6.9-11.EL
vanilla 2.6.12.3 kernel
filesystems: EXT2, EXT3, XFS

2) NOVELL/SUSE 9.3
kernel-default-2.6.11.4-21.7
filesystem: EXT3

Tested Hardware:
1)
- ASUS P2B-S board
- CPU PIII 450MHz
- Intel 440BX/ZX/DX Chipset
- 4x128M memory (ECC enabled)
- 2x IDE disks Seagate Barracuda 400G, connected to onboard "Intel PIIX4
Ultra 33"
- Promise Ultra100TX2 adapter for additional tests

2)
- DELL PowerEdge 1400
- CPU PIII 800MHz
- ServerWorks OSB4 Chipset
- 4x256M memory (ECC enabled)
- 2x U320 SCSI disks Maxtor Atlas 10K 146G
- onboard Adaptec aic7899 Ultra160 SCSI adapter

3)
- DELL PowerEdge 1850
- CPU P4 XEON 2.8GHz
- 2G memory
- 2x U320 SCSI disks Maxtor Atlas 10K 73G SCA
- onboard LSI53C1030 SCSI adapter

I've put some files toghether from the last test on the PE1850 server:
http://www.invoca.ch/bugs/linux-2.6-corruption-on-lvm2-on-raid1/

I've also filed a bug with RedHat:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=164696

I have spent a lot of time on this bug because I consider it very serious.
I'm not a kernel hacker but if there is anything I can do to fix this, let
me know.

Simon

