Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264566AbTKNSuG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 13:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264568AbTKNSuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 13:50:05 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:31436 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264566AbTKNSt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 13:49:58 -0500
Date: Fri, 14 Nov 2003 11:08:34 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test9-mm3
Message-ID: <98290000.1068836914@flay>
In-Reply-To: <20031112233002.436f5d0c.akpm@osdl.org>
References: <20031112233002.436f5d0c.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> - Several ext2 and ext3 allocator fixes.  These need serious testing on big
>   SMP.

OK, ext3 survived a swatting on the 16-way as well. It's still slow as snot,
but it does work ;-) No changes from before, methinks.

Diffprofile for kernbench (-j) from ext2 to ext3 on mm3

     27022    16.3% total
     24069    53.3% default_idle
       583     2.4% page_remove_rmap
       539   248.4% fd_install
       478   388.6% __blk_queue_bounce
       319     4.0% __d_lookup
       220   122.9% may_open
       204    68.2% filemap_nopage
       124     0.0% journal_add_journal_head
       122   321.1% __find_get_block_slow
       122     0.0% do_get_write_access
       101    57.1% generic_fillattr
...
       -52   -73.2% .text.lock.highmem
       -52   -94.5% generic_file_read
       -53   -18.7% do_generic_mapping_read
       -58    -3.3% do_no_page
       -65   -13.0% page_address
       -65   -60.2% kmap_high
       -74  -100.0% grab_block
       -75    -3.3% do_page_fault
       -85    -1.9% __copy_from_user_ll
      -273   -19.5% link_path_walk
      -299    -6.5% find_get_page
      -758  -100.0% generic_file_open

SDET:

   1726439   214.7% total
   1383611   345.4% default_idle
    115417     0.0% .text.lock.transaction
     79362     0.0% find_next_usable_block
     38003     0.0% do_get_write_access
     32429  2316.4% __down
     31231     0.0% journal_dirty_metadata
     15114   553.8% schedule
     14350  1253.3% __wake_up
     13459     0.0% start_this_handle
     13100     0.0% journal_stop
...
     -1105   -25.1% copy_mm
     -1144  -100.0% generic_file_open
     -1205   -45.0% .text.lock.dec_and_lock
     -1342  -100.0% ext2_new_inode
     -1365   -50.5% follow_mount
     -1453  -100.0% grab_block
     -1580   -30.5% remove_shared_vm_struct
     -1759   -11.0% copy_page_range
     -2145   -18.4% __d_lookup
     -2157   -35.6% path_lookup
     -2222   -33.7% atomic_dec_and_lock
     -2813   -25.0% release_pages
     -3764   -19.1% zap_pte_range
     -8954   -21.2% page_add_rmap
    -22707   -25.0% page_remove_rmap

