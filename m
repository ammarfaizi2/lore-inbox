Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbTJ0Xok (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 18:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbTJ0Xok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 18:44:40 -0500
Received: from [62.217.245.194] ([62.217.245.194]:13111 "EHLO saytrin")
	by vger.kernel.org with ESMTP id S263771AbTJ0Xog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 18:44:36 -0500
Date: Tue, 28 Oct 2003 01:45:14 +0200
From: Iustin Pop <iusty@k1024.org>
To: linux-kernel@vger.kernel.org
Subject: inode->i_rdev not initialized in 2.4 fs/inode.c, only in 2.6?
Message-ID: <20031027234514.GA11213@saytrin.hq.k1024.org>
Mail-Followup-To: Iustin Pop <iusty@k1024.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Linux: This message was written on Linux
X-Header: /usr/include gives great headers
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm running 2.4.22 (with XFS and skas patch), but these patches do not
affect the code in question. /proc/version = Linux version 2.4.22-xfs
(root@saytrin) (gcc version 3.3.2 20030908 (Debian prerelease))

I get strange results (st.st_rdev != 0) in userspace after stat on some
non-devices regular file/directory. On one computer, /etc gives 773 and
/etc/init.d 0, while on another /etc gives 0 and /etc/init.d 13478.

After gdb and seeing it comes from kernel, I looked around and saw that
in fs/inode.c, i_rdev is not zeroed. Nor does it *seem* that
kmem_cache_alloc clears the memory, but I could be mistaken, it's
complicated code (I think it only clears at cache creation). And r_dev
is what gets transformed into st_rdev in fs/stat.c

2.6 fixes this behavior, by saying "inode->i_rdev = to_kdev_t(0);".
Shouldn't this be also in 2.4?

Thanks,
Iustin Pop

Please CC me as I'm not on the list.
