Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268430AbUHYD0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268430AbUHYD0j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 23:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268423AbUHYD0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 23:26:38 -0400
Received: from relay.pair.com ([209.68.1.20]:20752 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S268440AbUHYD01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 23:26:27 -0400
X-pair-Authenticated: 66.190.51.173
Message-ID: <412C06E3.8020804@cybsft.com>
Date: Tue, 24 Aug 2004 22:26:27 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Scott Wood <scott@timesys.com>, manas.saksena@timesys.com,
       linux-kernel@vger.kernel.org, rlrevell@joe-job.com
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P9
References: <20040823221816.GA31671@yoda.timesys> <20040824061459.GA29630@elte.hu>
In-Reply-To: <20040824061459.GA29630@elte.hu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any idea what is going on here?

dmesg gives me this:


(kswapd0/32): new 305 us maximum-latency critical section.
  => started at: <get_swap_page+0x28/0x280>
  => ended at:   <get_swap_page+0x96/0x280>
  [<c0135dbf>] check_preempt_timing+0x19f/0x240
  [<c0151bf6>] get_swap_page+0x96/0x280
  [<c0151bf6>] get_swap_page+0x96/0x280
  [<c0135f88>] sub_preempt_count+0x48/0x60
  [<c0135f88>] sub_preempt_count+0x48/0x60
  [<c0151bf6>] get_swap_page+0x96/0x280
  [<c015155a>] add_to_swap+0x2a/0xd0
  [<c0142a73>] shrink_list+0x4e3/0x530
  [<c01413a6>] lru_add_drain+0x36/0x70
  [<c0135f88>] sub_preempt_count+0x48/0x60
  [<c0142bc2>] shrink_cache+0x102/0x370
  [<c0135f88>] sub_preempt_count+0x48/0x60
  [<c0142c26>] shrink_cache+0x166/0x370
  [<c014345e>] shrink_zone+0xae/0xe0
  [<c0143871>] balance_pgdat+0x1e1/0x250
  [<c01439a5>] kswapd+0xc5/0xe0
  [<c0117cc0>] autoremove_wake_function+0x0/0x60
  [<c0106336>] ret_from_fork+0x6/0x14
  [<c0117cc0>] autoremove_wake_function+0x0/0x60
  [<c01438e0>] kswapd+0x0/0xe0
  [<c0104505>] kernel_thread_helper+0x5/0x10


The trace actually looks like this:

preemption latency trace v1.0.2
-------------------------------
  latency: 305 us, entries: 2 (2)
     -----------------
     | task: kswapd0/32, uid:0 nice:0 policy:0 rt_prio:0
     -----------------
  => started at: get_swap_page+0x28/0x280
  => ended at:   get_swap_page+0x96/0x280
=======>
00000001 0.000ms (+0.000ms): get_swap_page (add_to_swap)
00000001 0.306ms (+0.306ms): sub_preempt_count (get_swap_page)

