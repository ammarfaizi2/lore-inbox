Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290616AbSARHSN>; Fri, 18 Jan 2002 02:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290617AbSARHSD>; Fri, 18 Jan 2002 02:18:03 -0500
Received: from goliath.siemens.de ([194.138.37.131]:44716 "EHLO
	goliath.siemens.de") by vger.kernel.org with ESMTP
	id <S290616AbSARHRv>; Fri, 18 Jan 2002 02:17:51 -0500
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: zdzichu@irc.pl
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS on 2.4.17 -18pre4 while mounting root (reiserfs, on LVM, devfs)
Date: Fri, 18 Jan 2002 10:17:14 +0300
Message-ID: <002c01c19ff0$2885a860$21c9ca95@mow.siemens.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
x-mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> VFS: Mounted root (reiserfs filesystem) readonly. 
> devfs: devfs_do_symlink(root): could not append to parent, err: -17 
> change_root: old root has d_count=2

17 == EEXIST

Your mkinitrd creates /dev/root in any form and devfs_do_symlink(root)
fails. We had the same pornlem in mandrake and Juan ended up commenting
it out in fs/super.c:

//              devfs_mk_symlink (NULL, "root", DEVFS_FL_DEFAULT,
//                                name + 5, NULL, NULL);


-andrej
