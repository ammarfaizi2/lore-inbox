Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbWJYOIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbWJYOIN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 10:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030457AbWJYOIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 10:08:13 -0400
Received: from zod.pns.networktel.net ([209.159.47.6]:64212 "EHLO
	zod.pns.networktel.net") by vger.kernel.org with ESMTP
	id S1030336AbWJYOIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 10:08:12 -0400
Message-ID: <453F6D05.2000604@versaccounting.com>
Date: Wed, 25 Oct 2006 08:56:21 -0500
From: Ben Duncan <ben@versaccounting.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: EIP Errors kernel 2.6.18 .AND hard lockup ... Revisted
References: <45194883.3080700@versaccounting.com> <6bffcb0e0609260851q5d97f784i47d43f2076843600@mail.gmail.com> <451965E5.1080600@versaccounting.com>
In-Reply-To: <451965E5.1080600@versaccounting.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, Same stuff, different day. Took the nVidia drivers out.
Ran HOT MEM checks, all passed (elimnating RAM issues).

Same as this time last month.

Got hard lock ups every 2 - 3 days. No syslog / debug ever given -
pdflush ,when top is left running on console - shows 100% CPU usage.

FINALLY got this morning a EIP error :

Oct 25 04:45:02 desktop kernel: BUG: unable to handle kernel NULL pointer dereference at 
virtual address 00000020
Oct 25 04:45:02 desktop kernel:  printing eip:
Oct 25 04:45:02 desktop kernel: c0160620
Oct 25 04:45:02 desktop kernel: *pde = 00000000
Oct 25 04:45:02 desktop kernel: Oops: 0000 [#1]
Oct 25 04:45:02 desktop kernel: DEBUG_PAGEALLOC
Oct 25 04:45:02 desktop kernel: Modules linked in: nls_iso8859_15 usb_storage uhci_hcd 
nvidia_agp i2c_nforce2 sata_nv sd
_mod ide_scsi agpgart sata_sil libata genrtc
Oct 25 04:45:02 desktop kernel: CPU:    0
Oct 25 04:45:02 desktop kernel: EIP:    0060:[<c0160620>]    Not tainted VLI
Oct 25 04:45:02 desktop kernel: EFLAGS: 00010283   (2.6.18 #1)
Oct 25 04:45:02 desktop kernel: EIP is at iput+0x17/0x65
Oct 25 04:45:02 desktop kernel: eax: 00000000   ebx: cf2aee70   ecx: cf2aee88   edx: f7cf4000
Oct 25 04:45:02 desktop kernel: esi: cf2aee70   edi: d5e8c128   ebp: f7cf5e84   esp: f7cf5e80
Oct 25 04:45:02 desktop kernel: ds: 007b   es: 007b   ss: 0068
Oct 25 04:45:02 desktop kernel: Process kswapd0 (pid: 182, ti=f7cf4000 task=f7cdaa90 
task.ti=f7cf4000)
Oct 25 04:45:02 desktop kernel: Stack: d5e8c120 f7cf5e98 c015dc4e d5e8c120 d5e8c120 d5e8c128 
f7cf5ea8 c015e093
Oct 25 04:45:02 desktop kernel:        f5e96e34 d5e8c120 f7cf5ec4 c015e1cc 00000000 0000003c 
00017124 00000000
Oct 25 04:45:02 desktop kernel:        000000a6 f7cf5ecc c015e441 f7cf5f08 c0136fef 005c4900 
00000000 00017124
Oct 25 04:45:02 desktop kernel: Call Trace:
Oct 25 04:45:02 desktop kernel:  [<c0103485>] show_stack_log_lvl+0x8f/0x97
Oct 25 04:45:02 desktop kernel:  [<c01035e6>] show_registers+0x116/0x17f
Oct 25 04:45:02 desktop kernel:  [<c01037cb>] die+0x108/0x1ba
Oct 25 04:45:02 desktop kernel:  [<c010ecb3>] do_page_fault+0x3a4/0x481
Oct 25 04:45:02 desktop kernel:  [<c0103161>] error_code+0x39/0x40
Oct 25 04:45:02 desktop kernel:  [<c015dc4e>] dentry_iput+0x5b/0x73
Oct 25 04:45:02 desktop kernel:  [<c015e093>] prune_one_dentry+0x56/0x79
Oct 25 04:45:02 desktop kernel:  [<c015e1cc>] prune_dcache+0x116/0x14a
Oct 25 04:45:02 desktop kernel:  [<c015e441>] shrink_dcache_memory+0x19/0x31
Oct 25 04:45:02 desktop kernel:  [<c0136fef>] shrink_slab+0x12f/0x18a
Oct 25 04:45:02 desktop kernel:  [<c013803b>] balance_pgdat+0x1c4/0x29c
Oct 25 04:45:02 desktop kernel:  [<c0138207>] kswapd+0xf4/0xf6
Oct 25 04:45:02 desktop kernel:  [<c01242ee>] kthread+0x79/0xa1
Oct 25 04:45:02 desktop kernel:  [<c0100d19>] kernel_thread_helper+0x5/0xb
Oct 25 04:45:02 desktop kernel: Code: 00 55 89 e5 75 07 e8 de fd ff ff eb 05 e8 bd fe ff ff 
c9 c3 55 85 c0 89 e5 53 89 c
3 74 58 83 bb 70 01 00 00 20 8b 80 cc 00 00 00 <8b> 40 20 75 08 0f 0b 73 04 e6 94 30 c0 85 
c0 74 0b 8b 50 14 85
Oct 25 04:45:02 desktop kernel: EIP: [<c0160620>] iput+0x17/0x65 SS:ESP 0068:f7cf5e80

--------------------------------------------------------------------------------------

Problems seemt to have started  when I added at start of summer, a SIL 3112A SATA controller
and a WD 250GB WD2500SD-01K Rev: 08.0 250GB SATA disk.


-- 
Ben Duncan   - Business Network Solutions, Inc. 336 Elton Road  Jackson MS, 39212
"Never attribute to malice, that which can be adequately explained by stupidity"
        - Hanlon's Razor

