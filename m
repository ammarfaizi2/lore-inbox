Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265133AbRGENV6>; Thu, 5 Jul 2001 09:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265149AbRGENVk>; Thu, 5 Jul 2001 09:21:40 -0400
Received: from mail.spylog.com ([194.67.35.220]:16036 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S265133AbRGENVe>;
	Thu, 5 Jul 2001 09:21:34 -0400
Date: Thu, 5 Jul 2001 17:22:49 +0400
From: Peter Zaitsev <pz@spylog.ru>
X-Mailer: The Bat! (v1.52f)
Reply-To: Peter Zaitsev <pz@spylog.ru>
Organization: SpyLOG
X-Priority: 3 (Normal)
Message-ID: <11486070195.20010705172249@spylog.ru>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re[2]: Is  Swapping on software RAID1 possible  in linux 2.4 ?
In-Reply-To: <15172.22988.643481.421716@notabene.cse.unsw.edu.au>
In-Reply-To: <1011478953412.20010705152412@spylog.ru>
 <15172.22988.643481.421716@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Neil,

Thursday, July 05, 2001, 4:13:00 PM, you wrote:

NB> On Thursday July 5, pz@spylog.ru wrote:
>> Hello linux-kernel,
>> 
>>   Does anyone have information on this subject ?  I have the constant
>>   failures with system swapping on RAID1, I just wanted to be shure
>>   this may be the problem or not.   It works without any problems with
>>   2.2 kernel.

NB> It certainly should work in 2.4.  What sort of "constant failures" are
NB> you experiencing?

NB> Though it does appear to work in 2.2, there is a possibility of data
NB> corruption if you swap onto a raid1 array that is resyncing.  This
NB> possibility does not exist in 2.4.



The problem is I'm constantly getting these  X-order-allocation errors
in kernel log and after which system becomes unstable and often hangs
or leaves process which cannot be killed even by "-9" signal.
Installed debuggin patches produce the following allocation paths:

> Jun 20 05:56:14 tor kernel: Call Trace: [__get_free_pages+20/36]
> [__get_free_pages+20/36] [kmem_cache_grow+187/520] [kmalloc+183/224]
> [raid1_alloc_r1bh+105/256] [raid1_make_request+832/852]
> [raid1_make_request+80/852]
> Jun 20 05:56:14 tor kernel:        [md_make_request+79/124]
> [generic_make_request+293/308] [submit_bh+87/116] [brw_page+143/160]
> [rw_swap_page_base+336/428] [rw_swap_page+112/184] [swap_writepage+120/128]
> [page_launder+644/2132]
> Jun 20 05:56:14 tor kernel:        [do_try_to_free_pages+52/124]
> [kswapd+89/228] [kernel_thread+40/56]
>

one more trace:

SR>>Jun 19 09:50:08 garnet kernel: __alloc_pages: 0-order allocation failed.
SR>>Jun 19 09:50:08 garnet kernel: __alloc_pages: 0-order allocation failed from
SR>>c01Jun 19 09:50:08 garnet kernel: ^M^Mf4a2bc74 c024ac20 00000000 c012ca09
SR>>c024abe0
SR>>Jun 19 09:50:08 garnet kernel:        00000008 c03225e0 00000003 00000001
SR>>c029c9Jun 19 09:50:08 garnet kernel:        f0ebb760 00000001 00000008
SR>>c03225e0 c0197bJun 19 09:50:08 garnet kernel: Call Trace:
SR>>[alloc_bounce_page+13/140] [alloc_bouJun 19 09:50:08 garnet kernel:
SR>>[raid1_make_request+832/852] [md_make_requJun 19 09:50:08 garnet kernel:
SR>>[swap_writepage+120/128] [page_launder+644Jun 19 09:50:08 garnet kernel:
SR>>[sock_poll+35/40] [do_select+230/476] [sysJun 19 10:21:27 garnet kernel:
SR>>sending pkt_too_big to self
SR>>Jun 19 10:21:55 garnet kernel: sending pkt_too_big to self
SR>>Jun 19 10:34:36 garnet kernel: sending pkt_too_big to self
SR>>Jun 19 10:35:33 garnet last message repeated 2 times
SR>>Jun 19 10:36:50 garnet kernel: sending pkt_too_big to self

That's why I thought this problem is related to raid1 swapping I'm
using.

Well. Of couse I'm speaking about synced RAID1.




-- 
Best regards,
 Peter                            mailto:pz@spylog.ru

