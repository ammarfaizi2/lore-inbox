Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031609AbWLEV2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031609AbWLEV2W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031601AbWLEV2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:28:22 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:34150 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031560AbWLEV2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:28:21 -0500
Date: Tue, 5 Dec 2006 22:21:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 20/35] Unionfs: Directory manipulation helper functions
In-Reply-To: <11652354711791-git-send-email-jsipek@cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0612052218360.18570@yvahk01.tjqt.qr>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
 <11652354711791-git-send-email-jsipek@cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+++ b/fs/unionfs/dirhelper.c

>+/* This filldir function makes sure only whiteouts exist within a directory. */
>+static int readdir_util_callback(void *dirent, const char *name, int namelen,
>+				 loff_t offset, u64 ino, unsigned int d_type)
>+{
>+	int err = 0;
>+	struct unionfs_rdutil_callback *buf = dirent;
>+	int whiteout = 0;
>+	struct filldir_node *found;
>+
>+	buf->filldir_called = 1;
>+
>+	if (name[0] == '.'
>+	    && (namelen == 1 || (name[1] == '.' && namelen == 2)))
>+		goto out;
>+
>+	if (namelen > UNIONFS_WHLEN && !strncmp(name, UNIONFS_WHPFX, UNIONFS_WHLEN)) {

When I see this if, I feel like asking (unrelated to dirhelper.c):
what do we do when

 * strlen(UNIONFS_WHPFX filename) is greater than the maximum file
   name length supported by a filesystem?

 * strlen(absolute_path(UNIONFS_WHPFX filename)) is greater than PATH_MAX?



	-`J'
-- 
