Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbVHaN4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVHaN4E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 09:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbVHaN4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 09:56:03 -0400
Received: from dwdmx4.dwd.de ([141.38.3.230]:54422 "EHLO dwdmx4.dwd.de")
	by vger.kernel.org with ESMTP id S964792AbVHaN4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 09:56:01 -0400
Date: Wed, 31 Aug 2005 13:55:59 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To: Jens Axboe <axboe@suse.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
In-Reply-To: <20050831120714.GT4018@suse.de>
Message-ID: <Pine.LNX.4.61.0508311339140.16574@diagnostix.dwd.de>
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de>
 <20050829202529.GA32214@midnight.suse.cz> <Pine.LNX.4.61.0508301919250.25574@diagnostix.dwd.de>
 <20050831071126.GA7502@midnight.ucw.cz> <20050831072644.GF4018@suse.de>
 <Pine.LNX.4.61.0508311029170.16574@diagnostix.dwd.de> <20050831120714.GT4018@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2005, Jens Axboe wrote:

> Nothing sticks out here either. There's plenty of idle time. It smells
> like a driver issue. Can you try the same dd test, but read from the
> drives instead? Use a bigger blocksize here, 128 or 256k.
>
I used the following command reading from all 8 disks in parallel:

    dd if=/dev/sd?1 of=/dev/null bs=256k count=78125

Here vmstat output (I just cut something out in the middle):

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----^M
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa^M
  3  7   4348  42640 7799984   9612    0    0 322816     0 3532  4987  0 22  0 78
  1  7   4348  42136 7800624   9584    0    0 322176     0 3526  4987  0 23  4 74
  0  8   4348  39912 7802648   9668    0    0 322176     0 3525  4955  0 22 12 66
  1  7   4348  38912 7803700   9636    0    0 322432     0 3526  5078  0 23  7 70
  2  6   4348  37552 7805120   9644    0    0 322432     0 3527  4908  0 23 12 64
  0  8   4348  41152 7801552   9608    0    0 322176     0 3524  5018  0 24  6 70
  1  7   4348  41644 7801044   9572    0    0 322560     0 3530  5175  0 23  0 76
  1  7   4348  37184 7805396   9640    0    0 322176     0 3525  4914  0 24 18 59
  3  7   4348  41704 7800376   9832    0    0 322176    20 3531  5080  0 23  4 73
  1  7   4348  40652 7801700   9732    0    0 323072     0 3533  5115  0 24 13 64
  1  7   4348  40284 7802224   9616    0    0 322560     0 3527  4967  0 23  1 76
  0  8   4348  40156 7802356   9688    0    0 322560     0 3528  5080  0 23  2 75
  6  8   4348  41896 7799984   9816    0    0 322176     0 3530  4945  0 24 20 57
  0  8   4348  39540 7803124   9600    0    0 322560     0 3529  4811  0 24 21 55
  1  7   4348  41520 7801084   9600    0    0 322560     0 3532  4843  0 23 22 55
  0  8   4348  40408 7802116   9588    0    0 322560     0 3527  5010  0 23  4 72
  0  8   4348  38172 7804300   9580    0    0 322176     0 3526  4992  0 24  7 69
  4  7   4348  42264 7799784   9812    0    0 322688     0 3529  5003  0 24  8 68
  1  7   4348  39908 7802520   9660    0    0 322700     0 3529  4963  0 24 14 62
  0  8   4348  37428 7805076   9620    0    0 322420     0 3528  4967  0 23 15 62
  0  8   4348  37056 7805348   9688    0    0 322048     0 3525  4982  0 24 26 50
  1  7   4348  37804 7804456   9696    0    0 322560     0 3528  5072  0 24 16 60
  0  8   4348  38416 7804084   9660    0    0 323200     0 3533  5081  0 24 23 53
  0  8   4348  40160 7802300   9676    0    0 323200    28 3543  5095  0 24 17 59
  1  7   4348  37928 7804612   9608    0    0 323072     0 3532  5175  0 24  7 68
  2  6   4348  38680 7803724   9612    0    0 322944     0 3531  4906  0 25 24 51
  1  7   4348  40408 7802192   9648    0    0 322048     0 3524  4947  0 24 19 57

Full vmstat session can be found under:

   ftp://ftp.dwd.de/pub/afd/linux_kernel_debug/vmstat-256k-read

And here the profile data:

2106577 total                                      0.9469
1638177 default_idle                             34128.6875
179615 copy_user_generic_c                      4726.7105
  27670 end_buffer_async_read                    108.0859
  26055 shrink_zone                                7.1111
  23199 __make_request                            17.2612
  17221 kmem_cache_free                          153.7589
  11796 drop_buffers                              52.6607
  11016 add_to_page_cache                         52.9615
   9470 __wake_up_bit                            197.2917
   8760 buffered_rmqueue                          12.4432
   8646 find_get_page                             90.0625
   8319 __do_page_cache_readahead                 11.0625
   7976 kmem_cache_alloc                         124.6250
   7463 scsi_request_fn                            6.2192
   7208 try_to_free_buffers                       40.9545
   6716 create_empty_buffers                      41.9750
   6432 __end_that_request_first                  11.8235
   6044 test_clear_page_dirty                     25.1833
   5643 scsi_dispatch_cmd                          9.7969
   5588 free_hot_cold_page                        19.4028
   5479 submit_bh                                 18.0230
   3903 __alloc_pages                              3.2965
   3671 file_read_actor                            9.9755
   3425 thread_return                             14.2708
   3333 generic_make_request                       5.6301
   3294 bio_alloc_bioset                           7.6250
   2868 bio_put                                   44.8125
   2851 mpt_interrupt                              2.8284
   2697 mempool_alloc                              8.8717
   2642 block_read_full_page                       3.9315
   2512 do_generic_mapping_read                    2.1216
   2394 set_page_refs                            149.6250
   2235 alloc_page_buffers                         9.9777
   1992 __pagevec_lru_add                          8.3000
   1859 __memset                                   9.6823
   1791 page_waitqueue                            15.9911
   1783 scsi_end_request                           6.9648
   1348 dma_unmap_sg                               6.4808
   1324 bio_endio                                 11.8214
   1306 unlock_page                               20.4062
   1211 mptscsih_freeChainBuffers                  7.5687
   1141 alloc_pages_current                        7.9236
   1136 __mod_page_state                          35.5000
   1116 radix_tree_preload                         8.7188
   1061 __pagevec_release_nonlru                   6.6312
   1043 set_bh_page                                9.3125
   1024 release_pages                              2.9091
   1023 mempool_free                               6.3937
    832 alloc_buffer_head                         13.0000

Full profile data can be found under:

    ftp://ftp.dwd.de/pub/afd/linux_kernel_debug/dd-256k-8disk-read.profile

> You might want to try the same with direct io, just to eliminate the
> costly user copy. I don't expect it to make much of a difference though,
> feels like the problem is elsewhere (driver, most likely).
>
Sorry, I don't know how to do this. Do you mean using a C program
that sets some flag to do direct io, or how can I do that?

> If we still can't get closer to this, it would be interesting to try my
> block tracing stuff so we can see what is going on at the queue level.
> But lets gather some more info first, since it requires testing -mm.
>
Ok, please then just tell me what I must do.

Thanks,
Holger

