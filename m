Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUFNAuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUFNAuY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 20:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUFNAsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 20:48:41 -0400
Received: from holomorphy.com ([207.189.100.168]:32925 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261582AbUFNArF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 20:47:05 -0400
Date: Sun, 13 Jun 2004 17:47:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [11/12] fix isofs ignoring noexec and mode mount options
Message-ID: <20040614004701.GZ1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040614003331.GP1444@holomorphy.com> <20040614003459.GQ1444@holomorphy.com> <20040614003605.GR1444@holomorphy.com> <20040614003708.GS1444@holomorphy.com> <20040614003835.GT1444@holomorphy.com> <20040614003929.GU1444@holomorphy.com> <20040614004034.GV1444@holomorphy.com> <20040614004147.GW1444@holomorphy.com> <20040614004354.GX1444@holomorphy.com> <20040614004516.GY1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614004516.GY1444@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 * Removed period check for executables in fs/isofs/inode.c
This fixes Debian BTS #162190
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=162190

	From: Jan Gregor <gregor_jan@seznam.cz>
	To: Debian Bug Tracking System <submit@bugs.debian.org>
	Subject: kernel-source-2.4.18: kernel ignores noexec and mode option in cdrom case
	Message-ID: <20020924162129.A328@pisidlo>

In /etc/fstab i have following line:
/dev/cdrom      /cdrom          iso9660  gid=100,noauto,ro,noexec,mode=0444,user      0       0

I found on one CD that some files have exec bit set. From brief view
those files has no extension (filename.ext).

My drive is asus-1610a (ATAPI writer) connected throught scsi-emulation.


Index: linux-2.5/fs/isofs/inode.c
===================================================================
--- linux-2.5.orig/fs/isofs/inode.c	2004-06-13 11:57:34.000000000 -0700
+++ linux-2.5/fs/isofs/inode.c	2004-06-13 12:08:57.000000000 -0700
@@ -1250,14 +1250,6 @@
 		inode->i_mode = sbi->s_mode;
 		inode->i_nlink = 1;
 	        inode->i_mode |= S_IFREG;
-		/* If there are no periods in the name,
-		 * then set the execute permission bit
-		 */
-		for(i=0; i< de->name_len[0]; i++)
-			if(de->name[i]=='.' || de->name[i]==';')
-				break;
-		if(i == de->name_len[0] || de->name[i] == ';')
-			inode->i_mode |= S_IXUGO; /* execute permission */
 	}
 	inode->i_uid = sbi->s_uid;
 	inode->i_gid = sbi->s_gid;
