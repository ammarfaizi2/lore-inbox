Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265039AbUEYSro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265039AbUEYSro (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 14:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbUEYSro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 14:47:44 -0400
Received: from cantor.suse.de ([195.135.220.2]:56752 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265039AbUEYSre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 14:47:34 -0400
Date: Tue, 25 May 2004 20:47:32 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Olaf Hering <olh@suse.de>
Subject: very low performance on SCSI disks if device node is in tmpfs
Message-ID: <20040525184732.GB26661@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Any ideas why the location of the device node makes such a big
difference? I always wondered why my firewire is so dog slow with 2.6.
Now I know the reason: /dev is in tmpfs.
I dont see that with IDE disks, only with SCSI.

(none):/# /sbin/hdparm -tT /dev/sdb

/dev/sdb:
 Timing buffer-cache reads:   2532 MB in  2.00 seconds = 1264.93 MB/sec
 Timing buffered disk reads:   48 MB in  3.12 seconds =  15.41 MB/sec
(none):/# /sbin/hdparm -tT /tmp/sdb

/tmp/sdb:
 Timing buffer-cache reads:   2328 MB in  2.00 seconds = 1163.01 MB/sec
 Timing buffered disk reads:   82 MB in  3.03 seconds =  27.03 MB/sec

This happens also with 2.6.1-mm kernels. I attach the profile with
devnode in tmpfs and on disk.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=profdisk1

     1 .save_remaining_regs                       0.0063
     1 .DoSyscall                                 0.0093
     8 .handle_irq_event                          0.0278
 36214 .__iommu_free                             79.4167
     1 .pSeries_flush_hash_range                  0.0013
     1 .openpic2_get_irq                          0.0147
     1 .do_page_fault                             0.0007
     3 .__wake_up                                 0.0208
     8 .schedule                                  0.0036
     1 .__tasklet_schedule                        0.0039
     5 .r_start                                   0.0240
     1 .alloc_uid                                 0.0021
     3 .__lock_page_wq                            0.0068
     5 .wait_on_page_bit_wq                       0.0118
     3 .unlock_page                               0.0208
    76 .find_lock_page                            0.1131
     9 .add_to_page_cache_lru                     0.0833
     6 .read_cache_page                           0.0032
   142 .do_generic_mapping_read                   0.0625
     1 .grab_cache_page_nowait                    0.0013
     2 .__generic_file_aio_write_nolock           0.0006
     3 .mempool_resize                            0.0045
     4 .mempool_create                            0.0092
     3 .__free_pages_ok                           0.0066
     1 .__alloc_pages                             0.0009
     4 .write_one_page                            0.0049
     1 .page_cache_readahead                      0.0014
     6 .force_page_cache_readahead                0.0091
     3 .read_cache_pages                          0.0030
     1 .free_block                                0.0022
     1 .do_drain                                  0.0086
     2 .__cache_shrink                            0.0048
     1 .kstrdup_vec                               0.0035
     2 .slabinfo_write                            0.0037
     4 .__pagevec_lru_add_active                  0.0094
     1 .__pagevec_lru_add                         0.0026
     5 .lru_add_drain                             0.0298
     5 .__pagevec_release                         0.0694
     6 .invalidate_complete_page                  0.0117
    10 .truncate_complete_page                    0.0243
     3 .truncate_inode_pages                      0.0025
     1 .unmap_vmas                                0.0010
     1 .page_remove_rmap                          0.0026
     1 .shmem_truncate                            0.0008
     2 .shmem_getpage                             0.0005
     2 .generic_file_llseek                       0.0068
     1 .remove_inode_buffers                      0.0040
     2 .end_bio_bh_io_sync                        0.0119
     1 .nobh_truncate_page                        0.0017
     1 .buffer_io_error                           0.0114
     2 .drop_buffers                              0.0026
     2 .__find_get_block_slow                     0.0033
     1 .invalidate_bh_lru                         0.0068
     1 .__find_get_block                          0.0013
     3 .__bforget                                 0.0142
     1 .__block_commit_write                      0.0026
    10 .mark_buffer_dirty_inode                   0.0490
     4 .block_truncate_page                       0.0042
     6 .__block_prepare_write                     0.0044
     3 .block_invalidatepage                      0.0063
     2 .__bread                                   0.0060
     2 .end_buffer_async_write                    0.0042
     1 .bio_split                                 0.0027
     6 .bio_check_pages_dirty                     0.0101
     1 .bio_dirty_fn                              0.0021
     1 .sync_filesystems                          0.0018
     1 .bd_release                                0.0066
     1 .bd_claim                                  0.0045
     1 .pipe_release                              0.0028
     1 .dput                                      0.0013
     2 .ilookup                                   0.0069
     2 .destroy_inode                             0.0079
     1 .get_filesystem_list                       0.0045
     3 .generic_osync_inode                       0.0066
     1 .reiserfs_read_locked_inode                0.0004
     2 .reiserfs_iget                             0.0082
     1 .reiserfs_fill_super                       0.0003
    26 .search_by_key                             0.0034
     3 .reiserfs_delete_solid_item                0.0016
     4 .flush_commit_list                         0.0017
     1 .reiserfs_add_ordered_list                 0.0034
     4 .do_journal_end                            0.0008
     2 .do_journal_release                        0.0038
     1 .reiserfs_in_journal                       0.0016
     1 .reiserfs_resize                           0.0005
     1 .memmove                                   0.0833
     4 .__strncpy_from_user                       0.0667
     3 .bitreverse                                0.0174
  1482 .crc32_le                                  4.1167
    49 .qsort                                     0.0407
     6 .zlib_inflate_blocks                       0.0020
     1 .n_tty_ioctl                               0.0003
     1 .dev_set_rdonly                            0.0053
     2 .blk_queue_find_tag                        0.0417
     1 .blk_queue_init_tags                       0.0047
     1 .blk_queue_invalidate_tags                 0.0035
     2 .__make_request                            0.0010
     1 .blk_init_queue                            0.0019
     9 .blkdev_ioctl                              0.0036
     1 .bcm5201_suspend                           0.0033
    11 .scsi_host_lookup                          0.0372
     8 .__scsi_mode_sense                         0.0112
     1 .scsi_mode_sense                           0.0050
     1 .scsi_free_host_dev                        0.0038
     1 .scsi_alloc_sdev                           0.0008
     1 .scsi_probe_and_add_lun                    0.0003
     1 .ata_scsi_slave_config                     0.0045
     1 .bit_func                                  0.0417
     2 .i2c_stop                                  0.0030
     1 .dev_ethtool                               0.0003
     1 .tcp_sendmsg                               0.0002
     1 .inetdev_init                              0.0016
 38268 total                                      0.0102

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=proftmp1

     4 .save_remaining_regs                       0.0250
     1 .DoSyscall                                 0.0093
    35 .handle_irq_event                          0.1215
     1 .sched_clock                               0.0312
     1 .__down_interruptible                      0.0027
     5 .power4_idle                               0.0347
 37021 .__iommu_free                             81.1864
     1 .openpic2_get_irq                          0.0147
     1 .flush_dcache_page                         0.0179
     5 .__wake_up                                 0.0347
    27 .schedule                                  0.0122
     1 .io_schedule                               0.0028
     1 .finish_wait                               0.0053
     2 .prepare_to_wait                           0.0106
     1 .remove_wait_queue                         0.0069
     1 .copy_process                              0.0002
     2 .__tasklet_hi_schedule                     0.0078
     3 .__tasklet_schedule                        0.0117
    25 .r_start                                   0.1202
     1 .alloc_uid                                 0.0021
     3 .__lock_page_wq                            0.0068
     2 .wait_on_page_bit_wq                       0.0047
     1 .unlock_page                               0.0069
    75 .find_lock_page                            0.1116
     1 .add_to_page_cache                         0.0014
     6 .add_to_page_cache_lru                     0.0556
     1 .read_cache_page                           0.0005
   147 .do_generic_mapping_read                   0.0647
     1 .wait_on_page_writeback_range_wq           0.0015
     3 .__generic_file_aio_write_nolock           0.0009
     3 .mempool_resize                            0.0045
     3 .mempool_create                            0.0069
     1 .setup_per_zone_pages_min                  0.0022
     1 .__free_pages_ok                           0.0022
     1 .__alloc_pages                             0.0009
     1 .write_one_page                            0.0012
     1 .do_page_cache_readahead                   0.0016
     6 .read_cache_pages                          0.0059
     1 .free_block                                0.0022
     1 .do_drain                                  0.0086
     3 .__cache_shrink                            0.0071
     1 .__kmalloc                                 0.0044
     1 .__pagevec_lru_add_active                  0.0024
     2 .lru_add_drain                             0.0119
     4 .__pagevec_release                         0.0556
     1 .invalidate_complete_page                  0.0020
     1 .truncate_complete_page                    0.0024
     2 .truncate_inode_pages                      0.0017
     1 .wakeup_kswapd                             0.0100
     1 .anon_vma_prepare                          0.0038
     1 .page_remove_rmap                          0.0026
     1 .unmap_pte_page                            0.0009
     2 .try_to_unmap_one                          0.0014
     2 .sys_readv                                 0.0063
     1 .invalidate_inode_buffers                  0.0048
     1 .nobh_commit_write                         0.0069
     1 .generic_cont_expand                       0.0014
     2 .submit_bh                                 0.0032
     1 .__find_get_block_slow                     0.0016
     2 .mark_buffer_dirty                         0.0116
     2 .block_invalidatepage                      0.0042
     1 .end_buffer_async_write                    0.0021
     1 .match_token                               0.0014
     2 .__strncpy_from_user                       0.0333
     4 .bitreverse                                0.0233
  1542 .crc32_le                                  4.2833
    42 .qsort                                     0.0349
     4 .zlib_inflate_blocks                       0.0013
     2 .tty_read                                  0.0044
     1 .start_tty                                 0.0032
     1 .blk_rq_map_sg                             0.0021
     1 .blk_queue_init_tags                       0.0047
     1 .blk_queue_invalidate_tags                 0.0035
     4 .__make_request                            0.0020
    11 .blkdev_ioctl                              0.0043
     1 .rd_open                                   0.0042
     1 .gem_interrupt                             0.0001
     1 .scsi_unregister                           0.0208
    50 .scsi_host_lookup                          0.1689
     1 .scsi_add_host                             0.0023
    18 .__scsi_mode_sense                         0.0253
     3 .scsi_mode_sense                           0.0150
    13 .scsi_free_host_dev                        0.0492
     2 .scsi_alloc_sdev                           0.0017
     1 .scsi_forget_host                          0.0046
     1 .scsi_probe_and_add_lun                    0.0003
     1 .keywest_timeout                           0.0040
     2 .i2c_stop                                  0.0030
     1 .netdev_run_todo                           0.0009
     1 .qdisc_kill_estimator                      0.0030
 39145 total                                      0.0105

--Qxx1br4bt0+wmkIi--
