Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVE2WiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVE2WiB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 18:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVE2WiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 18:38:01 -0400
Received: from exo1066.net2.nerim.net ([213.41.175.60]:59431 "EHLO
	mail-out1.exosec.net") by vger.kernel.org with ESMTP
	id S261458AbVE2Who (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 18:37:44 -0400
Date: Mon, 30 May 2005 00:37:39 +0200
From: Willy Tarreau <wtarreau@exosec.fr>
To: linux-kernel@vger.kernel.org
Subject: Linux-2.4.30-hf3
Message-ID: <20050529223739.GA27341@exosec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

here's the third hotfix for 2.4.30. It includes several fixes already
present in 2.4.31-rc1 (mostly security-related), and a few ones reported
very lately :

  - a NULL dereference in serial.c found by Julien Tinnes which could lead
    to an oops.

  - an off-by-one in mtrr.c found by Brad Spengler and reported by J.Tinnes
    which could lead to a panic.

  - a few unchecked strcpy() in ipvs fixed in PaX which I'm not absolutely
    sure are exploitable, but are definitely dirty and risky.

As usual, full and incremental patches for both 2.4.29 and 2.4.30, are
available here :

   http://linux.exosec.net/kernel/2.4-hf/

I've done a full make allmodconfig on both kernels to confirm they still
compile fine, but I've not booted them yet. For users of 2.4.29-hf9 and
2.4.30-hf2, an upgrade is quite recommended. Others might prefer to wait
for official 2.4.31 which we should see very soon now.

Detailed changelog appended.

Regards,
Willy Tarreau
EXOSEC

Changelog From 2.4.30-hf2 to 2.4.30-hf3 (semi-automated)
---------------------------------------
'+' = added ; '-' = removed

+ 2.4.30-ipvs-unchecked-strcpy-1.diff                            (the PaX team)

  Replaced several unchecked strcpy() with strncpy().

+ 2.4.30-loop-off-by-one-1                                      (Julien Tinnes)

  There is an obvious off by one bug in loop.c in kernel 2.4.

+ 2.4.30-rtnetlink-off-by-one-1                                 (Julien Tinnes)

  [RTNETLINK]: Fix off-by-one error in rtnetlink.c

+ 2.4.30-random-poolsize-sysctl-fix-1                           (Vasily Averin)

  [PATCH] random poolsize sysctl fix
  SWSoft Linux kernel Team has discovered that your patch which should fix a
  random poolsize sysctl handler integer overflow, is wrong. You have changed
  a variable definition in function proc_do_poolsize(), but you had to fix an
  another function, poolsize_strategy()

+ 2.4.30-serial-null-dereference-1.diff                         (Julien Tinnes)

  Potential null pointer dereference in serial driver.

+ 2.4.30-mtrr-off-by-one-1.diff                   (Brad Spengler/Julien Tinnes)

  In mtrr_write(), if len==0, -1 is passed to copy_from_user(), which will
  trigger BUG_ON((long)n < 0). Brad found it, Julien explained it to me.

+ 2.4.30-jfs_read_super-oops-1                                    (Mike Kasick)

  [PATCH] JFS oops fix
  Specifically, the kernel attempts to mount root with JFS first, and upon
  aborting jfs_read_super(), the value of sbi->nls_tab is -1, a non-NULL
  value that causes unload_nls() to be called on garbage data leading to a
  NULL pointer dereference.
  
+ 2.4.30-usb-io_edgeport-oops-1                               (Marcelo Tosatti)

  USB: fix oops in io_edgeport.c driver (2.6 backport)

+ 2.4.30-stretch-ack-kills-performance-1                         (David Miller)

  [TCP]: Fix stretch ACK performance killer when doing ucopy.
  
  When we are doing ucopy, we try to defer the ACK generation to
  cleanup_rbuf().  This works most of the time very well, but if the
  ucopy prequeue is large, this ACKing behavior kills performance.

+ 2.4.30-xfs-build-without-debug-1                          (Christoph Hellwig)

  [PATCH] XFS: fix compilation error
  > 2.4.30 will not compile if XFS is turned on, but XFS debugging is not.
  Looks like a trivial one-liner got lost when merging from the SGI CVS tree.
-- end --

