Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264675AbTD0O7r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 10:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264676AbTD0O7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 10:59:47 -0400
Received: from web12802.mail.yahoo.com ([216.136.174.37]:46214 "HELO
	web12802.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264675AbTD0O7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 10:59:47 -0400
Message-ID: <20030427151201.27191.qmail@web12802.mail.yahoo.com>
Date: Sun, 27 Apr 2003 08:12:01 -0700 (PDT)
From: Shantanu Goel <sgoel01@yahoo.com>
Subject: 2.4.21-rc1-ac2 NFS close-to-open question
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In fs/nfs/inode.c:nfs_open() shouldn't the following

if (NFS_SERVER(inode)->flags & NFS_MOUNT_NOCTO) {
  err =
_nfs_revalidate_inode(NFS_SERVER(inode),inode);
  if (err)
    goto out;
}

be

if (!(NFS_SERVER(inode)->flags & NFS_MOUNT_NOCTO)) {
  err =
_nfs_revalidate_inode(NFS_SERVER(inode),inode);
  if (err)
    goto out;
}

If we desire close-to-open consistency, and assuming
my reading of the code is correct, is this a typo?

Thanks.
Shantanu



__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
