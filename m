Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264420AbUAIXDc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 18:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbUAIXDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 18:03:32 -0500
Received: from moutng.kundenserver.de ([212.227.126.176]:220 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264420AbUAIXD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 18:03:29 -0500
Message-ID: <3FFF33B2.1050707@marcush.de>
Date: Sat, 10 Jan 2004 00:05:22 +0100
From: Marcus Hartig <marcus@marcush.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.1-mm1 oopses
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:9d75d3da258886da80f58b1205b7baad
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

patching 2.6.1 to mm1 from A. Morton, the kernel oopses after connecting
to my dsl provider:

------------------------------------------------------------------------
Jan  9 18:16:51 redtuxi kernel: ip_conntrack version 2.1 (4095 buckets, 
32760 max) - 300 bytes per conntrack
Jan  9 18:16:51 redtuxi kernel: Module len 6534 truncated
Jan  9 18:16:51 redtuxi kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000004
Jan  9 18:16:51 redtuxi kernel:  printing eip:
Jan  9 18:16:51 redtuxi kernel: c0137630
Jan  9 18:16:51 redtuxi kernel: *pde = 00000000
Jan  9 18:16:51 redtuxi kernel: Oops: 0002 [#1]
Jan  9 18:16:51 redtuxi kernel: PREEMPT
Jan  9 18:16:51 redtuxi kernel: CPU:    0
Jan  9 18:16:51 redtuxi kernel: EIP:    0060:[<c0137630>]    Tainted: P 
   VLI
Jan  9 18:16:51 redtuxi kernel: EFLAGS: 00210002
Jan  9 18:16:51 redtuxi kernel: EIP is at sys_init_module+0xc0/0x250
Jan  9 18:16:51 redtuxi kernel: eax: 00000004   ebx: 08074de8   ecx: 
c1384d70   edx: e09c7bc4
Jan  9 18:16:51 redtuxi kernel: esi: 00000000   edi: c02bd278   ebp: 
d65dc000   esp: d65ddfa4
Jan  9 18:16:51 redtuxi kernel: ds: 007b   es: 007b   ss: 0068
Jan  9 18:16:51 redtuxi kernel: Process modprobe (pid: 4275, 
threadinfo=d65dc000 task=d65df940)
Jan  9 18:16:51 redtuxi kernel: Stack: 08074de8 00001986 08074088 
08074de8 00000002 08053670 d65dc000 c027f4c6
Jan  9 18:16:51 redtuxi kernel:        08074de8 00001986 08074088 
00000002 08053670 bfffe890 00000080 0000007b
Jan  9 18:16:51 redtuxi kernel:        0000007b 00000080 ffffd41a 
00000073 00200287 bfffe890 0000007b
Jan  9 18:16:51 redtuxi kernel: Call Trace:
Jan  9 18:16:51 redtuxi kernel:  [<c027f4c6>] sysenter_past_esp+0x43/0x65
Jan  9 18:16:51 redtuxi kernel:
Jan  9 18:16:51 redtuxi kernel: Code: 76 12 89 f9 ff 05 78 d2 2b c0 0f 
8e 5f 07 00 00 89 c2 eb b3 fa bd 00 e0 ff ff 21 e5 ff 45 14 8b 15 88 d2 
2b c0 8d 40
04 89 42 04 <89> 56 04 c7 40 04 88 d2 2b c0 a3 88 d2 2b c0 fb 8b 45 08 ff 4d
Jan  9 18:16:51 redtuxi kernel:  <6>note: modprobe[4275] exited with 
preempt_count 1
Jan  9 18:16:51 redtuxi kernel: bad: scheduling while atomic!
Jan  9 18:16:51 redtuxi kernel: Call Trace:
Jan  9 18:16:51 redtuxi kernel:  [<c011ccf9>] schedule+0x5b9/0x5c0
Jan  9 18:16:51 redtuxi kernel:  [<c0147903>] unmap_page_range+0x43/0x70
Jan  9 18:16:51 redtuxi kernel:  [<c0147af8>] unmap_vmas+0x1c8/0x220
Jan  9 18:16:51 redtuxi kernel:  [<c014ba2b>] exit_mmap+0x7b/0x190
Jan  9 18:16:51 redtuxi kernel:  [<c011e8ba>] mmput+0x7a/0xf0
Jan  9 18:16:51 redtuxi kernel:  [<c01229ad>] do_exit+0x15d/0x3f0
Jan  9 18:16:51 redtuxi kernel:  [<c010d0cc>] die+0xfc/0x100
Jan  9 18:16:51 redtuxi kernel:  [<c011ac78>] do_page_fault+0x1f8/0x512
Jan  9 18:16:51 redtuxi kernel:  [<c0151877>] vfree+0x27/0x40
Jan  9 18:16:51 redtuxi kernel:  [<c0136bdf>] load_module+0xbf/0xa50
Jan  9 18:16:51 redtuxi kernel:  [<c011aa80>] do_page_fault+0x0/0x512
Jan  9 18:16:51 redtuxi kernel:  [<c027f6c7>] error_code+0x2f/0x38
Jan  9 18:16:51 redtuxi kernel:  [<c0137630>] sys_init_module+0xc0/0x250
Jan  9 18:16:51 redtuxi kernel:  [<c027f4c6>] sysenter_past_esp+0x43/0x65
Jan  9 18:16:51 redtuxi kernel:
-------------------------------------------------------------------------


Marcus
