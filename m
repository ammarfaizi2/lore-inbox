Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267065AbTBHTUA>; Sat, 8 Feb 2003 14:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267068AbTBHTUA>; Sat, 8 Feb 2003 14:20:00 -0500
Received: from franka.aracnet.com ([216.99.193.44]:12247 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267065AbTBHTT7>; Sat, 8 Feb 2003 14:19:59 -0500
Date: Sat, 08 Feb 2003 11:29:33 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>
cc: dmccr@us.ibm.com
Subject: Performance of highpte
Message-ID: <16010000.1044732573@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernbench-2: (make -j N vmlinux, where N = 2 x num_cpus)
                        Elapsed        User      System         CPU
         2.5.59-mjb5       45.64      564.71      110.73     1479.50
 2.5.59-mjb5-highpte       46.38      565.32      118.35     1473.50

Hmmm. Looks like we need to dust off UKVA to me.

diffprofile:

3790 page_remove_rmap
3213 default_idle
1299 kmap_atomic
803 kmap_atomic_to_page
776 kmem_cache_free
676 __pte_chain_free
486 page_add_rmap
240 unmap_all_pages
225 kmem_cache_alloc
166 vm_enough_memory
132 do_generic_mapping_read
100 handle_mm_fault
82 buffered_rmqueue
79 __copy_from_user_ll
67 update_atime
66 kunmap_atomic
63 release_pages
58 filemap_nopage
55 file_move
51 generic_file_open
51 find_get_page
...
-52 dput
-61 do_schedule
-63 get_empty_filp
-74 do_page_fault
-96 vfs_read
-97 path_lookup
-121 fd_install
-159 pte_alloc_one
-260 .text.lock.file_table
-372 page_address

