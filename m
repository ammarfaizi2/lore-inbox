Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264297AbUEXOOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbUEXOOw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 10:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbUEXOOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 10:14:51 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:26589 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264297AbUEXOOO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 10:14:14 -0400
Date: Mon, 24 May 2004 07:13:48 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Phy Prabab <phyprabab@yahoo.com>,
       William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@osdl.org>, jakob@unthought.net,
       linux-kernel@vger.kernel.org
Subject: Re: Help understanding slow down
Message-ID: <350220000.1085408027@[10.10.2.4]>
In-Reply-To: <20040524072107.63774.qmail@web90005.mail.scd.yahoo.com>
References: <20040524072107.63774.qmail@web90005.mail.scd.yahoo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm curious where all those kmap_atomic's come from. Do you have
CONFIG_HIGHPTE enabled? If so, please repeat with it off, and see
if that helps ... if not, grab the kcg patch out my tree, and see
where they're coming from (or shove a printk in there doing a dump_stack
for every 10,000 interations or so)

M.

--Phy Prabab <phyprabab@yahoo.com> wrote (on Monday, May 24, 2004 00:21:07 -0700):

> For more information, I ran the same test on 2.4.21
> with profiling enabled:
> 22133 total               0.0102
> 18255 default_idle        351.0577
> 634 do_page_fault         0.4412
> 342 do_no_page            0.3654
> 231 d_lookup              0.8134
> 173 do_anonymous_page     0.2790
> 157 system_call           2.8036
> 157 pte_alloc_atomic      0.2973
> 130 do_wp_page            0.1222
> 102 __find_get_page       1.5000
> 99 atomic_dec_and_lock    1.3750
> 90 handle_mm_fault        0.2616
> 89 zap_page_range         0.0792
> 86 link_path_walk         0.0343
> 62 mraccessf              0.6458
> 59 permission             0.4470
> 56 mrunlock               0.5600
> 42 strncpy_from_user      0.5526
> 40 strnlen_user           0.4545
> 40 __do_generic_file_read 0.0316
> 39 __free_pages           1.2188
> 35 filemap_nopage         0.0648
> 
> Also refomated the previous report to make it
> readable:
> 
>> 317955 total                 0.1302
>> 263633 poll_idle             4545.3966
>> 6764 do_page_fault           5.1951
>> 3650 kmap_atomic             28.2946
>> 3288 __d_lookup              12.0000
>> 1856 atomic_dec_and_lock     30.4262
>> 1823 do_no_page              2.4870
>> 1398 do_anonymous_page       3.1991
>> 1168 link_path_walk          0.5266
>> 1138 find_get_page           19.9649
>                                1.2450
>> 1075 nfs_lookup_revalidate   0.7739
>> 1039 page_remove_rmap        5.0437
>> 1006 in_group_p              9.4906
>> 987 handle_mm_fault          2.2742
>> 913 do_wp_page               1.1499
>> 816 finish_task_switch       6.6885
>> 772 tg3_poll                 2.6621
>> 762 rpcauth_lookup_credcache 1.3275
>> 722 page_add_file_rmap       4.1257
>> 623 system_call              14.1591
>> 607 strncpy_from_user        6.8202
>> 
>> Thanks again!
>> Phy
>> 
>> 
>> 
>> --- William Lee Irwin III <wli@holomorphy.com>
>> wrote:
>> > On Sun, May 23, 2004 at 11:23:37PM -0700, Phy
>> Prabab
>> > wrote:
>> > > Sorry for the late reply.   No this is a dual
>> Xeon
>> > > 3.06Ghz.  All runs are with the same hardware
>> and
>> > same
>> > > make/build system.
>> > > How do I generate a profile of the system.  I
>> have
>> > > alrady compiled profiling and have enabled the
>> > kernel.
>> > 
>> > readprofile -n -m /boot/System.map-`uname -r` |
>> sort
>> > -rn -k 1,1 | head -22
>> > 
>> > No need for compiled-in support, just boot with
>> > profile=1.
>> > 
>> > 
>> > -- wli
>> 
>> 
>> 	
>> 		
>> __________________________________
>> Do you Yahoo!?
>> Yahoo! Domains – Claim yours for only $14.70/year
>> http://smallbusiness.promotions.yahoo.com/offer 
>> -
>> To unsubscribe from this list: send the line
>> "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at 
>> http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 	
> 		
> __________________________________
> Do you Yahoo!?
> Yahoo! Domains – Claim yours for only $14.70/year
> http://smallbusiness.promotions.yahoo.com/offer 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


