Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267460AbUIUCH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267460AbUIUCH7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 22:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267470AbUIUCH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 22:07:59 -0400
Received: from relay.pair.com ([209.68.1.20]:30482 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S267460AbUIUCH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 22:07:56 -0400
X-pair-Authenticated: 66.188.111.210
Message-ID: <414F8CFB.3030901@cybsft.com>
Date: Mon, 20 Sep 2004 21:07:55 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@Raytheon.com
Subject: BKL backtraces - was: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S1
References: <20040906110626.GA32320@elte.hu> <200409061348.41324.rjw@sisk.pl> <1094473527.13114.4.camel@boxen> <20040906122954.GA7720@elte.hu> <20040907092659.GA17677@elte.hu> <20040907115722.GA10373@elte.hu> <1094597988.16954.212.camel@krustophenia.net> <20040908082050.GA680@elte.hu> <1094683020.1362.219.camel@krustophenia.net> <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu>
In-Reply-To: <20040919122618.GA24982@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i've released the -S1 VP patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm1-S1
> 

All of these were generated while booting:

Sep 20 19:45:10 porky kernel: using smp_processor_id() in preemptible 
code: modprobe/1019
Sep 20 19:45:10 porky kernel:  [<c011c58e>] smp_processor_id+0x8e/0xa0
Sep 20 19:45:10 porky kernel:  [<c013ace6>] module_unload_init+0x46/0x70
Sep 20 19:45:10 porky kernel:  [<c013ce58>] load_module+0x598/0xb10
Sep 20 19:45:10 porky kernel:  [<c013d438>] sys_init_module+0x68/0x280
Sep 20 19:45:10 porky kernel:  [<c01066b9>] sysenter_past_esp+0x52/0x71

The above one of course repeats on each module load.

Sep 20 19:45:10 porky kernel: using smp_processor_id() in preemptible 
code: X/1017
Sep 20 19:45:10 porky kernel:  [<c011c58e>] smp_processor_id+0x8e/0xa0
Sep 20 19:45:10 porky kernel:  [<c01d6c15>] add_timer_randomness+0x125/0x150
Sep 20 19:45:10 porky kernel:  [<c01d6c9e>] add_mouse_randomness+0x1e/0x30
Sep 20 19:45:10 porky kernel:  [<c022b835>] input_event+0x55/0x3f0
Sep 20 19:45:10 porky kernel:  [<c01151e8>] mcount+0x14/0x18
Sep 20 19:45:10 porky kernel:  [<c01e559e>] kbd_rate+0x5e/0xc0
Sep 20 19:45:10 porky kernel:  [<c01e2196>] vt_ioctl+0xe06/0x1ad0
Sep 20 19:45:10 porky kernel:  [<c014fdcf>] pte_alloc_map+0x9f/0xd0
Sep 20 19:45:10 porky kernel:  [<c015214b>] handle_mm_fault+0x17b/0x1a0
Sep 20 19:45:10 porky kernel:  [<c0119440>] do_page_fault+0x1e0/0x621
Sep 20 19:45:10 porky kernel:  [<c0138759>] sub_preempt_count+0x69/0x80
Sep 20 19:45:10 porky kernel:  [<c0138759>] sub_preempt_count+0x69/0x80
Sep 20 19:45:10 porky kernel:  [<c0138512>] check_preempt_timing+0x192/0x200
Sep 20 19:45:10 porky kernel:  [<c0175034>] sys_ioctl+0xe4/0x240
Sep 20 19:45:10 porky kernel:  [<c01dbd1e>] tty_ioctl+0xe/0x4d0
Sep 20 19:45:10 porky kernel:  [<c01151e8>] mcount+0x14/0x18
Sep 20 19:45:10 porky kernel:  [<c01e1390>] vt_ioctl+0x0/0x1ad0
Sep 20 19:45:10 porky kernel:  [<c01dc08b>] tty_ioctl+0x37b/0x4d0
Sep 20 19:45:10 porky kernel:  [<c0175034>] sys_ioctl+0xe4/0x240
Sep 20 19:45:10 porky kernel:  [<c01066b9>] sysenter_past_esp+0x52/0x71

The X one above repeats once also.

kr
