Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287933AbSBIBbJ>; Fri, 8 Feb 2002 20:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288021AbSBIBbA>; Fri, 8 Feb 2002 20:31:00 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:37296 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S287933AbSBIBaw>;
	Fri, 8 Feb 2002 20:30:52 -0500
Date: Fri, 8 Feb 2002 20:30:51 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Skip Ford <skip.ford@verizon.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: de_put: entry sys already free!
In-Reply-To: <20020209011023.UBOE29231.out007.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Message-ID: <Pine.GSO.4.21.0202082030080.28514-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Feb 2002, Skip Ford wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Just an FYI, I've received this syslog message twice now with
> 2.5.4-pre3:  'de_put: entry sys already free!'.
> 
> It seems to be harmless, but I'd thought I'd post it.  It's just a
> procfs error message, but maybe somebody out there has a clue why it's
> being generated (aside from what the message says).

Fix already merged and no, it's not quite harmless.

--- fs/proc/base.c	Thu Feb  7 19:25:52 2002
+++ /tmp/base.c	Fri Feb  8 18:36:41 2002
@@ -1003,8 +1003,7 @@
 		ei = PROC_I(inode);
 		inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 		inode->i_ino = fake_ino(0, PROC_PID_INO);
-		ei->file = NULL;
-		ei->task = NULL;
+		ei->pde = NULL;
 		inode->i_mode = S_IFLNK|S_IRWXUGO;
 		inode->i_uid = inode->i_gid = 0;
 		inode->i_size = 64;

