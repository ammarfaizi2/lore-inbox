Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTFBLgX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 07:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbTFBLgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 07:36:23 -0400
Received: from tomts10.bellnexxia.net ([209.226.175.54]:20366 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262176AbTFBLgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 07:36:21 -0400
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: 2.5.70-mm3
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Reply-To: tomlins@cam.org
Date: Mon, 02 Jun 2003 07:50:32 -0400
References: <fa.j88qmt3.1s0mkrl@ifi.uio.no> <fa.h65tbmk.i5io9k@ifi.uio.no>
Organization: me
User-Agent: KNode/0.7.6
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20030602115034.629F5ACE@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This from -mm2 on UP (k6-III 400, 512M):

May 31 09:31:24 oscar kernel: Bad page state at free_hot_cold_page
May 31 09:31:24 oscar kernel: flags:0x01000208 mapping:00000000 mapped:0 count:0
May 31 09:31:24 oscar kernel: Backtrace:
May 31 09:31:24 oscar kernel: Call Trace:
May 31 09:31:24 oscar kernel:  [bad_page+70/108] bad_page+0x46/0x6c
May 31 09:31:24 oscar kernel:  [free_hot_cold_page+87/212] free_hot_cold_page+0x57/0xd4
May 31 09:31:24 oscar kernel:  [__pagevec_free+31/40] __pagevec_free+0x1f/0x28
May 31 09:31:24 oscar kernel:  [__pagevec_release_nonlru+117/132] __pagevec_release_nonlru+0x75/0x84
May 31 09:31:24 oscar kernel:  [shrink_list+1016/1212] shrink_list+0x3f8/0x4bc
May 31 09:31:24 oscar kernel:  [shrink_cache+383/684] shrink_cache+0x17f/0x2ac
May 31 09:31:24 oscar kernel:  [shrink_zone+98/108] shrink_zone+0x62/0x6c
May 31 09:31:24 oscar kernel:  [balance_pgdat+214/352] balance_pgdat+0xd6/0x160
May 31 09:31:24 oscar kernel:  [kswapd+261/268] kswapd+0x105/0x10c
May 31 09:31:24 oscar kernel:  [kswapd+0/268] kswapd+0x0/0x10c
May 31 09:31:24 oscar kernel:  [autoremove_wake_function+0/56] autoremove_wake_function+0x0/0x38
May 31 09:31:24 oscar kernel:  [autoremove_wake_function+0/56] autoremove_wake_function+0x0/0x38
May 31 09:31:24 oscar kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
May 31 09:31:24 oscar kernel:
May 31 09:31:24 oscar kernel: Trying to fix it up, but a reboot is needed

So far I've not seen this with mm3, but it looks like Alistair has :-(   In my case,
this triggered when doing "apt-get -u upgrade".  It was a large upgrade as 
kde was updated.

Ed

PS.  I have more examples if they will help.


Andrew Morton wrote:

> Alistair J Strachan <alistair@devzero.co.uk> wrote:
>>
>> Bad page state at free_hot_cold_page
>>  flags:0x01010000 mapping:00000000 mapped:1 count:0
>>  Backtrace:
>>  Call Trace:
>>   [bad_page+93/144] bad_page+0x5d/0x90
>>   [free_hot_cold_page+112/256] free_hot_cold_page+0x70/0x100
>>   [zap_pte_range+385/448] zap_pte_range+0x181/0x1c0
>>   [do_wp_page+437/848] do_wp_page+0x1b5/0x350
>>   [zap_pmd_range+75/112] zap_pmd_range+0x4b/0x70
>>   [unmap_page_range+75/128] unmap_page_range+0x4b/0x80
>>   [unmap_vmas+254/544] unmap_vmas+0xfe/0x220
>>   [exit_mmap+109/384] exit_mmap+0x6d/0x180
>>   [mmput+65/176] mmput+0x41/0xb0
>>   [do_exit+243/832] do_exit+0xf3/0x340
> 
> eww, that's a PageDirect page.  Never seen that before - it's
> bad.
> 
> Is the box SMP?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

