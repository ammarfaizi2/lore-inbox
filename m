Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270069AbRHMKbx>; Mon, 13 Aug 2001 06:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270071AbRHMKbn>; Mon, 13 Aug 2001 06:31:43 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:46522 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S270069AbRHMKbc>;
	Mon, 13 Aug 2001 06:31:32 -0400
Date: Mon, 13 Aug 2001 12:31:23 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200108131031.MAA07481@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] 2.4-ac fs/isofs/rock.c cleanup
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

The -ac version of fs/isofs/rock.c contains a debugging printk
which, alas, triggers far too often for some otherwise sane CDs.
This spams the kernel log without delivering any useful information.
The patch below kills the offending printk. Please apply.

(I was browsing the Windows install CD for my new HP CD-Writer
under 2.4.8-ac1. The kernel log filled up with hundreds of

	scanning for RockRidge behind XA attributes

lines. There was approximately one such line for each directory entry.)

/Mikael

--- linux-2.4.8-ac2/fs/isofs/rock.c.~1~	Mon Aug 13 11:33:52 2001
+++ linux-2.4.8-ac2/fs/isofs/rock.c	Mon Aug 13 11:58:23 2001
@@ -454,7 +454,6 @@
    if ((inode->i_sb->u.isofs_sb.s_rock_offset==-1)
        &&(inode->i_sb->u.isofs_sb.s_rock==2))
      {
-	printk(KERN_DEBUG"scanning for RockRidge behind XA attributes\n");
 	result=parse_rock_ridge_inode_internal(de,inode,14);
      };
    return result;
