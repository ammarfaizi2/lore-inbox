Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbTKKWj7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 17:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263808AbTKKWj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 17:39:59 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:61110 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263807AbTKKWj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 17:39:58 -0500
Date: Tue, 11 Nov 2003 15:04:58 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Andi Kleen <ak@suse.de>
Subject: [PATCH] zero out i_blocks in get_pipe_inode
Message-ID: <44940000.1068591898@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fished from the 2.4 SuSE tree, which I'm trawling through.
This seems like a perfectly reasonable thing to do to me,
there was some discussion earlier on IRC. Some extracts from
the conversation were "returning random old data from the kernel 
is always a bug", "any userland code that trips on that one is 
broken", and "iirc it broke postfix". Nobody seemed to think it
was actively evil, and it seems to fix a bug ;-)

diff -purN -X /home/mbligh/.diff.exclude virgin/fs/pipe.c pipe_init/fs/pipe.c
--- virgin/fs/pipe.c	2003-10-14 15:50:30.000000000 -0700
+++ pipe_init/fs/pipe.c	2003-11-11 12:13:32.000000000 -0800
@@ -527,6 +527,7 @@ static struct inode * get_pipe_inode(voi
 	inode->i_gid = current->fsgid;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 	inode->i_blksize = PAGE_SIZE;
+	inode->i_blocks = 0;
 	return inode;
 
 fail_iput:

