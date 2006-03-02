Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbWCBVJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbWCBVJu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 16:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbWCBVJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 16:09:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1974 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932540AbWCBVJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 16:09:49 -0500
Message-ID: <44075F1C.6030201@redhat.com>
Date: Thu, 02 Mar 2006 16:09:48 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ramfs needs to update directory m/ctime on symlink
Content-Type: multipart/mixed;
 boundary="------------030205000206040600080702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030205000206040600080702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Attached is a patch which addresses a problem in ramfs where it neglects
to update the directory mtime and ctime fields when creating a new symbolic
link.  Ramfs was modified in 2.6.15 to update these fields when other types
of entries are created.  The symlink support is separate from that other
support, so that change did not cover quite all of the possibilities.

All of the directory content manipulation entry points now seem to be
covered with respect to these time field updates.

    Thanx...

       ps

Signed-off-by: Peter Staubach <staubach@redhat.com>

--------------030205000206040600080702
Content-Type: text/plain;
 name="ramfs.devel"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ramfs.devel"

--- linux-2.6.15.x86_64/fs/ramfs/inode.c.org
+++ linux-2.6.15.x86_64/fs/ramfs/inode.c
@@ -137,6 +137,7 @@ static int ramfs_symlink(struct inode * 
 				inode->i_gid = dir->i_gid;
 			d_instantiate(dentry, inode);
 			dget(dentry);
+			dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 		} else
 			iput(inode);
 	}

--------------030205000206040600080702--
