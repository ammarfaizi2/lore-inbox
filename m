Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965153AbWJJMO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbWJJMO7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 08:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbWJJMO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 08:14:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:10393 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965137AbWJJMO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 08:14:58 -0400
Date: Tue, 10 Oct 2006 14:14:37 +0200
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH 1/2] Fix IO error reporting on fsync() (2nd try)
Message-ID: <20061010121437.GH23622@atrey.karlin.mff.cuni.cz>
References: <20061010121250.GG23622@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010121250.GG23622@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When IO error happens during async write, we have to mark buffer as having IO
error too. Otherwise IO error reporting for filesystems like ext2 does not
work.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.18/fs/buffer.c linux-2.6.18-1-mark_error_buffer/fs/buffer.c
--- linux-2.6.18/fs/buffer.c	2006-09-27 13:08:34.000000000 +0200
+++ linux-2.6.18-1-mark_error_buffer/fs/buffer.c	2006-10-06 13:05:29.000000000 +0200
@@ -589,6 +589,7 @@ static void end_buffer_async_write(struc
 			       bdevname(bh->b_bdev, b));
 		}
 		set_bit(AS_EIO, &page->mapping->flags);
+		set_buffer_write_io_error(bh);
 		clear_buffer_uptodate(bh);
 		SetPageError(page);
 	}

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
