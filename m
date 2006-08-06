Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWHFNzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWHFNzF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 09:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWHFNzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 09:55:05 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:16871 "EHLO
	smtprelay05.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751108AbWHFNzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 09:55:03 -0400
From: Matthias Dahl <mlkernel@mortal-soul.de>
To: linux-kernel@vger.kernel.org
Subject: Re: sluggish system responsiveness under higher IO load
Date: Sun, 6 Aug 2006 15:54:42 +0200
User-Agent: KMail/1.9.4
References: <200608061200.37701.mlkernel@mortal-soul.de> <20060806031512.57585f5d.akpm@osdl.org>
In-Reply-To: <20060806031512.57585f5d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608061554.42992.mlkernel@mortal-soul.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd suggest that you generate a kernel profile while the sluggishness is
> happening.

Done...

profile 1: (emerge of three huge packages which caused quite some IO)

ffffffff80232650 __wake_up                                    23   0.2396
ffffffff803427a0 vgacon_cursor                                23   0.0395
ffffffff8020ba40 free_hot_cold_page                           24   0.0652
ffffffff8020be90 find_vma                                     25   0.2232
ffffffff8020c9b0 __wake_up_bit                                25   0.5208
ffffffff80301800 journal_add_journal_head                     25   0.0601
ffffffff803424e0 vgacon_scroll                                26   0.0478
ffffffff802eb970 __ext3_get_inode_loc                         27   0.0312
ffffffff802fd8e0 journal_dirty_metadata                       27   0.0456
ffffffff80207500 kmem_cache_free                              28   0.2917
ffffffff80211d90 do_select                                    30   0.0216
ffffffff8020d420 bit_waitqueue                                32   0.1429
ffffffff8020bbb0 fget_light                                   34   0.1635
ffffffff8026b97f thread_return                                35   0.1211
ffffffff80268d50 system_call                                  36   0.2748
ffffffff8020a580 kmem_cache_alloc                             39   0.6094
ffffffff8020cae0 vm_normal_page                               42   0.2188
ffffffff8020bf00 __make_request                               43   0.0384
ffffffff8020b600 __find_get_block                             47   0.0979
ffffffff802eb5c0 ext3_mark_iloc_dirty                         48   0.0508
ffffffff8020a0f0 get_page_from_freelist                       50   0.0428
ffffffff802fba50 do_get_write_access                          55   0.0382
ffffffff80209050 __link_path_walk                             56   0.0132
ffffffff803a63a0 scsi_request_fn                              57   0.0604
ffffffff8026b0c0 memcpy                                       59   0.3352
ffffffff8020ccf0 __delay                                      69   2.1562
ffffffff80208350 __handle_mm_fault                            78   0.0269
ffffffff802075e0 unmap_vmas                                   93   0.0501
ffffffff80208ea0 __d_lookup                                   95   0.2199
ffffffff8026ad30 clear_page                                  100   1.7544
ffffffff80341880 vgacon_set_cursor_size                      103   0.4023
ffffffff8020a920 do_page_fault                               105   0.0443
ffffffff80207560 find_get_page                               106   0.9464
ffffffff80207d20 copy_page_range                             111   0.0701
ffffffff8026ad70 copy_page                                   157   0.7009
ffffffff80212cd0 __do_softirq                                189   1.0739
ffffffff803a0430 scsi_dispatch_cmd                           459   0.7172
ffffffff8026afda copy_user_generic_c                         854  22.4737
ffffffff80270e00 default_idle                              49571 516.3646
0000000000000000 total                                     54590   0.0232

profile 2: (emerge of recent kernel sources- huge, causes quite some IO too)

ffffffff8020ff40 generic_permission                           57   0.2227
ffffffff8020ccf0 __delay                                      58   1.8125
ffffffff802149a0 rb_insert_color                              58   0.2417
ffffffff802af8b0 free_page_and_swap_cache                     63   1.3125
ffffffff8020ccb0 put_page                                     66   1.0312
ffffffff803a63a0 scsi_request_fn                              67   0.0710
ffffffff80234c60 unix_poll                                    69   0.3920
ffffffff8020b600 __find_get_block                             74   0.1542
ffffffff80268d50 system_call                                  81   0.6183
ffffffff8020e220 memscan                                      88   1.8333
ffffffff80224820 __up_read                                    92   0.5227
ffffffff802fba50 do_get_write_access                          95   0.0660
ffffffff80207500 kmem_cache_free                              99   1.0312
ffffffff80223d40 find_next_zero_bit                          100   0.6944
ffffffff8020d6a0 strncpy_from_user                           103   1.2875
ffffffff80211d90 do_select                                   104   0.0747
ffffffff8020c9b0 __wake_up_bit                               117   2.4375
ffffffff8026b97f thread_return                               120   0.4152
ffffffff8020a580 kmem_cache_alloc                            143   2.2344
ffffffff8026b0c0 memcpy                                      154   0.8750
ffffffff8020a0f0 get_page_from_freelist                      155   0.1327
ffffffff8020b260 page_remove_rmap                            172   2.6875
ffffffff80221320 copy_process                                175   0.0315
ffffffff80207560 find_get_page                               190   1.6964
ffffffff8020be90 find_vma                                    198   1.7679
ffffffff80211900 do_wp_page                                  249   0.2132
ffffffff80209050 __link_path_walk                            315   0.0740
ffffffff8026afda copy_user_generic_c                         325   8.5526
ffffffff80212cd0 __do_softirq                                452   2.5682
ffffffff80208350 __handle_mm_fault                           479   0.1654
ffffffff80208ea0 __d_lookup                                  510   1.1806
ffffffff8026ad30 clear_page                                  519   9.1053
ffffffff803a0430 scsi_dispatch_cmd                           576   0.9000
ffffffff8020a920 do_page_fault                               712   0.3007
ffffffff8020cae0 vm_normal_page                              814   4.2396
ffffffff8026ad70 copy_page                                  1929   8.6116
ffffffff802075e0 unmap_vmas                                 2362   1.2726
ffffffff80207d20 copy_page_range                            2683   1.6938
ffffffff80270e00 default_idle                              45081 469.5938
0000000000000000 total                                     64216   0.0273

I hope this helps.
