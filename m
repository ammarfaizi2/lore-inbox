Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWBXPE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWBXPE0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 10:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWBXPE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 10:04:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22928 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932243AbWBXPEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 10:04:25 -0500
Subject: GFS2 Filesystem [16/16]
From: Steven Whitehouse <swhiteho@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 24 Feb 2006 15:08:35 +0000
Message-Id: <1140793715.6400.740.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 16/16] GFS2: 

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
@@ -999,6 +999,7 @@ void tty_write_message(struct tty_struct
 		tty->driver->write(tty, msg, strlen(msg));
 	return;
 }
+EXPORT_SYMBOL_GPL(tty_write_message);
 
 /*
  * printk rate limiting, lifted from the networking subsystem.
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -981,6 +981,7 @@ success:
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


