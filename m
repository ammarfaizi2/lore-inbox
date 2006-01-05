Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWAESBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWAESBT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWAESBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:01:19 -0500
Received: from [65.240.208.6] ([65.240.208.6]:51705 "EHLO
	phobos.illtel.denver.co.us") by vger.kernel.org with ESMTP
	id S932128AbWAESBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:01:18 -0500
Message-ID: <43BD5F0B.7060608@phobos.illtel.denver.co.us>
Date: Thu, 05 Jan 2006 11:01:47 -0700
From: Alex Belits <abelits@phobos.illtel.denver.co.us>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051018)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.15 -- Bad page state (again)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happened on Alpha (Miata, Digital Workstation 500au), with plain 
2.6.15 when trying to run esd to talk to ALSA (snd-es18xx). In earlier 
versions this did not happen, however sound still did not work properly 
-- it was looping with no interrupts counted in /proc/interrupts for 
that device. Kernel was built with CONFIG_ALPHA_GENERIC, as opposed to 
CONFIG_ALPHA_MIATA because CONFIG_ALPHA_MIATA for some reason disabled 
serial interrupts.

--- 8< ---
Jan  4 08:24:19 dvk3 kernel: Bad page state at free_hot_cold_page (in 
process 'esd', page fffffc0000481438)
Jan  4 08:24:19 dvk3 kernel: flags:0x0000000000000414 
mapping:0000000000000000 mapcount:0 count:0
Jan  4 08:24:19 dvk3 kernel: Backtrace:
Jan  4 08:24:19 dvk3 kernel: fffffc00095d3c88 0000000000000000 
fffffc000105b218 0000000000000000
Jan  4 08:24:19 dvk3 kernel:        fffffc0001062afc fffffc0000481438 
0000000000063309 fffffc0009f9d328
Jan  4 08:24:19 dvk3 kernel:        00000200004ca000 00000000000006d0 
fffffc0001062608 fffffc000a6e18c0
Jan  4 08:24:19 dvk3 kernel:        fffffc0001072c4c fffffc00016afc00 
fffffc0001068038 fffffc0000481438
Jan  4 08:24:19 dvk3 kernel:        fffffc0001068278 00000200004d8000 
fffffc00089e4000 fffffc00095d3e28
Jan  4 08:24:19 dvk3 kernel:        fffffc000892a800 0000000000000000 
fffffc000892a800 00000200004d8000
Jan  4 08:24:19 dvk3 kernel: Trace:
Jan  4 08:24:19 dvk3 kernel: [free_hot_cold_page+160/364] 
free_hot_cold_page+0xa0/0x16c
Jan  4 08:24:19 dvk3 kernel: [__page_cache_release+236/256] 
__page_cache_release+0xec/0x100
Jan  4 08:24:19 dvk3 kernel: [put_page+208/228] put_page+0xd0/0xe4
Jan  4 08:24:19 dvk3 kernel: [free_page_and_swap_cache+112/136] 
free_page_and_swap_cache+0x70/0x88
Jan  4 08:24:19 dvk3 kernel: [zap_pte_range+464/644] 
zap_pte_range+0x1d0/0x284
Jan  4 08:24:19 dvk3 kernel: [unmap_page_range+396/516] 
unmap_page_range+0x18c/0x204
Jan  4 08:24:19 dvk3 kernel: [context_switch+280/372] 
context_switch+0x118/0x174
Jan  4 08:24:19 dvk3 kernel: [unmap_vmas+276/544] unmap_vmas+0x114/0x220
Jan  4 08:24:19 dvk3 kernel: [unmap_region+176/364] unmap_region+0xb0/0x16c
Jan  4 08:24:19 dvk3 kernel: [do_munmap+304/352] do_munmap+0x130/0x160
Jan  4 08:24:19 dvk3 kernel: [sys_munmap+128/216] sys_munmap+0x80/0xd8
Jan  4 08:24:19 dvk3 kernel: [entSys+164/192] entSys+0xa4/0xc0
Jan  4 08:24:19 dvk3 kernel:
Jan  4 08:24:19 dvk3 kernel: Trying to fix it up, but a reboot is needed
--- >8 ---

(identical entries followed in the log).

This looks similar to what was reported for 2.6.15-rc1-mm2, except that 
this is 2.6.15.
-- 
Alex Belits

