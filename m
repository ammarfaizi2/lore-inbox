Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270775AbTGVSmV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 14:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270854AbTGVSmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 14:42:21 -0400
Received: from web41509.mail.yahoo.com ([66.218.93.92]:22373 "HELO
	web41509.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270775AbTGVSmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 14:42:15 -0400
Message-ID: <20030722185718.18428.qmail@web41509.mail.yahoo.com>
Date: Tue, 22 Jul 2003 11:57:18 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: Re: 2.6: marking individual directories as synchronous?
To: linux-kernel@vger.kernel.org
Cc: dbehman@hotmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is further info on the use of IS_DIRSYNC in ext2.

ext2_alloc_branch() is used only in the O_DIRECT path.
ext2_commit_chunk() is called indirectly in the following paths, which provide
functionality comparable to that of ext3:

[linux-2.6.0-test1]$ fscope -func=ext2_commit_chunk

ext2_commit_chunk ext2_add_link ext2_add_nondir ext2_create
ext2_commit_chunk ext2_add_link ext2_add_nondir ext2_link
ext2_commit_chunk ext2_add_link ext2_add_nondir ext2_mknod
ext2_commit_chunk ext2_add_link ext2_add_nondir ext2_symlink
ext2_commit_chunk ext2_add_link ext2_mkdir
ext2_commit_chunk ext2_add_link ext2_rename
ext2_commit_chunk ext2_delete_entry ext2_rename
ext2_commit_chunk ext2_delete_entry ext2_unlink ext2_rmdir
ext2_commit_chunk ext2_make_empty ext2_mkdir
ext2_commit_chunk ext2_set_link ext2_rename

FOR CLARITY:

items 1-4 rotated:
ext2_create        ext2_link          ext2_mknod         ext2_symlink
ext2_add_nondir    ext2_add_nondir    ext2_add_nondir    ext2_add_nondir
ext2_add_link      ext2_add_link      ext2_add_link      ext2_add_link
ext2_commit_chunk  ext2_commit_chunk  ext2_commit_chunk  ext2_commit_chunk

items 5-8 rotated:
(null)             (null)             (null)             ext2_rmdir
ext2_mkdir         ext2_rename        ext2_rename        ext2_unlink
ext2_add_link      ext2_add_link      ext2_delete_entry  ext2_delete_entry
ext2_commit_chunk  ext2_commit_chunk  ext2_commit_chunk  ext2_commit_chunk

items 9-10 rotated:
ext2_mkdir         ext2_rename
ext2_make_empty    ext2_set_link
ext2_commit_chunk  ext2_commit_chunk

(See this list for tool 'fscope'.)

_

