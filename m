Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266123AbUAGC6T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 21:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266121AbUAGC6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 21:58:19 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:490 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S266123AbUAGC6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 21:58:09 -0500
Date: Tue, 06 Jan 2004 18:57:57 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: linux-mm mailing list <linux-mm@kvack.org>
Subject: shutdown panic in mm_release (really flush_tlb_others?)
Message-ID: <4500000.1073444277@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And the award for longest panic I've ever seen goes to ....
<drumroll> ....

(there were several of these in sequence).
Looks like it was trying to printk an error on shutdown ...
really maybe " [<c0115242>] flush_tlb_others+0x22/0xd0"

Probably the same panic I sent out the other day in a slight
disguise ... "BUG_ON(!cpus_equal(cpumask, tmp));" in flush_tlb_others

Unable to handle kernel NULL pointer dereference at virtual address 00000014
 printing eip:
c011dce4
*pde = 00003001
*pte = 00000000
Oops: 0000 [#22]
CPU:    0
EIP:    0060:[<c011dce4>]    Not tainted VLI
EFLAGS: 00010206
EIP is at mm_release+0x34/0x78
eax: 00000000   ebx: d54ab330   ecx: 4005f948   edx: 00000000
esi: d54ab330   edi: ef2f4724   ebp: 0000000b   esp: ef2f4630
ds: 007b   es: 007b   ss: 0068
Process halt (pid: 8846, threadinfo=ef2f4000 task=d54ab330)
Stack: 00000000 c0121805 d54ab330 00000000 ef2f4000 ef2f4724 ef2f4724 0000000b 
       c010af3c 0000000b 00000000 d54ab330 c011855a c026d31e ef2f4724 00000000 
       d54ab330 00000000 c01181d8 0000000b 00000000 c0380dc0 021f2961 00000000 
       00000001 00000000 c012682f c0380dc0 00030001 c00bf620 00000001 c01d1274 
Call Trace:
 [<c0121805>] do_exit+0xc1/0x330
 [<c010af3c>] do_divide_error+0x0/0xac
 [<c011855a>] do_page_fault+0x382/0x540
 [<c01181d8>] do_page_fault+0x0/0x540
 [<c012682f>] mod_timer+0x43/0x4c
 [<c01d1274>] poke_blanked_console+0x64/0x68
 [<c01d082c>] vt_console_print+0x2bc/0x2d0
 [<c011fba4>] __call_console_drivers+0x3c/0x4c
 [<c011fc0c>] _call_console_drivers+0x58/0x60
 [<c011fcf2>] call_console_drivers+0xde/0xe8
 [<c0260c7b>] error_code+0x2f/0x38
 [<c011dce4>] mm_release+0x34/0x78
 [<c0121805>] do_exit+0xc1/0x330
 [<c010af3c>] do_divide_error+0x0/0xac
 [<c011855a>] do_page_fault+0x382/0x540
 [<c01181d8>] do_page_fault+0x0/0x540
 [<c012682f>] mod_timer+0x43/0x4c
 [<c01d1274>] poke_blanked_console+0x64/0x68
 [<c01d082c>] vt_console_print+0x2bc/0x2d0
 [<c011fba4>] __call_console_drivers+0x3c/0x4c
 [<c011fc0c>] _call_console_drivers+0x58/0x60
 [<c011fcf2>] call_console_drivers+0xde/0xe8
 [<c0260c7b>] error_code+0x2f/0x38
 [<c011dce4>] mm_release+0x34/0x78
 [<c0121805>] do_exit+0xc1/0x330
 [<c010af3c>] do_divide_error+0x0/0xac
 [<c011855a>] do_page_fault+0x382/0x540
 [<c01181d8>] do_page_fault+0x0/0x540
 [<c012682f>] mod_timer+0x43/0x4c
 [<c01d1274>] poke_blanked_console+0x64/0x68
 [<c01d082c>] vt_console_print+0x2bc/0x2d0
 [<c011fba4>] __call_console_drivers+0x3c/0x4c
 [<c011fc0c>] _call_console_drivers+0x58/0x60
 [<c011fcf2>] call_console_drivers+0xde/0xe8
 [<c0260c7b>] error_code+0x2f/0x38
 [<c011dce4>] mm_release+0x34/0x78
 [<c0121805>] do_exit+0xc1/0x330
 [<c010af3c>] do_divide_error+0x0/0xac
 [<c011855a>] do_page_fault+0x382/0x540
 [<c01181d8>] do_page_fault+0x0/0x540
 [<c012682f>] mod_timer+0x43/0x4c
 [<c01d1274>] poke_blanked_console+0x64/0x68
 [<c01d082c>] vt_console_print+0x2bc/0x2d0
 [<c011fba4>] __call_console_drivers+0x3c/0x4c
 [<c011fc0c>] _call_console_drivers+0x58/0x60
 [<c011fcf2>] call_console_drivers+0xde/0xe8
 [<c0260c7b>] error_code+0x2f/0x38
 [<c011dce4>] mm_release+0x34/0x78
 [<c0121805>] do_exit+0xc1/0x330
 [<c010af3c>] do_divide_error+0x0/0xac
 [<c011855a>] do_page_fault+0x382/0x540
 [<c01181d8>] do_page_fault+0x0/0x540
 [<c012682f>] mod_timer+0x43/0x4c
 [<c01d1274>] poke_blanked_console+0x64/0x68
 [<c01d082c>] vt_console_print+0x2bc/0x2d0
 [<c011fba4>] __call_console_drivers+0x3c/0x4c
 [<c011fc0c>] _call_console_drivers+0x58/0x60
 [<c011fcf2>] call_console_drivers+0xde/0xe8
 [<c0260c7b>] error_code+0x2f/0x38
 [<c011dce4>] mm_release+0x34/0x78
 [<c0121805>] do_exit+0xc1/0x330
 [<c010af3c>] do_divide_error+0x0/0xac
 [<c011855a>] do_page_fault+0x382/0x540
 [<c01181d8>] do_page_fault+0x0/0x540
 [<c012682f>] mod_timer+0x43/0x4c
 [<c01d1274>] poke_blanked_console+0x64/0x68
 [<c01d082c>] vt_console_print+0x2bc/0x2d0
 [<c011fba4>] __call_console_drivers+0x3c/0x4c
 [<c011fc0c>] _call_console_drivers+0x58/0x60
 [<c011fcf2>] call_console_drivers+0xde/0xe8
 [<c0260c7b>] error_code+0x2f/0x38
 [<c011dce4>] mm_release+0x34/0x78
 [<c0121805>] do_exit+0xc1/0x330
 [<c010af3c>] do_divide_error+0x0/0xac
 [<c011855a>] do_page_fault+0x382/0x540
 [<c01181d8>] do_page_fault+0x0/0x540
 [<c012682f>] mod_timer+0x43/0x4c
 [<c01d1274>] poke_blanked_console+0x64/0x68
 [<c01d082c>] vt_console_print+0x2bc/0x2d0
 [<c011fba4>] __call_console_drivers+0x3c/0x4c
 [<c011fc0c>] _call_console_drivers+0x58/0x60
 [<c011fcf2>] call_console_drivers+0xde/0xe8
 [<c0260c7b>] error_code+0x2f/0x38
 [<c011dce4>] mm_release+0x34/0x78
 [<c0121805>] do_exit+0xc1/0x330
 [<c010af3c>] do_divide_error+0x0/0xac
 [<c011855a>] do_page_fault+0x382/0x540
 [<c01181d8>] do_page_fault+0x0/0x540
 [<c012682f>] mod_timer+0x43/0x4c
 [<c01d1274>] poke_blanked_console+0x64/0x68
 [<c01d082c>] vt_console_print+0x2bc/0x2d0
 [<c011fba4>] __call_console_drivers+0x3c/0x4c
 [<c011fc0c>] _call_console_drivers+0x58/0x60
 [<c011fcf2>] call_console_drivers+0xde/0xe8
 [<c0260c7b>] error_code+0x2f/0x38
 [<c011dce4>] mm_release+0x34/0x78
 [<c0121805>] do_exit+0xc1/0x330
 [<c010af3c>] do_divide_error+0x0/0xac
 [<c011855a>] do_page_fault+0x382/0x540
 [<c01181d8>] do_page_fault+0x0/0x540
 [<c012682f>] mod_timer+0x43/0x4c
 [<c01d1274>] poke_blanked_console+0x64/0x68
 [<c01d082c>] vt_console_print+0x2bc/0x2d0
 [<c011fba4>] __call_console_drivers+0x3c/0x4c
 [<c011fc0c>] _call_console_drivers+0x58/0x60
 [<c011fcf2>] call_console_drivers+0xde/0xe8
 [<c0260c7b>] error_code+0x2f/0x38
 [<c011dce4>] mm_release+0x34/0x78
 [<c0121805>] do_exit+0xc1/0x330
 [<c010af3c>] do_divide_error+0x0/0xac
 [<c011855a>] do_page_fault+0x382/0x540
 [<c01181d8>] do_page_fault+0x0/0x540
 [<c012682f>] mod_timer+0x43/0x4c
 [<c01d1274>] poke_blanked_console+0x64/0x68
 [<c01d082c>] vt_console_print+0x2bc/0x2d0
 [<c011fba4>] __call_console_drivers+0x3c/0x4c
 [<c011fc0c>] _call_console_drivers+0x58/0x60
 [<c011fcf2>] call_console_drivers+0xde/0xe8
 [<c0260c7b>] error_code+0x2f/0x38
 [<c011dce4>] mm_release+0x34/0x78
 [<c0121805>] do_exit+0xc1/0x330
 [<c010af3c>] do_divide_error+0x0/0xac
 [<c011855a>] do_page_fault+0x382/0x540
 [<c01181d8>] do_page_fault+0x0/0x540
 [<c012682f>] mod_timer+0x43/0x4c
 [<c01d1274>] poke_blanked_console+0x64/0x68
 [<c01d082c>] vt_console_print+0x2bc/0x2d0
 [<c011fba4>] __call_console_drivers+0x3c/0x4c
 [<c011fc0c>] _call_console_drivers+0x58/0x60
 [<c011fcf2>] call_console_drivers+0xde/0xe8
 [<c0260c7b>] error_code+0x2f/0x38
 [<c011dce4>] mm_release+0x34/0x78
 [<c0121805>] do_exit+0xc1/0x330
 [<c010af3c>] do_divide_error+0x0/0xac
 [<c011855a>] do_page_fault+0x382/0x540
 [<c01181d8>] do_page_fault+0x0/0x540
 [<c012682f>] mod_timer+0x43/0x4c
 [<c01d1274>] poke_blanked_console+0x64/0x68
 [<c01d082c>] vt_console_print+0x2bc/0x2d0
 [<c011fba4>] __call_console_drivers+0x3c/0x4c
 [<c011fc0c>] _call_console_drivers+0x58/0x60
 [<c011fcf2>] call_console_drivers+0xde/0xe8
 [<c0260c7b>] error_code+0x2f/0x38
 [<c011dce4>] mm_release+0x34/0x78
 [<c0121805>] do_exit+0xc1/0x330
 [<c010af3c>] do_divide_error+0x0/0xac
 [<c011855a>] do_page_fault+0x382/0x540
 [<c01181d8>] do_page_fault+0x0/0x540
 [<c012682f>] mod_timer+0x43/0x4c
 [<c01d1274>] poke_blanked_console+0x64/0x68
 [<c01d082c>] vt_console_print+0x2bc/0x2d0
 [<c011fba4>] __call_console_drivers+0x3c/0x4c
 [<c011fc0c>] _call_console_drivers+0x58/0x60
 [<c011fcf2>] call_console_drivers+0xde/0xe8
 [<c0260c7b>] error_code+0x2f/0x38
 [<c011dce4>] mm_release+0x34/0x78
 [<c0121805>] do_exit+0xc1/0x330
 [<c010af3c>] do_divide_error+0x0/0xac
 [<c011855a>] do_page_fault+0x382/0x540
 [<c01181d8>] do_page_fault+0x0/0x540
 [<c012682f>] mod_timer+0x43/0x4c
 [<c01d1274>] poke_blanked_console+0x64/0x68
 [<c01d082c>] vt_console_print+0x2bc/0x2d0
 [<c011fba4>] __call_console_drivers+0x3c/0x4c
 [<c011fc0c>] _call_console_drivers+0x58/0x60
 [<c011fcf2>] call_console_drivers+0xde/0xe8
 [<c0260c7b>] error_code+0x2f/0x38
 [<c011dce4>] mm_release+0x34/0x78
 [<c0121805>] do_exit+0xc1/0x330
 [<c010af3c>] do_divide_error+0x0/0xac
 [<c011855a>] do_page_fault+0x382/0x540
 [<c01181d8>] do_page_fault+0x0/0x540
 [<c012682f>] mod_timer+0x43/0x4c
 [<c01d1274>] poke_blanked_console+0x64/0x68
 [<c01d082c>] vt_console_print+0x2bc/0x2d0
 [<c011fba4>] __call_console_drivers+0x3c/0x4c
 [<c011fc0c>] _call_console_drivers+0x58/0x60
 [<c011fcf2>] call_console_drivers+0xde/0xe8
 [<c0260c7b>] error_code+0x2f/0x38
 [<c011dce4>] mm_release+0x34/0x78
 [<c0121805>] do_exit+0xc1/0x330
 [<c010af3c>] do_divide_error+0x0/0xac
 [<c011855a>] do_page_fault+0x382/0x540
 [<c01181d8>] do_page_fault+0x0/0x540
 [<c012682f>] mod_timer+0x43/0x4c
 [<c01d1274>] poke_blanked_console+0x64/0x68
 [<c01d082c>] vt_console_print+0x2bc/0x2d0
 [<c011fba4>] __call_console_drivers+0x3c/0x4c
 [<c011fc0c>] _call_console_drivers+0x58/0x60
 [<c011fcf2>] call_console_drivers+0xde/0xe8
 [<c0260c7b>] error_code+0x2f/0x38
 [<c011dce4>] mm_release+0x34/0x78
 [<c0121805>] do_exit+0xc1/0x330
 [<c010af3c>] do_divide_error+0x0/0xac
 [<c011855a>] do_page_fault+0x382/0x540
 [<c01181d8>] do_page_fault+0x0/0x540
 [<c012682f>] mod_timer+0x43/0x4c
 [<c01d1274>] poke_blanked_console+0x64/0x68
 [<c01d082c>] vt_console_print+0x2bc/0x2d0
 [<c011fba4>] __call_console_drivers+0x3c/0x4c
 [<c011fc0c>] _call_console_drivers+0x58/0x60
 [<c011fcf2>] call_console_drivers+0xde/0xe8
 [<c0260c7b>] error_code+0x2f/0x38
 [<c011dce4>] mm_release+0x34/0x78
 [<c0121805>] do_exit+0xc1/0x330
 [<c010af3c>] do_divide_error+0x0/0xac
 [<c011855a>] do_page_fault+0x382/0x540
 [<c01181d8>] do_page_fault+0x0/0x540
 [<c012682f>] mod_timer+0x43/0x4c
 [<c01d1274>] poke_blanked_console+0x64/0x68
 [<c01d082c>] vt_console_print+0x2bc/0x2d0
 [<c011fba4>] __call_console_drivers+0x3c/0x4c
 [<c011fc0c>] _call_console_drivers+0x58/0x60
 [<c011fcf2>] call_console_drivers+0xde/0xe8
 [<c0260c7b>] error_code+0x2f/0x38
 [<c011dce4>] mm_release+0x34/0x78
 [<c0121805>] do_exit+0xc1/0x330
 [<c010af3c>] do_divide_error+0x0/0xac
 [<c011855a>] do_page_fault+0x382/0x540
 [<c01181d8>] do_page_fault+0x0/0x540
 [<c012682f>] mod_timer+0x43/0x4c
 [<c01d1274>] poke_blanked_console+0x64/0x68
 [<c01d082c>] vt_console_print+0x2bc/0x2d0
 [<c011fba4>] __call_console_drivers+0x3c/0x4c
 [<c011fc0c>] _call_console_drivers+0x58/0x60
 [<c011fcf2>] call_console_drivers+0xde/0xe8
 [<c0260c7b>] error_code+0x2f/0x38
 [<c011dce4>] mm_release+0x34/0x78
 [<c0121805>] do_exit+0xc1/0x330
 [<c010af3c>] do_divide_error+0x0/0xac
 [<c011855a>] do_page_fault+0x382/0x540
 [<c01181d8>] do_page_fault+0x0/0x540
 [<c012682f>] mod_timer+0x43/0x4c
 [<c01d1274>] poke_blanked_console+0x64/0x68
 [<c01d082c>] vt_console_print+0x2bc/0x2d0
 [<c011fba4>] __call_console_drivers+0x3c/0x4c
 [<c011fc0c>] _call_console_drivers+0x58/0x60
 [<c011fcf2>] call_console_drivers+0xde/0xe8
 [<c0260c7b>] error_code+0x2f/0x38
 [<c010b138>] do_invalid_op+0x0/0x8c
 [<c011dce4>] mm_release+0x34/0x78
 [<c0121805>] do_exit+0xc1/0x330
 [<c010b138>] do_invalid_op+0x0/0x8c
 [<c010af3c>] do_divide_error+0x0/0xac
 [<c010b1ba>] do_invalid_op+0x82/0x8c
 [<c0115242>] flush_tlb_others+0x22/0xd0
 [<c014cbd2>] free_page_and_swap_cache+0x52/0x54
 [<c014172c>] zap_pte_range+0x228/0x2c4
 [<c014181d>] zap_pmd_range+0x55/0x70
 [<c0138a37>] free_hot_page+0x7/0x8
 [<c013d567>] __page_cache_release+0x87/0x8c
 [<c0260c7b>] error_code+0x2f/0x38
 [<c0115242>] flush_tlb_others+0x22/0xd0
 [<c0115366>] flush_tlb_mm+0x76/0x7c
 [<c0145adb>] exit_mmap+0x11f/0x1cc
 [<c011dc64>] mmput+0x50/0x70
 [<c01218fd>] do_exit+0x1b9/0x330
 [<c012bb3a>] sys_reboot+0x1f2/0x2f8
 [<c0119f28>] wake_up_state+0xc/0x10
 [<c0128a47>] kill_proc_info+0x37/0x4c
 [<c0128b40>] kill_something_info+0xe4/0xec
 [<c012a7dc>] sys_kill+0x54/0x5c
 [<c0150373>] filp_open+0x3b/0x5c
 [<c0150739>] sys_open+0x59/0x74
 [<c0260c7b>] error_code+0x2f/0x38
 [<c026020f>] syscall_call+0x7/0xb

Code: 7c 01 00 00 8e e0 8e e8 85 d2 74 11 c7 83 7c 01 00 00 00 00 00 00 89 d0 e8 ca e1 ff ff 8b 8b 84 01 00 00 85 c9 74 45 8b 44 24 0c <8b> 40 14 83 f8 01 7e 39 c7 83 84 01 00 00 00 00 00 00 b8 00 e0 

