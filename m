Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVGEN6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVGEN6S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 09:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVGEN6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 09:58:17 -0400
Received: from mailhub3.nextra.sk ([195.168.1.146]:13830 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S261857AbVGENv2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 09:51:28 -0400
Message-ID: <42CAAC7D.2050604@rainbow-software.org>
Date: Tue, 05 Jul 2005 17:51:25 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_tic-88309-1120571484-0001-2"
To: Jens Axboe <axboe@suse.de>
CC: "=?ISO-8859-1?Q?Andr=E9_Tomt?=" <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git patches] IDE update
References: <200507042033.XAA19724@raad.intranet>	 <42C9C56D.7040701@tomt.net> <42CA5A84.1060005@rainbow-software.org>	 <20050705101414.GB18504@suse.de> <42CA5EAD.7070005@rainbow-software.org>	 <20050705104208.GA20620@suse.de>  <42CA7EA9.1010409@rainbow-software.org>	 <1120567900.12942.8.camel@linux>  <42CA84DB.2050506@rainbow-software.org> <1120569095.12942.11.camel@linux>
In-Reply-To: <1120569095.12942.11.camel@linux>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_tic-88309-1120571484-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe wrote:
> On Tue, 2005-07-05 at 15:02 +0200, Ondrej Zary wrote:
> 
>>>Ok, looks alright for both. Your machine is quite slow, perhaps that is
>>>showing the slower performance. Can you try and make HZ 100 in 2.6 and
>>>test again? 2.6.13-recent has it as a config option, otherwise edit
>>>include/asm/param.h appropriately.
>>>
>>
>>I forgot to write that my 2.6.12 kernel is already compiled with HZ 100 
>>(it makes the system more responsive).
>>I've just tried 2.6.8.1 with HZ 1000 and there is no difference in HDD 
>>performance comparing to 2.6.12.
> 
> 
> OK, interesting. You could try and boot with profile=2 and do
> 
> # readprofile -r
> # dd if=/dev/hda of=/dev/null bs=128k 
> # readprofile > prof_output
> 
> for each kernel and post it here, so we can see if anything sticks out.
> 
Here are the profiles (used dd with count=4096) from 2.4.26 and 2.6.12 
(nothing from 2.6.8.1 because I don't have the .map file anymore).

-- 
Ondrej Zary

--=_tic-88309-1120571484-0001-2
Content-Type: text/plain; name="profile2426.txt"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="profile2426.txt"

   448 default_idle                               5.6000
     4 __switch_to                                0.0192
     1 ret_from_sys_call                          0.0588
     3 handle_IRQ_event                           0.0268
     6 schedule                                   0.0072
     8 __wake_up                                  0.0833
     2 __constant_memcpy                          0.0078
     4 add_page_to_hash_queue                     0.0625
     2 __remove_inode_page                        0.0156
     6 add_to_page_cache_unique                   0.0375
     7 page_cache_read                            0.0398
     2 unlock_page                                0.0179
     7 generic_file_readahead                     0.0168
    11 do_generic_file_read                       0.0101
  1366 file_read_actor                            8.5375
     2 generic_file_read                          0.0048
     1 kmem_slab_destroy                          0.0042
     3 kmem_cache_grow                            0.0057
     2 kmem_cache_alloc                           0.0625
    28 kmem_cache_free                            0.8750
     2 kmem_cache_reap                            0.0042
    12 __kmem_cache_alloc                         0.0536
     4 lru_cache_add                              0.0357
     1 __lru_cache_del                            0.0078
     3 delta_nr_inactive_pages                    0.0312
     5 delta_nr_cache_pages                       0.0521
    17 shrink_cache                               0.0180
     1 refill_inactive                            0.0031
    16 __free_pages_ok                            0.0200
    20 rmqueue                                    0.0284
     6 __alloc_pages                              0.0091
     1 __free_pages                               0.0208
     3 sys_read                                   0.0117
     1 sys_write                                  0.0039
     5 __remove_from_lru_list                     0.0391
     3 __remove_from_queues                       0.0625
     7 __put_unused_buffer_head                   0.0729
     3 get_unused_buffer_head                     0.0234
    24 set_bh_page                                0.2143
    32 create_buffers                             0.1429
     4 try_to_release_page                        0.0500
     4 create_empty_buffers                       0.0417
    24 block_read_full_page                       0.0375
    27 try_to_free_buffers                        0.1055
    10 max_block                                  0.0694
     9 blkdev_get_block                           0.1406
     2 blkdev_direct_IO                           0.0417
     1 blkdev_readpage                            0.0312
     2 init_buffer_head                           0.0312
    25 __constant_c_and_count_memset              0.1736
     2 write_profile                              0.0417
   114 __make_request                             0.0642
    27 generic_make_request                       0.0844
    25 submit_bh                                  0.0977
     5 ide_inb                                    0.3125
     7 ide_outb                                   0.4375
     2 ide_outl                                   0.1250
     1 ide_execute_command                        0.0078
     2 SELECT_DRIVE                               0.0312
     4 ide_start_request                          0.0083
     2 ide_do_request                             0.0050
     2 ide_get_queue                              0.0312
     4 ide_intr                                   0.0139
     6 ide_dma_intr                               0.0312
    30 ide_build_sglist                           0.0481
     5 ide_build_dmatable                         0.0120
     1 __ide_dma_read                             0.0042
     1 __ide_dma_count                            0.0312
     3 __constant_c_and_count_memset              0.0208
    67 idedisk_end_request                        0.3490
     2 __generic_copy_to_user                     0.0312
     0 *unknown*
  2499 total                                      0.0013

--=_tic-88309-1120571484-0001-2
Content-Type: text/plain; name="profile2612.txt"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="profile2612.txt"

     1 cpu_idle                                   0.0104
     1 system_call                                0.0200
     1 __wake_up                                  0.0125
     1 copy_mm                                    0.0011
     1 profile_hit                                0.0156
     2 write_profile                              0.0312
     1 current_fs_time                            0.0104
     1 timespec_trunc                             0.0156
     1 __wake_up_bit                              0.0208
     5 handle_IRQ_event                           0.0521
    12 add_to_page_cache                          0.0833
     1 page_waitqueue                             0.0156
     2 __lock_page                                0.0125
    16 find_get_page                              0.2500
     7 do_generic_mapping_read                    0.0049
     8 file_read_actor                            0.0312
     2 __generic_file_aio_read                    0.0038
     1 generic_file_read                          0.0052
     9 mempool_alloc                              0.0331
     2 mempool_alloc_slab                         0.1250
     3 bad_range                                  0.0375
    21 free_hot_cold_page                         0.0772
    22 buffered_rmqueue                           0.0458
     5 zone_watermark_ok                          0.0284
     5 __alloc_pages                              0.0053
     1 __read_page_state                          0.0625
     6 __mod_page_state                           0.3750
     1 get_dirty_limits                           0.0048
     4 test_clear_page_dirty                      0.0179
     2 read_pages                                 0.0074
    11 __do_page_cache_readahead                  0.0312
     2 blockable_page_cache_readahead             0.0125
     1 page_cache_readahead                       0.0030
    20 kmem_cache_alloc                           0.4167
     8 kmem_cache_free                            0.1667
     1 release_pages                              0.0025
     1 __pagevec_lru_add                          0.0039
     2 shrink_slab                                0.0054
     1 pageout                                    0.0037
    43 shrink_list                                0.0401
     6 shrink_cache                               0.0080
     1 refill_inactive_zone                       0.0009
     2 balance_pgdat                              0.0024
     2 blk_queue_bounce                           0.0312
     1 unmap_vmas                                 0.0018
     3 page_referenced                            0.0234
     1 rw_verify_area                             0.0078
     1 vfs_read                                   0.0045
     1 vfs_write                                  0.0045
     1 __clear_page_buffers                       0.0156
     5 alloc_page_buffers                         0.0347
     2 try_to_release_page                        0.0312
    12 create_empty_buffers                       0.0833
    14 block_read_full_page                       0.0219
     4 submit_bh                                  0.0147
     7 drop_buffers                               0.0486
     7 try_to_free_buffers                        0.0486
     1 block_sync_page                            0.0156
     2 recalc_bh_state                            0.0312
     2 alloc_buffer_head                          0.0250
     1 free_buffer_head                           0.0125
     8 bio_alloc_bioset                           0.0179
     2 bio_put                                    0.0417
     3 max_block                                  0.0268
     2 blkdev_get_block                           0.0312
     2 blkdev_readpage                            0.1250
     2 update_atime                               0.0114
     1 __mark_inode_dirty                         0.0024
     2 mb_cache_shrink_fn                         0.0043
     1 radix_tree_preload                         0.0063
   998 __copy_to_user_ll                         15.5938
  1216 acpi_processor_idle                        2.0033
     9 blk_rq_map_sg                              0.0256
     3 get_request                                0.0043
    72 __make_request                             0.0616
     8 generic_make_request                       0.0179
     3 submit_bio                                 0.0170
    61 ide_end_request                            0.4236
     1 start_request                              0.0020
     5 ide_do_request                             0.0060
     2 ide_intr                                   0.0052
     2 ide_inb                                    0.1250
     5 ide_outb                                   0.3125
     1 ide_execute_command                        0.0063
     3 ide_build_sglist                           0.0208
     2 ide_build_dmatable                         0.0066
     1 ide_do_rw_disk                             0.0089
     8 schedule                                   0.0053
     0 *unknown*
  2734 total                                      0.0013

--=_tic-88309-1120571484-0001-2--
