Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVGZVPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVGZVPj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 17:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVGZVNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 17:13:32 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:18589 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262068AbVGZVL6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 17:11:58 -0400
Subject: Re: Memory pressure handling with iSCSI
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <20050726121250.0ba7d744.akpm@osdl.org>
References: <1122399331.6433.29.camel@dyn9047017102.beaverton.ibm.com>
	 <20050726111110.6b9db241.akpm@osdl.org>
	 <1122403152.6433.39.camel@dyn9047017102.beaverton.ibm.com>
	 <20050726114824.136d3dad.akpm@osdl.org>
	 <20050726121250.0ba7d744.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-UayLtlB45iMwl2xjGQMB"
Date: Tue, 26 Jul 2005 14:11:41 -0700
Message-Id: <1122412301.6433.54.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UayLtlB45iMwl2xjGQMB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-07-26 at 12:12 -0700, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > Can you please reduce the number of filesystems, see if that reduces the
> >  dirty levels?
> 
> Also, it's conceivable that ext3 is implicated here, so it might be saner
> to perform initial investigation on ext2.
> 
> (when kjournald writes back a page via its buffers, the page remains
> "dirty" as far as the VFS is concerned.  Later, someone tries to do a
> writepage() on it and we'll discover the buffers' cleanness and the page
> will be cleaned without any I/O being performed.  All the throttling
> _should_ work OK in this case.  But ext2 is more straightforward.)

ext2 is incredibly better. Machine is very responsive. 


# echo 2 > /proc/profile; sleep 5; readprofile -
m /usr/src/*12.3/System.map | sort -nr
 28671 total                                      0.0096
 25024 default_idle                             521.3333
  1987 shrink_zone                                0.5285
   163 tg3_poll                                   0.0666
   154 unlock_page                                2.4062
   113 page_referenced                            0.3363
   106 copy_user_generic                          0.3557
    98 __wake_up_bit                              2.0417
    74 release_pages                              0.1779
    71 page_waitqueue                             0.7396
    51 tg3_start_xmit                             0.0287
    39 __make_request                             0.0290
    36 tcp_ack                                    0.0048
    30 tcp_sendpage                               0.0100
    30 scsi_request_fn                            0.0260
    28 tg3_interrupt_tagged                       0.0700
    27 kmem_cache_alloc                           0.4219
    23 kmem_cache_free                            0.2396
    22 rotate_reclaimable_page                    0.0859
    20 established_get_next                       0.0595
    20 cond_resched                               0.1786
    20 __mod_page_state                           0.4167
    16 tcp_transmit_skb                           0.0081
    15 memset                                     0.0781
    15 __kfree_skb                                0.0521
    14 tcp_write_xmit                             0.0194
    14 handle_IRQ_event                           0.1458
    12 skb_clone                                  0.0214
    12 kfree                                      0.0500
    12 end_buffer_async_write                     0.0469
    11 tcp_v4_rcv                                 0.0041
    10 test_set_page_writeback                    0.0329


Thanks,
Badari


--=-UayLtlB45iMwl2xjGQMB
Content-Disposition: attachment; filename=vmstat-ext2.out
Content-Type: text/plain; name=vmstat-ext2.out; charset=utf-8
Content-Transfer-Encoding: 7bit

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1 56      4  33372  12512 6794560    0    0   142  1451 10283  1632  0  7  0 93
 0 56      4  35488  12496 6791996    0    0   131  1762 10335  1583  0  3  0 96
 0 56      4  33132  12540 6794532    0    0     1  1320 10228  2082  0  4  0 96
 0 56      4  33132  12684 6794388    0    0    35  2054 10414  1973  0  7  0 93
 0 56      4  33380  12712 6794876    0    0     0  2676 10635  2739  0  6  0 94
 0 56      4  33132  12672 6793368    0    0     2  6799 10240  2617  0 10  0 90
 0 56      4  33132  12608 6793948    0    0     0 10525 10249  2945  0 10  0 90
 2 56      4  33380  12528 6792996    0    0     1 12566 11081  2813  0 12  0 88
 1 55      4  33380  12368 6793672    0    0     1  9206 10237  2608  0 13  0 87
 0 56      4  33132  12176 6793348    0    0     0 10939 10156  2744  0 17  0 83
 2 59      4  33256  12060 6794496    0    0     5 11706 10464  2746  0 15  0 85
 0 56      4  33504  11844 6794196    0    0     0 12196 10525  2835  0 17  0 83
 0 56      4  33504  11592 6795480    0    0     0  8656 10463  2692  0 10  0 90
 0 56      4  33132  11492 6796612    0    0     1  9022 10222  2496  0 11  0 89
 2 55      4  33256  11384 6796720    0    0     0  9661 10830  2813  0  9  0 91



--=-UayLtlB45iMwl2xjGQMB--

