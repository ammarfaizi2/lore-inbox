Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbUK0LlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUK0LlJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 06:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbUK0LlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 06:41:09 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:25479 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261188AbUK0LlG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 06:41:06 -0500
Subject: should delete_inode be allowed to be called from shrink_dcache?
From: Vladimir Saveliev <vs@namesys.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1101555657.2229.54.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 27 Nov 2004 14:40:57 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Is there anything wrong that

mkdir dir
cd dir
rmdir ../dir
ls file
cd ..

leaves after itself two dentries - negative one ("file") and dentry of
directory "dir" which is attached to inode of that directory?

After that a process may get into somefs_delete_inode trying to free
pages by shrinking dcache (it will first free negative dentry and then
its parent).
If process is doing that being already in somefs_write (for example)
some filesystems may have problems.


Thanks

