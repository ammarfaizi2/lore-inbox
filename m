Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265336AbSJRTfY>; Fri, 18 Oct 2002 15:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265330AbSJRTfU>; Fri, 18 Oct 2002 15:35:20 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:23950 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265322AbSJRTfS>;
	Fri, 18 Oct 2002 15:35:18 -0400
Subject: [ANNOUNCE]  Journaled File System (JFS)  release 1.0.24
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF3D8E5A8B.F23AA2EF-ON85256C56.006BE407@pok.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Fri, 18 Oct 2002 14:41:09 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 10/18/2002 03:41:13 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Release 1.0.24 of JFS was made available today.

Drop 62 on October 18, 2002 (jfs-2.4-1.0.24.tar.gz
and jfsutils-1.0.24.tar.gz) includes fixes to the file
system and utilities.

Utilities changes

- byte-swapping fixes for big-endian hardware
  (fixes in logredo and fsck.jfs)


File System changes

- readSuper() was incorrectly checking return status of sb_bread()
- change name of get_index to read_index fixes MIPS build issue
- Releasing LOGGC_LOCK too early
   In txLazyCommit, we are releasing log->gclock (LOGGC_LOCK) before
   checking tblk->flag for tblkGC_LAZY. For the case that tblkGC_LAZY
   is not set, the user thread may release the tblk, and it may be
   reused and the tblkGC_LAZY bit set again, between the time we release
   the spinlock until we check the flag. This problem is easy to hit on
   a 2.5 kernel with CONFIG_PREEMPT set, but it is a potential problem
   on SMP as well.
   The fix is to hold the spinlock until after we've checked the flag.

For more details about JFS, please see the patch instructions or
changelog.jfs files.


Steve
JFS for Linux http://oss.software.ibm.com/jfs


