Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267488AbSLEVVv>; Thu, 5 Dec 2002 16:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267485AbSLEVVC>; Thu, 5 Dec 2002 16:21:02 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:3335
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267482AbSLEVT7>; Thu, 5 Dec 2002 16:19:59 -0500
Subject: 2.5: ext3 bug or dying drive?
From: Robert Love <rml@tech9.net>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1039123660.1433.12.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 05 Dec 2002 16:27:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Overnight, 2.5.50-mm1 took a big stinky shit:

        EXT3-fs error (device sd(8,1)): ext3_readdir: bad entry in directory #243371: rec_len % 4 != 0 - offset=1688, inode=243681, rec_len=109, name_len=27
        Aborting journal on device sd(8,1).
        ext3_abort called.
        EXT3-fs abort (device sd(8,1)): ext3_journal_start: Detected aborted journal
        Remounting filesystem read-only
        EXT3-fs error (device sd(8,1)) in start_transaction: Journal has aborted
        EXT3-fs error (device sd(8,1)): ext3_readdir: bad entry in directory #243371: rec_len % 4 != 0 - offset=1688, inode=243681, rec_len=109, name_len=27
        EXT3-fs error (device sd(8,1)) in ext3_setattr: Journal has aborted
        EXT3-fs error (device sd(8,1)) in start_transaction: Journal has aborted
        EXT3-fs error (device sd(8,1)) in start_transaction: Journal has aborted

Nothing particularly interesting was going on (mostly idle X desktop). 
I woke up and noticed the fs was mounted ro.  The above was in dmesg.

Rebooted and ext3 replayed the journal and said a manual check was
needed due to I/O error on the journal.  Ran fsck manually, it found a
whole bunch of orphan inodes including some scary errors like "inode
part of corrupt orphan inode list" or similar.

Rebooted again to force another fsck to be sure, and sure enough it
found more problems.  Ugh.  I started thinking bad hard drive.

Back up in X, and the same dmesg error occurred again.  Repeat above.

Now I am in 2.4 and all seems well.  So perhaps not hard drive?

IBM U2W drive on a 2940U2W if it matters.  UP kernel.

	Robert Love

