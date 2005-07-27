Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVG0Wm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVG0Wm2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 18:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVG0WkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 18:40:02 -0400
Received: from exo1066.net2.nerim.net ([213.41.175.60]:28838 "EHLO
	mail-out1.exosec.net") by vger.kernel.org with ESMTP
	id S261173AbVG0WiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 18:38:07 -0400
Date: Thu, 28 Jul 2005 00:38:00 +0200
From: Willy Tarreau <wtarreau@exosec.fr>
To: linux-kernel@vger.kernel.org
Cc: willy@w.ods.org, Grant Coady <x0x0x@dodo.com.au>
Subject: Linux-2.4.31-hf3 (SECURITY)
Message-ID: <20050727223800.GA23660@exosec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

due to a recent vulnerability discovered in zlib (CAN-2005-1849), here's a
new set of hotfixes for stable kernels 2.4 :

  - 2.4.31-hf3
  - 2.4.30-hf6
  - 2.4.29-hf13

The zlib vulnerability has been shown to be able to segfault gunzip with a
specially crafted input stream ; it is expected that the kernel may crash if
zlib users such as PPP or zisofs were targetted.

Aside that, the correct version of Davem's netlink hashing fix has been
merged, as well as 2 other minor patches.
 
Changelog appended, and updates available at the usual URL below. Naturally,
upgrade is recommended.

    http://linux.exosec.net/kernel/2.4-hf/

Only build of 2.4.31-hf3 with full modules has been tested. Grant will
probably update his more complete build/test reports there soon :

    http://scatter.mine.nu/linux-2.4-hotfix/

Regards
Willy

--

Changelog From 2.4.31-hf2 to 2.4.31-hf3 (semi-automated)
---------------------------------------
'+' = added ; '-' = removed

+ 2.4.31-zlib-security-bugs-1                                    (Tim Yamin)

  Fix outstanding security bugs in the Linux zlib implementations. See:
  a) http://sources.redhat.com/ml/bug-gnu-utils/1999-06/msg00183.html
  b) http://bugs.gentoo.org/show_bug.cgi?id=94584

+ 2.4.31-ip_vs_conn_tab-race-1                                 (Neil Horman)

  [IPVS]: Close race conditions on ip_vs_conn_tab list modification.
  In an smp system, it is possible for an connection timer to expire,
  calling ip_vs_conn_expire while the connection table is being flushed,
  before ct_write_lock_bh is acquired. (...) The result is that the next
  pointer gets set to NULL, and subsequently dereferenced, resulting in
  an oops.

+ 2.4.31-inode-cache-smp-races-1                             (Larry Woodman)

  [PATCH] workaround inode cache (prune_icache/__refile_inode) SMP races
  
  Over the past couple of weeks we have seen two races in the inode cache
  code. The first is between [dispose_list()] and __refile_inode() and the
  second is between prune_icache() and truncate_inodes(). Fixes bug 155289.

+ 2.4.31-netlink-socket-hashing-bugs-2                     (David S. Miller)

  [NETLINK]: Fix two socket hashing bugs.
  netlink_release() should only decrement the hash entry count if the
  socket was actually hashed. netlink_autobind() needs to propagate
  the error return from netlink_insert(). Otherwise, callers will not
  see the error as they should and thus try to operate on a socket
  with a zero pid, which is very bad. Thanks to Jakub Jelinek for
  providing backtraces, and Herbert Xu for debugging patches to help
  track this down.

+ 2.4.31-sparc64-sys32_utimes-random-timestamps-1             (Jakub Bogusz)

  [SPARC64]: fix sys32_utimes(somefile, NULL)
  
  This patch fixes utimes(somefile, NULL) syscalls on sparc64 kernel with
  32-bit userland - use of uninitialized value resulted in making random
  timestamps, which confused e.g. sudo. It has been already fixed (by davem)
  in linux-2.6 tree 30 months ago.
  
-- END --
