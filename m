Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbTIRTmO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 15:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbTIRTmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 15:42:14 -0400
Received: from bolyai1.elte.hu ([157.181.72.1]:23481 "EHLO bolyai1.elte.hu")
	by vger.kernel.org with ESMTP id S262094AbTIRTmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 15:42:11 -0400
Subject: Loop device and smbmount: I/O error
From: Kovacs Gabor <kgabor@BOLYAI1.ELTE.HU>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Sep 2003 21:45:56 +0200
Message-Id: <1063914356.1639.34.camel@warp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've tried to mount an ext2 filesystem image (ca. 1GB) stored on a WIN
computer via the loop device under 2.4.22: 

(Initially the file scratch2.img is filled with 0s.)

#smbmount //win02/scratch /pro -o username=sambadisk,workgroup=MYDOMAIN
#losetup /dev/loop0 /pro/scratch2.img
#mke2fs /dev/loop0
#mount /dev/loop0 /scratch -t ext2

#cp -r linux-2.4.22 /scratch
cp: cannot create directory `/scratch/linux-2.4.22/drivers/video/sis':
Input/output error
cp: cannot create directory `/scratch/linux-2.4.22/drivers/video/aty':
Input/output error

etc.

#dmesg

EXT2-fs error (device loop(7,0)): read_inode_bitmap: Cannot read inode
bitmap -
block_group = 4, inode_bitmap = 131073
EXT2-fs error (device loop(7,0)): read_block_bitmap: Cannot read block
bitmap -
block_group = 4, block_bitmap = 131072




With 'mount /dev/loop0 /scratch -t ext2 -o sync':

#mkdir somedir
mkdir: cannot create directory `somedir': Input/output error

#dmesg
IO error syncing ext2 inode [loop(7,0):0001e6cf]
IO error syncing ext2 inode [loop(7,0):0001e6cf]

I've found a similar problem in the kernel archives with the topic 'Loop
devices under NTFS' (Aug 27-28 2002) There was mentioned a patch for
2.5.31 to fix this problem. Hasn't been it applied to stable versions
since then? Is there a patch for current versions?


				Thanks
------------------------
Gabor Kovacs, PhD student
Eotvos University, Budapest, Hungary

