Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbWDMXJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbWDMXJN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbWDMXJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:09:12 -0400
Received: from mail.suse.de ([195.135.220.2]:49093 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965006AbWDMXJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:09:10 -0400
Date: Thu, 13 Apr 2006 16:08:07 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, sfr@canb.auug.org.au,
       hch@lst.de
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Al Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 11/22] Fix block device symlink name
Message-ID: <20060413230807.GL5613@kroah.com>
References: <20060413230141.330705000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-block-device-symlink-name.patch"
In-Reply-To: <20060413230637.GA5613@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Stephen Rothwell <sfr@canb.auug.org.au>

As noted further on the this file, some block devices have a / in their
name, so fix the "block:..." symlink name the same as the /sys/block name.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 fs/partitions/check.c |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-2.6.16.5.orig/fs/partitions/check.c
+++ linux-2.6.16.5/fs/partitions/check.c
@@ -345,6 +345,7 @@ static char *make_block_name(struct gend
 	char *name;
 	static char *block_str = "block:";
 	int size;
+	char *s;
 
 	size = strlen(block_str) + strlen(disk->disk_name) + 1;
 	name = kmalloc(size, GFP_KERNEL);
@@ -352,6 +353,10 @@ static char *make_block_name(struct gend
 		return NULL;
 	strcpy(name, block_str);
 	strcat(name, disk->disk_name);
+	/* ewww... some of these buggers have / in name... */
+	s = strchr(name, '/');
+	if (s)
+		*s = '!';
 	return name;
 }
 

--
