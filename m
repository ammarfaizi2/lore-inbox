Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVCARKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVCARKp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 12:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVCARKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 12:10:45 -0500
Received: from vivaldi.madbase.net ([81.173.6.10]:48335 "HELO
	vivaldi.madbase.net") by vger.kernel.org with SMTP id S261981AbVCARKl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 12:10:41 -0500
Date: Tue, 1 Mar 2005 12:10:39 -0500 (EST)
From: Eric Lammerts <eric@lammerts.org>
X-X-Sender: eric@vivaldi.madbase.net
To: linux-kernel@vger.kernel.org
Subject: [PATCH] cramfs: small stat(2) fix
Message-ID: <Pine.LNX.4.58.0503011202170.23751@vivaldi.madbase.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
When I stat(2) a device node on a cramfs, the st_blocks field is
bogus (it's derived from the size field which in this case holds the
major/minor numbers). This makes du(1) output completely wrong.

Please apply the patch below.

Eric

Signed-off-by: Eric Lammerts <eric@lammerts.org>

--- linux-2.6.11-rc5/fs/cramfs/inode.c.orig	2005-03-01 11:10:29.000000000 -0500
+++ linux-2.6.11-rc5/fs/cramfs/inode.c	2005-03-01 11:10:36.000000000 -0500
@@ -70,6 +70,7 @@
 			inode->i_data.a_ops = &cramfs_aops;
 		} else {
 			inode->i_size = 0;
+			inode->i_blocks = 0;
 			init_special_inode(inode, inode->i_mode,
 				old_decode_dev(cramfs_inode->size));
 		}
