Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVAYWih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVAYWih (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbVAYWig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:38:36 -0500
Received: from fmr19.intel.com ([134.134.136.18]:62365 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262196AbVAYWiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:38:12 -0500
Date: Tue, 25 Jan 2005 14:38:06 -0800
From: Mitch Williams <mitch.a.williams@intel.com>
X-X-Sender: mawilli1@mawilli1-desk2.amr.corp.intel.com
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [PATCH 1/2] Disallow appends to sysfs files
Message-ID: <Pine.CYG.4.58.0501251429490.696@mawilli1-desk2.amr.corp.intel.com>
ReplyTo: "Mitch Williams" <mitch.a.williams@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch causes an error to be returned if the caller attempts to open a
sysfs file in append mode.

This patch applies cleanly to 2.6.11-rc1.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>

diff -urpN -X dontdiff linux-2.6.11-clean/fs/sysfs/file.c linux-2.6.11/fs/sysfs/file.c
--- linux-2.6.11-clean/fs/sysfs/file.c	2004-12-24 13:33:50.000000000 -0800
+++ linux-2.6.11/fs/sysfs/file.c	2005-01-24 16:26:21.000000000 -0800
@@ -275,6 +275,11 @@ static int check_perm(struct inode * ino
 	if (!ops)
 		goto Eaccess;

+	/* Is the file is open for append?  Sorry, we don't do that. */
+	if (file->f_flags & O_APPEND) {
+		goto Einval;
+	}
+
 	/* File needs write support.
 	 * The inode's perms must say it's ok,
 	 * and we must have a store method.

