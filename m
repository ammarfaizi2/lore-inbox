Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSIICL0>; Sun, 8 Sep 2002 22:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316235AbSIICL0>; Sun, 8 Sep 2002 22:11:26 -0400
Received: from web40508.mail.yahoo.com ([66.218.78.125]:5447 "HELO
	web40508.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S316210AbSIICL0>; Sun, 8 Sep 2002 22:11:26 -0400
Message-ID: <20020909021604.73867.qmail@web40508.mail.yahoo.com>
Date: Sun, 8 Sep 2002 19:16:04 -0700 (PDT)
From: Seaman Hu <seaman_hu@yahoo.com>
Subject: ext3 fs boot crash [2.4.18-18]
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Platform Info:

/dev/sda1  /boot ext3
/dev/sda2  /     ext3 
Kernel version: 2.4.18-17

Problem: 
My system has initrd which contains some modules about
scsi,ext3,etc. During the boot sequence, my system
will crash sometimes(about five times crash once) when
it creates "/boot/kernel.h". Examining fs/namei.c
open_namei(), In failure turn, I found after
path_lookup(), vfs_create() will be called. however,
in vfs_create(), ext2_create() instead of
ext3_create() will be called. While in successful
turn, vfs_create() will not be called. 

At the same time, I printed out inode infomation(boot
inode) after path_lookup.  "after path_lookup().
nd->dentry->d_inode->i_dev:[256],
nd->dentry->d_inode->i_sb->s_dev:[2049]". here, i_dev:
(1,0) /dev/ram0 while s_dev:(8,1) /dev/sda1. why there
is inconsistent info in inode(boot inode) ?

any comments? thanks very much in advance. 


Seaman



__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
