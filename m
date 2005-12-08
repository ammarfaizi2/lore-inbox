Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbVLHI75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbVLHI75 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 03:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbVLHI75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 03:59:57 -0500
Received: from mail3.bitpusher.com ([64.127.99.16]:21658 "EHLO
	mail3.bitpusher.com") by vger.kernel.org with ESMTP
	id S1750863AbVLHI74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 03:59:56 -0500
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7BEF1F1F-0ED1-410F-9432-443AF3087D95@halligan.org>
Cc: Michael halligan <michael@halligan.org>
Content-Transfer-Encoding: 7bit
From: "Michael T. Halligan" <michael@halligan.org>
Subject: hde: dma_timer_expiry: dma status == 0x24
Date: Thu, 8 Dec 2005 00:59:45 -0800
To: linux-kernel@vger.kernel.org
X-Pgp-Agent: GPGMail 1.1.1 (Tiger)
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm having some pretty major stability issues with 2.6.5 right now.

The   error consistently occurs when backing up using rsnapshot/rsync  
to backup partitions. It is rather reproducible.
This happens both with rsync in daemon mode, as well as rsync over  
NFS. Happened once after a 450mb upload through
a customer's xml-rpc application, which would have been written  
through a webserver, onto an NFS partition.

The only useful log messages I've ever gotten during a crash, only  
going to the console, are :

  hde: dma_timer_expiry: dma status == 0x24


When the crash occurs, the server responds to pings, and tcp sockets  
remain open.

My operating environment is:

Hardware:

HP DL145 G2, Single & Dual Opteron 246s
Dual 80gb Maxtor drives or Dual 400gb Western Digital drives

Software/Configuration

SLES 9 SP2 x86_64
Kernel 2.6.5-7.201-smp
boot options:     append = "resume=/dev/rootvg/swaplv selinux=0  
load_ramdisk=1 acpi=off console=tty0 console=ttyS2,57600 acpi=off  
splash=silent elevator=cfq"
  - or -
boot options:    append = "resume=/dev/rootvg/swaplv selinux=0  
load_ramdisk=1 acpi=off console=tty0 console=ttyS2,57600 apm=off  
splash=silent elevator=cfq insmod=bcm5700"
All partitions, except for /boot, and swap, are reiserfs, on top of  
lvm2, on top of software raid1.

Kernel modules:
sg                     51128  0
sr_mod                 26788  0
ipv6                  317432  23
af_packet              33676  2
dm_snapshot            25016  0
bcm5700               157660  0
sata_nv                18564  0
ata_piix               19204  0
libata                 59656  2 sata_nv,ata_piix
dm_mod                 69344  11 dm_snapshot
raid1                  24704  1
reiserfs              264816  8
sd_mod                 30208  0
scsi_mod              144128  4 sg,sr_mod,libata,sd_mod

Misc related software:
rsync-2.6.2-8.14
rsnapshot-1.2.1-1
bcm5700-8.3.13a-1 (from hp's website)


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (Darwin)

iD8DBQFDl/YJwjCqooJyNAMRAjIcAKCVo6B9WsBQVc/kO2Cpr4bDbzH13ACgm3sA
rPHTznDAVEUkEuLLyp7YuOA=
=Tc8L
-----END PGP SIGNATURE-----
