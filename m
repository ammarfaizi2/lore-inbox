Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWDUQQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWDUQQo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 12:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWDUQQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 12:16:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28844 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932411AbWDUQQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 12:16:41 -0400
Subject: [PATCH 16/16] GFS2: Exported functions
From: Steven Whitehouse <swhiteho@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 21 Apr 2006 17:25:16 +0100
Message-Id: <1145636716.3856.124.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 16/16] GFS2: Exported functions

Export tty_write_message(). This is required by the quota code and is
used in the same way as the core kernel quota code uses it. Also
export the routine for initialising ra_state structures and the
file_read_actor for GFS2's internal read routines.


Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>


 kernel/printk.c |    1 +
 mm/filemap.c    |    1 +
 mm/readahead.c  |    1 +
 3 files changed, 3 insertions(+)

--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -997,6 +997,7 @@ void tty_write_message(struct tty_struct
 		tty->driver->write(tty, msg, strlen(msg));
 	return;
 }
+EXPORT_SYMBOL_GPL(tty_write_message);
 
 /*
  * printk rate limiting, lifted from the networking subsystem.
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1012,6 +1012,7 @@ success:
 	desc->arg.buf += size;
 	return size;
 }
+EXPORT_SYMBOL(file_read_actor);
 
 /*
  * This is the "read()" routine for all filesystems
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -38,6 +38,7 @@ file_ra_state_init(struct file_ra_state 
 	ra->ra_pages = mapping->backing_dev_info->ra_pages;
 	ra->prev_page = -1;
 }
+EXPORT_SYMBOL_GPL(file_ra_state_init);
 
 /*
  * Return max readahead size for this inode in number-of-pages.


