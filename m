Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVC0JRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVC0JRX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 04:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVC0JRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 04:17:22 -0500
Received: from [81.23.229.73] ([81.23.229.73]:3988 "EHLO mail.eduonline.nl")
	by vger.kernel.org with ESMTP id S261498AbVC0JQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 04:16:16 -0500
From: Norbert van Nobelen <Norbert@edusupport.nl>
Organization: EduSupport
To: linux-kernel@vger.kernel.org
Subject: Proposal for new (meta) filesystem
Date: Sun, 27 Mar 2005 11:16:10 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200503271116.10396.Norbert@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear fellow Linux-kernel maillist users,

I want to present a new (meta) filesystem proposal to you, to consider.
The filesystem is supposed to be optimized for useage of business filesystems, 
mailservers, and other filesystems with an above average amount of repetitive 
data.
Features:
- Depending on the implementation on block level or on file level (as meta 
system): Copy on change of the block or the file.
- Meta database with file features like name, permissions, and checksum per 
block.
- The files itself will not be visual to the users, and will not have an owner 
(not even nobody). The files will only be accessible through references to 
the files.
- The changes are recorded as change on the previous file ala LVM methods but 
then per user or group. The changes do not mean that there is an old version 
which can be accessed, for the user accessing that file, there is just one 
version.
- The changes are kept in a seperate part of the filesystem, which is a 
reserved percentage of the diskspace, but which can be stretched by the 
filesystem of there are more changes then expected. The changes are kept in a 
database like system.
- There is only one change record per file per user/group combination. So in 
case of copy of an already changed file, the file will be made permanent, and 
the copy will get a reference to this new permanent file.
- Deletion of the source file will be virtual as long as it has references to 
it.

Files with different names, dates etc, but with the same binary content will 
be stored only once this way. From the outside nobody will see that this 
happens, backup programs will make a normal backup.
du should report the virtual used space while df should report the virtual 
used space, the optimized use and the real free blocks.

Any more ideas/comments?

Norbert
