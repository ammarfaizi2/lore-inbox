Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTKTAVX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 19:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbTKTAVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 19:21:23 -0500
Received: from 217-124-4-129.dialup.nuria.telefonica-data.net ([217.124.4.129]:12928
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S261152AbTKTAVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 19:21:21 -0500
Date: Thu, 20 Nov 2003 01:21:19 +0100
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm4 (only) and vmware
Message-ID: <20031120002119.GA7875@localhost>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <20031119181518.0a43c673.vmlinuz386@yahoo.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031119181518.0a43c673.vmlinuz386@yahoo.com.ar>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 19 November 2003, at 18:15:18 -0300,
Gerardo Exequiel Pozzi wrote:

> With the recent 2.6.0-test9-mm4 i can't start the vmware, it reports in vmware.log (debug ON):
> 
I can confirm the problem here also with 2.6.0-test9-mm4, while
everything worked fine with 2.6.0-test9-mm3 with the same config.

I also realized while doing some basic tests that module "vmmon" was
unable to unload gracefully, and "has" to be forced to do so.

I can try to gather some more info when I come back from sleep + work.

PS: just in case it can help, VMware 4.0.1 5289 "patched" with (if I
recall correctly):
http://ftp.cvut.cz/vmware/vmware-any-any-update43.tar.gz

PS2: trying to "recompile" vmmon and vmnet again and starting VMware,
when tried to boot some guest OS I got the following in the logs:

kernel BUG at mm/memory.c:793!
invalid operand: 0000 [#5]
CPU:    0
EIP:    0060:[<c01425c7>]    Tainted: PF  VLI
EFLAGS: 00013212
EIP is at get_user_pages+0xe7/0x300
eax: 00001000   ebx: 406a0000   ecx: 00000000   edx: de7452c0
esi: d5966ec0   edi: 00000001   ebp: df8be940   esp: d052bcec
ds: 007b   es: 007b   ss: 0068
Process vmware-vmx (pid: 11300, threadinfo=d052a000 task=d9634cc0)
Stack: df8be940 d5966ec0 406a0000 00000001 00000002 00000000 00000000 d052a000 
       d052bd64 000406a0 d052bd44 e0b5012e d9634cc0 df8be940 406a0000 00000001 
       00000001 00000000 d052bd64 00000000 00000000 406a0000 d052bd74 e0b501a9 
Call Trace:
 [<e0b5012e>] HostIFGetUserPage+0x3a/0x66 [vmmon]
 [<e0b501a9>] HostIF_LockPage+0x4f/0x2a2 [vmmon]
 [<e0b52061>] Vmx86_LockPage+0x63/0xe0 [vmmon]
 [<e0b4ddb8>] __LinuxDriver_Ioctl+0x2f0/0x978 [vmmon]
 [<c013bcc8>] read_pages+0x1c8/0x1e0
 [<c018b460>] ext3_get_block+0x0/0xa0
 [<c013978f>] __alloc_pages+0xaf/0x350
 [<c013bf1e>] do_page_cache_readahead+0xbe/0x110
 [<c013964f>] buffered_rmqueue+0xaf/0x140
 [<c013978f>] __alloc_pages+0xaf/0x350
 [<e0b4d37c>] LinuxDriver_Open+0x7c/0x9e [vmmon]
 [<c0139a4f>] __get_free_pages+0x1f/0x50
 [<e0b5090d>] HostIF_AllocPage+0x11/0x32 [vmmon]
 [<e0b4d711>] LinuxDriverAllocLowMem+0x57/0xca [vmmon]
 [<c014494a>] __vma_link+0x3a/0xa0
 [<e0b4e4e5>] LinuxDriver_IoctlV4+0x4d/0xd2 [vmmon]
 [<c014524a>] do_mmap_pgoff+0x41a/0x6f0
 [<e0b4ee73>] LinuxDriver_Ioctl+0x131/0x1b8 [vmmon]
 [<c0162b85>] sys_ioctl+0xb5/0x230
 [<c0150770>] sys_close+0x50/0x60
 [<c02ad977>] syscall_call+0x7/0xb

Code: 00 85 c0 74 4b 85 c0 7e 2c 83 f8 01 75 0c 8b 44 24 30 ff 80 d8 01 00 00 eb bd 83 f8 02 75 0c 8b 54 24 30 ff 82 dc 01 00 00 eb ac <0f> 0b 19 03 d1 b6 2c c0 eb a2 40 75 f3 8b 5c 24 18 b8 f4 ff ff 

Greetings.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test9-mm4)
