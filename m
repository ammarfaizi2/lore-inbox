Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVFGXu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVFGXu7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 19:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVFGXu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 19:50:59 -0400
Received: from dvhart.com ([64.146.134.43]:21160 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262041AbVFGXur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 19:50:47 -0400
Date: Tue, 07 Jun 2005 16:50:39 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.12-rc6-mm1
Message-ID: <1004450000.1118188239@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wheeee! it actually compiles and boots for me on x86 ;-)

http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/perf/kernbench.moe.png

Seems to show that perf is rather sucky on kernbench though.

baseline (-rc6) data is here:

http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/4760/kernbench.test/

-mm1 is here:

http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/4876/kernbench.test/

Diffprofile is wacko (HZ seems to be defaulting to 250 in -mm).
If I factor it by 4x, I get:



     47796    10.9% total
     16644    30.5% buffered_rmqueue
     15574     7.7% default_idle
      2229   239.4% kmem_cache_free
      1782    11.1% zap_pte_range
      1752     0.0% inotify_inode_queue_event
      1467    36.3% release_pages
      1281    73.3% set_page_dirty
      1155    12.8% do_wp_page
       924     8.3% _spin_lock
       896     0.0% find_idlest_group
       828    21.7% free_hot_cold_page
       780     0.0% drain_remote_pages
       772     0.0% dput_recursive
       464     0.0% inotify_dentry_parent_queue_event
...
      -412    -8.1% __d_lookup
      -508   -98.4% find_idlest_cpu
      -542   -24.5% do_anonymous_page
      -549   -47.5% current_fs_time
      -580  -100.0% del_timer_sync
      -594   -86.6% dput
      -695   -31.4% __copy_user_intel
     -1461   -13.9% strnlen_user


Buggered if I know what that is from. I'm guessing scheduler, or the
HZ change. I guess I can rerun with the HZ set to 1000 ... you got any
experimental scheduler stuff in your tree?

Else I guess it's some memory allocator stuff maybe? 
