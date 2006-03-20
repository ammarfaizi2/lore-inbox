Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbWCTVhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWCTVhr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWCTVhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:37:23 -0500
Received: from mailhub-3.iastate.edu ([129.186.140.13]:231 "EHLO
	mailhub-3.iastate.edu") by vger.kernel.org with ESMTP
	id S964978AbWCTVhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:37:18 -0500
Subject: VFAT: Can't create file named 'aux.h'?
From: Dirk Reiners <dreiners@iastate.edu>
Reply-To: dreiners@iastate.edu
To: linux-kernel@vger.kernel.org
Cc: Dirk Reiners <dreiners@iastate.edu>
Content-Type: text/plain
Organization: Iowa State University
Date: Mon, 20 Mar 2006 15:40:22 -0600
Message-Id: <1142890822.5007.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16.3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi everybody,

while trying to back up a couple Linux directories to a FAT disk I ran
into a weird situation: I can't create a file called aux.h on the FAT
system! 

Here's how to reproduce it:

cd /tmp
dd if=/dev/zero of=vfat_img bs=1M count=1
/sbin/losetup /dev/loop7 vfat_img
/sbin/mkfs.vfat /dev/loop7
mkdir vfat_mnt
mount -t vfat /dev/loop7 vfat_mnt
touch vfat_mnt/auy.h
touch vfat_mnt/aux.h

auy.h is happily created, aux.h gives "touch: setting times of
`vfat_mnt/aux.h': No such file or directory", and no file is created.
This happened to me on the system described below, but I could reproduce
the same behavior on a system booted from RHEL4 CDs, an old Knoppix
(3.4), and friends could reproduce it on other systems, too, so it
doesn't seem to be very related to a specific version.

As a workaround I tar/bzipped my dirs, but that behavior seems very
unusual and doesn't inspire a lot of confidence in vfat... What am I
missing here?

Thanks

	Dirk


Here's my system (RHEL4 with updated kernel):

Linux dream.vrac 2.6.15.6 #1 SMP PREEMPT Tue Mar 14 10:41:05 CST 2006
x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  3.4.3
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12a
mount                  2.12a
module-init-tools      3.1-pre5
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   039
Modules Loaded         loop vmnet vmmon parport_pc lp parport autofs4
sunrpc ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables vfat
fat dm_mod button battery ac nvidia ipv6 usb_storage ohci1394 ohci_hcd
ehci_hcd i2c_nforce2 i2c_core snd_intel8x0 snd_ac97_codec snd_ac97_bus
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc
forcedeth floppy raid0 sata_nv libata sd_mod scsi_mod


