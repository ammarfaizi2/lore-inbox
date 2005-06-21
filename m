Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbVFUVqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbVFUVqS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 17:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbVFUVUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 17:20:22 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:11910 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262371AbVFUVRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:17:52 -0400
Subject: Re: [RFC] [PATCH] OCFS2
From: Steve French <smfltc@us.ibm.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM - Linux Technology Center
Message-Id: <1119388469.5701.145.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 21 Jun 2005 16:14:29 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You list features which OCFS2 does not support yet in fs/Kconfig as:
               - extended attributes
               - readonly mount
               - shared writeable mmap
               - loopback is supported, but data written will not
                 be cluster coherent.
               - quotas
               - cluster aware flock

It also does not appear to support various fcntls, in particular
	F_NOTIFY (directory change notification, needed by Samba. Also
		for various file manager GUIs used by Linux desktops)
	GETLEASE/SETLEASE (also needed for file caching for Samba and	
		IIRC for NFSv4 as well)
and the source tree does not seem to support "POSIX ACLs" (support for
NTFS/CIFS ACLs or the somewhat similar NFSv4 ACLs could also be mapped
by Samba as an alternative, as we do with AFS ACLs today, if you do not
wish to support POSIX ACLs)

The above three (notify/lease/acl) are particularly important for
Samba.  Are those planned for an upcoming release?

You also do not seem to handle fs ioctls - in particular any of the
	chflags/lsattr "ext attributes" (which ext2/ext3/reiser etc.do)
although they are less important.


What is the timestamp granularity in your inode on-disk format?  For
Samba4 supporting at least a 100nanosecond time stamp (used for DCE and
CIFS) is helpful due to the time rounding issues that can come up with
the primitive 1 second timestamp.

