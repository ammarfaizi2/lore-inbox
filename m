Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130770AbRCMCGs>; Mon, 12 Mar 2001 21:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130775AbRCMCGi>; Mon, 12 Mar 2001 21:06:38 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:14859
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S130770AbRCMCGd>; Mon, 12 Mar 2001 21:06:33 -0500
Date: Mon, 12 Mar 2001 21:06:14 -0500
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org
cc: viro@math.psu.edu
Subject: named pipe writes on readonly filesystems
Message-ID: <517520000.984449174@tiny>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Since fs/pipe.c:pipe_write() calls mark_inode_dirty, and it is legal to
write to a named pipe on a readonly filesystem, we can end up writing an
inode on a readonly FS.

reiserfs prints a warning whenever someone tries to write an inode on a
readonly FS, so we've been getting a few complaints about this.

I see at least 3 choices:

drop the reiserfs warning, it was only there to chase things similar to the
remount root readonly bug in 2.4.0.

change mark_inode_dirty or write_inode to exit early on readonly
filesystems.

change pipe_write to leave the inode clean when the FS is readonly.

Does anyone have a preference?  I'd rather not see each FS have to check
for this on their own, but the other filesystems aren't as picky as
reiserfs in this case ;-)

-chris

