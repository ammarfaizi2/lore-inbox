Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbTDUVK2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 17:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbTDUVK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 17:10:28 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:30671 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261921AbTDUVK1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 17:10:27 -0400
Date: Mon, 21 Apr 2003 14:12:08 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 67-mjb2 vs 68-mjb1 (sdet degredation)
Message-ID: <1425480000.1050959528@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seem to loose about 2-3% on SDET syncing with 2.5.68. Not much change
apart from 67-68 changes. The merge of the ext2 alloc stuff has made
such a dramatic improvment for virgin 67-68, it's hard to see if
there was any degredation in mainline ;-) I had those in my tree before
though, so there should be much less change.

Just wondering if you can recognise / guess the problem from the profiles,
else I'll poke at it some more (will probably just work out what's hitting
.text.lock.filemap).

diffprofile {2.5.67-mjb2,2.5.68-mjb1}/sdetbench/128/profile
      1307     2.1% total
       432     0.0% .text.lock.filemap
       269     0.8% default_idle
       148    19.4% find_get_page
        99   165.0% grab_block
        97    26.6% __down
        85   146.6% __brelse
        78    22.2% do_no_page
        75   625.0% update_atime
        62     5.6% __d_lookup
        61   103.4% task_mem
        42    25.5% __wake_up
        39    52.7% __mark_inode_dirty
        38   211.1% read_inode_bitmap
        32     0.0% group_reserve_blocks
        31    79.5% generic_fillattr
...
       -10    -6.0% kmap_atomic
       -11   -26.8% truncate_inode_pages
       -12   -26.1% ext2_free_blocks
       -12    -5.2% do_page_fault
       -13    -7.8% .text.lock.file_table
       -13   -11.1% proc_check_root
       -14   -19.7% dentry_open
       -17    -4.1% .text.lock.namei
       -17   -17.2% fget
       -18   -10.3% .text.lock.attr
       -21   -12.1% number
       -24    -4.3% .text.lock.dcache
       -27    -2.1% page_remove_rmap
       -34   -54.8% ext2_new_block
       -36    -3.4% atomic_dec_and_lock
       -37    -3.1% copy_page_range
       -57    -7.6% __copy_to_user_ll
      -105   -95.5% task_vsize
      -113   -96.6% find_trylock_page

