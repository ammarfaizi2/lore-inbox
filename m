Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277146AbRJDHFk>; Thu, 4 Oct 2001 03:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277147AbRJDHF1>; Thu, 4 Oct 2001 03:05:27 -0400
Received: from willy.wsc.edu ([192.150.175.61]:12815 "EHLO willy.wsc.edu")
	by vger.kernel.org with ESMTP id <S277146AbRJDHFW>;
	Thu, 4 Oct 2001 03:05:22 -0400
Date: Thu, 4 Oct 2001 02:05:50 -0500
From: Josh Samuelson <jsamuels@willy.wsc.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.10 kernel Oops with compressed ramdisk
Message-ID: <20011004020550.A1271@willy.wsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

When attempting to load a compressed ramdisk from a floppy, the kernel
has a NULL pointer dereference.  The problem occurs inside of
rd_load_image().  rd_load_image() -> identify_ramdisk_image() ->
do_generic_file_read() -> update_atime() is the call trace.
inode->i_sb is not being set somewhere and the macro IS_NOATIME attempts
to dereference it.

#define IS_NOATIME(inode)   (__IS_FLG(inode, MS_NOATIME) || ((inode)->i_flags & S_NOATIME))

#define __IS_FLG(inode,flg) ((inode)->i_sb->s_flags & (flg))

Any ideas where inode->i_sb should be set?
