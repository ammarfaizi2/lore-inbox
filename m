Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268240AbUIPU7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268240AbUIPU7z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 16:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268254AbUIPU7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 16:59:55 -0400
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:60398 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S268240AbUIPU7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 16:59:22 -0400
Message-ID: <313680C9A886D511A06000204840E1CF0A647184@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'debian-user@lists.debian.org'" <debian-user@lists.debian.org>,
       "'linuxppc-embedded@lists.linuxppc.org'" 
	<linuxppc-embedded@lists.linuxppc.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'Bruce Donadt'" <bdonadt@arabellasw.com>,
       "'Yuli Barcohen'" <yuli@arabellasw.com>
Subject: MORE: problem with initialization while accessing NFS mounted roo
	t file system during the Linux 2.6 boot
Date: Thu, 16 Sep 2004 16:56:32 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also tried "read only" nfs mounting from Arabella's CD-ROM itself (by
modifying 'bootargs" in U-boot environment):

bootargs=root /dev/nfs ro nfsroot=192.168.1.100:/E/fadsroot

In this case booting hangs ...
...
Kernel command line: root /dev/nfs ro nfsroot=192.168.1.100:/E/fadsroot
...
     bootserver=255.255.255.255, rootserver=192.168.1.100, rootpath=
Looking up port of RPC 100003/2 on 192.168.1.100
Looking up port of RPC 100005/1 on 192.168.1.100
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 272k init
Warning: unable to open an initial console.
********  hangs ******


>  -----Original Message-----
> From: 	Povolotsky, Alexander  
> Sent:	Thursday, September 16, 2004 2:23 PM
> To:	'debian-user@lists.debian.org';
> linuxppc-embedded@lists.linuxppc.org; 'linux-kernel@vger.kernel.org'
> Subject:	problem with initialization while accessing NFS mounted root
> file system during the Linux 2.6 boot
> 
> Hi,  
> 
> I've managed to program U-boot bootloader and now am trying to boot my
> PQ2FADS-VR board " vanilla" with Linux 2.6.8-rc4 ...but I have problem
> with the  initialization while accessing NFS mounted root file system ...
> . 
> 
> I have NFS server running on my Windows XP Laptop (that is all I am
> allowed to have, no Linux hosts machine available to me ...). I copied
> entire "fadsroot" directory from Arabella's CD-ROM into my "fadsroot"
> directory on my D-drive and made this directory nfs-shared-mountable (I
> have propagated permissions from "fadsroot" down to all subfolders within
> "fadsroot" ...).
> 
> I noticed several errors during the copy process - complaining that I am
> over-writing the files being already copied - is it an issue with "letter
> case" ? - are there files on the Arabella's CD-ROM "fadsroot", which have
> same names but differ just in the letter case used ?
> 
> What file system support I need to configure while bulding the kernel for
> such case ?
> 
> Anyway I am getting the following error during the end of the boot:
> ......
> device=eth0, addr=192.168.1.103, mask=255.255.255.0, gw=255.255.255.255,
> host=192.168.1.103, domain=, nis-domain=(none),
> bootserver=255.255.255.255, rootserver=192.168.1.100, rootpath=
> Looking up port of RPC 100003/2 on 192.168.1.100
> Looking up port of RPC 100005/1 on 192.168.1.100
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 272k init
> Warning: unable to open an initial console.
> Kernel panic: No init found.  Try passing init= option to kernel.
>  <0>Rebooting in 180 seconds..
> 
> My U-boot environment is:
> => printenv
> bootdelay=5
> bootcmd=bootm 200000
> ipaddr=192.168.1.103
> serverip=192.168.1.100
> ethaddr=08:00:17:00:00:03
> bootargs=root /dev/nfs rw nfsroot=192.168.1.100:/home/apovolot/fadsroot
> baudrate=19200
> stdin=serial
> stdout=serial
> stderr=serial
> 
> Any ideas ?
> Thanks,
> Alex
> 
