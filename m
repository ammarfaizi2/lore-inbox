Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264072AbRF2VYL>; Fri, 29 Jun 2001 17:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264652AbRF2VYB>; Fri, 29 Jun 2001 17:24:01 -0400
Received: from mailhub2.shef.ac.uk ([143.167.2.154]:49312 "EHLO
	mailhub2.shef.ac.uk") by vger.kernel.org with ESMTP
	id <S264072AbRF2VXs>; Fri, 29 Jun 2001 17:23:48 -0400
Date: Fri, 29 Jun 2001 22:23:43 +0100 (BST)
From: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>
X-X-Sender: <ap1gvl@erdos.shef.ac.uk>
To: <reiserfs-dev@namesys.com>, <linux-kernel@vger.kernel.org>
Subject: 2.4.6-pre3 + reiserfs + NFS peculiarities
In-Reply-To: <3AFBC643.42631F5C@namesys.com>
Message-ID: <Pine.LNX.4.31.0106292129450.13659-100000@erdos.shef.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

We've installed reiserfs on a logical volume, consisting of 2 60GB hard
drives, and exported it over NFS. Kernel 2.4.6-pre3. In the beginning
everything seemed to be fine. But then a few strange things have happened:

1. I tried running a program on a host, importing the filesystem in
question, and sending its output to it.  The program uses fwrite function,
and checks the number of items written, so, it didn't match. On the second
run yet another (similar writing)  problem occured, but since then this
program has been running for a few hours already without any noticeable
errors. The remote host is Solaris-2.7 on a Sparc.

2. Another strangeness - this filesystem is also mounted on yet another
Linux machine, running 2.4.5. Actually, the situation is slightly more
complicated: on host a we've got 2 logical volumes with reiserfs: a1 and
a2, mounted in /mnt/lvm/a1 and /mnt/lvm/a2.  And the whole directory
/mnt/lvm is exported over NFS. So, when on a remote host you do df -k on
that mounted filesystem, all 3 values (total, occupied, free) are wrong.

3. All (except ext2, which is used for /) filesystems are compiled as
modules. reiserfs is loaded on boot, when lvols are mounted. I tried
mounting a fat-diskette, and got the following mesage:

read_old_super_block: try to find super block in old location
read_old_super_block: can't find a reiserfs filesystem on dev 02:00.

If all the problems, mentioned above are known and have known solutions
(patches, etc, however, I checked the reiserfs ftp-site - no patches for
2.4.6 yet), please let me know. Shall I use an earlier kernel version? If
they are new, I'll gladly provide any necessary additional information.
Below is lspci output:

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo Super AC97/Audio] (rev 50)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RT8139 (rev 10)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC AGP (rev 7a)

Thanks
Guennadi
___

Dr. Guennadi V. Liakhovetski
Department of Applied Mathematics
University of Sheffield, Sheffield, U.K.
email: g.liakhovetski@sheffield.ac.uk


