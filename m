Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262964AbTC1MdM>; Fri, 28 Mar 2003 07:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262966AbTC1MdM>; Fri, 28 Mar 2003 07:33:12 -0500
Received: from maila.telia.com ([194.22.194.231]:26617 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S262964AbTC1MdL>;
	Fri, 28 Mar 2003 07:33:11 -0500
X-Original-Recipient: <linux-kernel@vger.kernel.org>
Message-ID: <001d01c2f527$c9ebaaf0$0e02a8c0@solveig>
From: "Per Persson" <per.persson@gnosjo.pp.se>
To: <linux-kernel@vger.kernel.org>
Subject: Compilation error 2.5.66 allyesconfig
Date: Fri, 28 Mar 2003 13:44:31 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Making an allyesconfig-kernel doesn't work. There's a problem in
fs/cramfs/inode.c:

[per@linus linux-2.5.66]$ make mrproper; make allyesconfig; make

fs/cramfs/inode.c: In function `get_cramfs_inode':
fs/cramfs/inode.c:54: incompatible types in assignment
make[2]: *** [fs/cramfs/inode.o] Error 1
make[1]: *** [fs/cramfs] Error 2
make: *** [fs] Error 2

It seems to be this line:
inode->i_mtime = inode->i_atime = inode->i_ctime = 0;

inode->i_{m,a,c}time are 'struct timespec' not integers.

Changing the line to the following solves it, but is perhaps not the best
solution:
inode->i_mtime = inode->i_atime = inode->i_ctime = ((struct timespec) {0,
0});

Per Persson
Gnosjö, Sweden

E-mail: per.persson@gnosjo.pp.se


