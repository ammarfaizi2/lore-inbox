Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264882AbUE2Nab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264882AbUE2Nab (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 09:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbUE2Nab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 09:30:31 -0400
Received: from outmx016.isp.belgacom.be ([195.238.2.115]:34023 "EHLO
	outmx016.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S264853AbUE2N3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 09:29:44 -0400
Subject: Re: 2.6.7rc1 vs 2.6.0
From: FabF <fabian.frederick@skynet.be>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <367240000.1085495259@[10.10.2.4]>
References: <1085464727.3762.4.camel@localhost.localdomain>
	 <367240000.1085495259@[10.10.2.4]>
Content-Type: text/plain
Message-Id: <1085837450.2628.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 29 May 2004 15:30:50 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

	When profiling latest mm against some fgrep I've got the following:

Extracting ext3 relevant fx:

Occ / Function
71 ext3_get_block_handle
68 ext3_dx_find_entry
57 ext3_get_branch
48 ext3_getblk
40 ext3_do_update_inode
35 ext3_find_entry
35 ext3_read_inode
31 ext3_block_to_path
30 ext3_get_inode_block
20 ext3_get_block
19 ext3_htree_store_dirent
15 ext3_lookup
12 ext3_release_file
12 ext3fs_dirhash
11 ext3_get_inode_loc
10 ext3_check_dir_entry

All those ext3_fxs consume almost 0.1% CPU and are not called as much as I thought

(e.g.
9573      3.2735  vmlinux                  __copy_to_user_ll
6914      2.3642  vmlinux                  mark_offset_tsc
4399      1.5042  vmlinux                  mask_and_ack_8259A
2703      0.9243  vmlinux                  fast_clear_page
1750      0.5984  vmlinux                  enable_8259A_irq
933       0.3190  vmlinux                  default_idle
826       0.2824  vmlinux                  irq_entries_start
822       0.2811  vmlinux                  ide_outb
614       0.2100  vmlinux                  apic_timer_interrupt
513       0.1754  vmlinux                  ide_inb
355       0.1214  vmlinux                  page_fault
331       0.1132  vmlinux                  find_vma
243       0.0831  vmlinux                  get_exec_dcookie
189       0.0646  vmlinux                  __d_lookup
170       0.0581  vmlinux                  unix_poll
160       0.0547  vmlinux                  do_generic_mapping_read
159       0.0544  vmlinux                  radix_tree_delete
155       0.0530  vmlinux                  __rmqueue
155       0.0530  vmlinux                  schedule
153       0.0523  vmlinux                  buffered_rmqueue
143       0.0489  vmlinux                  handle_mm_fault
133       0.0455  vmlinux                  disable_8259A_irq
130       0.0445  vmlinux                  delay_tsc
127       0.0434  vmlinux                  __page_cache_release
125       0.0427  vmlinux                  __find_get_block
124       0.0424  vmlinux                  __alloc_pages
124       0.0424  vmlinux                  kmem_cache_alloc
112       0.0383  vmlinux                  page_add_anon_rmap
102       0.0349  vmlinux                  link_path_walk
...)

So I guess we can consider the 2.6 / 2.6.7 I/O regression not fs relevant (ie ext3) in this case ....

PS: I'll try to bring same profile for 2.6.0.

Regards,
FabF

On Tue, 2004-05-25 at 16:27, Martin J. Bligh wrote:
> > 	Here's trivial fgrep vs report (using ffb1) :
> > 
> > 2.6.7rc1 : 
> > Grepping  /usr/bin  :
> > 45% cpu - 38.06 RT Sec - 1.10 Sec in KM
> > Entries scanned : 1527
> > 85112 Kb analyzed this time
> > 
> > 2.6.0 : 
> > Grepping  /usr/bin  :
> > 51% cpu - 33.12 RT Sec - 1.10 Sec in KM
> > Entries scanned :1527
> > 85112 Kb analyzed this time
> > 
> > 	This is done against ext3 fs. Same .config, same box, same box state.
> > What relevance could explain this 5s delta ? IOW, what big ext3, mm new functionnalities have been plugged in-between ?
> 
> Take kernel profiles of both (see Documentation/basic_profiling.txt)
> 
> M.
> 
> 

