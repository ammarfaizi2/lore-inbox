Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264736AbTIIVop (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264740AbTIIVoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:44:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:18907 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264736AbTIIVon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:44:43 -0400
Date: Tue, 9 Sep 2003 14:44:20 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: jffs-dev@axis.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix type mismatch in jffs.
Message-Id: <20030909144420.120d4add.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.6.0-test5 jffs generates a warning about type mismatch because it casting a short
to a pointer.  Look like an obvious typo.

Builds clean, not tested on real hardware.

diff -Nru a/fs/jffs/inode-v23.c b/fs/jffs/inode-v23.c
--- a/fs/jffs/inode-v23.c	Tue Sep  9 14:41:53 2003
+++ b/fs/jffs/inode-v23.c	Tue Sep  9 14:41:53 2003
@@ -1734,7 +1734,7 @@
 		   the device should be read from the flash memory and then
 		   added to the inode's i_rdev member.  */
 		u16 val;
-		jffs_read_data(f, (char *)val, 0, 2);
+		jffs_read_data(f, (char *)&val, 0, 2);
 		init_special_inode(inode, inode->i_mode,
 			old_decode_dev(val));
 	}
