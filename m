Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbVLSO5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbVLSO5p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 09:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbVLSO5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 09:57:45 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:32742 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S932131AbVLSO5o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 09:57:44 -0500
Message-ID: <43A6CA3A.5010905@namesys.com>
Date: Mon, 19 Dec 2005 17:56:58 +0300
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: bug in get_name of export operations?
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Please point my error if I am wrong:

fs/exportfs/expfs.c:get_name() opens a directory with:
file = dentry_open(dget(dentry), NULL, O_RDONLY);
which results in file where file->f_vfsmnt == NULL.

Then fs/readdir.c:vfs_readdir() and, therefore,
include/linux/fs.h:file_accessed(file) are called.
file_accessed() calls fs/inode.c:touch_atime() which tryies to dereference mnt
which is NULL.




