Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTJWTHM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 15:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbTJWTHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 15:07:12 -0400
Received: from as6-4-8.rny.s.bonet.se ([217.215.27.171]:18447 "EHLO
	pc2.dolda2000.com") by vger.kernel.org with ESMTP id S261670AbTJWTG5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 15:06:57 -0400
From: Fredrik Tolf <fredrik@dolda2000.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16280.9893.292564.320412@pc7.dolda2000.com>
Date: Thu, 23 Oct 2003 21:06:13 +0200
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Fredrik Tolf <fredrik@dolda2000.com>, linux-kernel@vger.kernel.org
Subject: Re: Elevator bug in concert with usb-storage
In-Reply-To: <20031023082726.A20073@beaverton.ibm.com>
References: <16279.15393.575929.983297@pc7.dolda2000.com>
	<20031023082726.A20073@beaverton.ibm.com>
X-Mailer: VM 7.17 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mansfield writes:
 > On Thu, Oct 23, 2003 at 04:25:37AM +0200, Fredrik Tolf wrote:
 > > Hello,
 > > 
 > > I believe that there is a bug in the usb-storage code. I'm using
 > > 2.6.0-test8-mm1, but I have experienced this in essentially all
 > > 2.6.0-test* kernels. Mostly anytime when I remove a usb-storage device
 > > (especially before umounting it), I get a SEGV followed by general
 > > unstability in the SCSI subsys.
 > 
 > Try Mike's patch:
 > 
 > http://marc.theaimsgroup.com/?l=linux-scsi&m=106646263401437&w=2

Sorry, that didn't work well. It doesn't crash on the same thing
anymore, but nonetheless crashes. In addition, when I have removed the
device but not yet umounted the filesystem, I tried to ls its root
dir. Before, nothing extraordinary happened then, but now there's a
couple of oopses for the ls process as well.

The dmesg output since the device removal follows. I'm sorry for
filling up your mboxes; please tell me if this is unacceptable
behavior.

Fredrik Tolf

---

usb 3-1: USB disconnect, address 2
releasing anticipatory io scheduler
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
00000004
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<00000004>]    Not tainted VLI
EFLAGS: 00010002
EIP is at 0x4
eax: dea9c800   ebx: 00000001   ecx: dea9c800   edx: df9749c0
esi: dea9c800   edi: 00000000   ebp: d9bedc0c   esp: d9bedc04
ds: 007b   es: 007b   ss: 0068
Process ls (pid: 1277, threadinfo=d9bec000 task=dc2440c0)
Stack: c02176b3 dea9c800 d9bedc40 c0219ab4 dea9c800 00000041 00000000 00000000 
       00000001 00000000 00000000 c1702620 00000000 dea9c800 db8e8dc0 d9bedc94 
       c021a016 dea9c800 db8e8dc0 0003cfd0 00000000 dea9c800 00000041 00000000 
Call Trace:
 [<c02176b3>] elv_queue_empty+0x1d/0x20
 [<c0219ab4>] __make_request+0x80/0x4ae
 [<c021a016>] generic_make_request+0x134/0x186
 [<c01534a7>] submit_bh+0x97/0x1e6
 [<c021a09d>] submit_bio+0x35/0x60
 [<c0151659>] __bread_slow_wq+0x4b/0xdc
 [<c0151952>] __bread+0x2c/0x32
 [<e08949e8>] fat__get_entry+0x9e/0x16e [fat]
 [<e08913be>] fat_readdirx+0xdc0/0xe86 [fat]
 [<c01868c3>] ext3_do_update_inode+0x19f/0x36c
 [<c018a5d7>] __ext3_journal_stop+0x1b/0x3c
 [<c013638e>] find_get_page+0x1e/0x44
 [<c015178f>] bh_lru_install+0xa5/0xdc
 [<c0191af8>] __journal_file_buffer+0x168/0x228
 [<c0191af8>] __journal_file_buffer+0x168/0x228
 [<c013638e>] find_get_page+0x1e/0x44
 [<c013732b>] filemap_nopage+0x1e7/0x2b6
 [<c0147240>] pte_chain_alloc+0x7a/0x7e
 [<c0143150>] do_no_page+0x17c/0x32e
 [<c0143485>] handle_mm_fault+0xa7/0x124
 [<c011b284>] do_page_fault+0x2de/0x4dd
 [<e08914a0>] fat_readdir+0x1c/0x1e [fat]
 [<c015f62c>] filldir64+0x0/0x10a
 [<c015f36d>] vfs_readdir+0x6d/0x72
 [<c015f62c>] filldir64+0x0/0x10a
 [<c015f798>] sys_getdents64+0x62/0x9d
 [<c015f62c>] filldir64+0x0/0x10a
 [<c02bafeb>] syscall_call+0x7/0xb

Code:  Bad EIP value.
 <6>note: ls[1277] exited with preempt_count 2
bad: scheduling while atomic!
Call Trace:
 [<c011ce2e>] schedule+0x572/0x578
 [<c0141df4>] unmap_vmas+0x18e/0x1d2
 [<c0145534>] exit_mmap+0x60/0x164
 [<c011e6b3>] mmput+0x71/0xd4
 [<c01220be>] do_exit+0x130/0x3aa
 [<c010b305>] die+0xd3/0xd4
 [<c011b165>] do_page_fault+0x1bf/0x4dd
 [<c0139de7>] buffered_rmqueue+0xd3/0x16a
 [<c0139f16>] __alloc_pages+0x98/0x2d4
 [<c013cdb1>] cache_init_objs+0x4f/0x54
 [<c013cf6b>] cache_grow+0x185/0x29c
 [<c011afa6>] do_page_fault+0x0/0x4dd
 [<c02bb9f7>] error_code+0x2f/0x38
 [<c02176b3>] elv_queue_empty+0x1d/0x20
 [<c0219ab4>] __make_request+0x80/0x4ae
 [<c021a016>] generic_make_request+0x134/0x186
 [<c01534a7>] submit_bh+0x97/0x1e6
 [<c021a09d>] submit_bio+0x35/0x60
 [<c0151659>] __bread_slow_wq+0x4b/0xdc
 [<c0151952>] __bread+0x2c/0x32
 [<e08949e8>] fat__get_entry+0x9e/0x16e [fat]
 [<e08913be>] fat_readdirx+0xdc0/0xe86 [fat]
 [<c01868c3>] ext3_do_update_inode+0x19f/0x36c
 [<c018a5d7>] __ext3_journal_stop+0x1b/0x3c
 [<c013638e>] find_get_page+0x1e/0x44
 [<c015178f>] bh_lru_install+0xa5/0xdc
 [<c0191af8>] __journal_file_buffer+0x168/0x228
 [<c0191af8>] __journal_file_buffer+0x168/0x228
 [<c013638e>] find_get_page+0x1e/0x44
 [<c013732b>] filemap_nopage+0x1e7/0x2b6
 [<c0147240>] pte_chain_alloc+0x7a/0x7e
 [<c0143150>] do_no_page+0x17c/0x32e
 [<c0143485>] handle_mm_fault+0xa7/0x124
 [<c011b284>] do_page_fault+0x2de/0x4dd
 [<e08914a0>] fat_readdir+0x1c/0x1e [fat]
 [<c015f62c>] filldir64+0x0/0x10a
 [<c015f36d>] vfs_readdir+0x6d/0x72
 [<c015f62c>] filldir64+0x0/0x10a
 [<c015f798>] sys_getdents64+0x62/0x9d
 [<c015f62c>] filldir64+0x0/0x10a
 [<c02bafeb>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c011ce2e>] schedule+0x572/0x578
 [<c0141df4>] unmap_vmas+0x18e/0x1d2
 [<c0145534>] exit_mmap+0x60/0x164
 [<c011e6b3>] mmput+0x71/0xd4
 [<c01220be>] do_exit+0x130/0x3aa
 [<c010b305>] die+0xd3/0xd4
 [<c011b165>] do_page_fault+0x1bf/0x4dd
 [<c0139de7>] buffered_rmqueue+0xd3/0x16a
 [<c0139f16>] __alloc_pages+0x98/0x2d4
 [<c013cdb1>] cache_init_objs+0x4f/0x54
 [<c013cf6b>] cache_grow+0x185/0x29c
 [<c011afa6>] do_page_fault+0x0/0x4dd
 [<c02bb9f7>] error_code+0x2f/0x38
 [<c02176b3>] elv_queue_empty+0x1d/0x20
 [<c0219ab4>] __make_request+0x80/0x4ae
 [<c021a016>] generic_make_request+0x134/0x186
 [<c01534a7>] submit_bh+0x97/0x1e6
 [<c021a09d>] submit_bio+0x35/0x60
 [<c0151659>] __bread_slow_wq+0x4b/0xdc
 [<c0151952>] __bread+0x2c/0x32
 [<e08949e8>] fat__get_entry+0x9e/0x16e [fat]
 [<e08913be>] fat_readdirx+0xdc0/0xe86 [fat]
 [<c01868c3>] ext3_do_update_inode+0x19f/0x36c
 [<c018a5d7>] __ext3_journal_stop+0x1b/0x3c
 [<c013638e>] find_get_page+0x1e/0x44
 [<c015178f>] bh_lru_install+0xa5/0xdc
 [<c0191af8>] __journal_file_buffer+0x168/0x228
 [<c0191af8>] __journal_file_buffer+0x168/0x228
 [<c013638e>] find_get_page+0x1e/0x44
 [<c013732b>] filemap_nopage+0x1e7/0x2b6
 [<c0147240>] pte_chain_alloc+0x7a/0x7e
 [<c0143150>] do_no_page+0x17c/0x32e
 [<c0143485>] handle_mm_fault+0xa7/0x124
 [<c011b284>] do_page_fault+0x2de/0x4dd
 [<e08914a0>] fat_readdir+0x1c/0x1e [fat]
 [<c015f62c>] filldir64+0x0/0x10a
 [<c015f36d>] vfs_readdir+0x6d/0x72
 [<c015f62c>] filldir64+0x0/0x10a
 [<c015f798>] sys_getdents64+0x62/0x9d
 [<c015f62c>] filldir64+0x0/0x10a
 [<c02bafeb>] syscall_call+0x7/0xb

Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c011e194>] __might_sleep+0x94/0xb8
 [<c0143e42>] remove_shared_vm_struct+0x22/0x7a
 [<c01455da>] exit_mmap+0x106/0x164
 [<c011e6b3>] mmput+0x71/0xd4
 [<c01220be>] do_exit+0x130/0x3aa
 [<c010b305>] die+0xd3/0xd4
 [<c011b165>] do_page_fault+0x1bf/0x4dd
 [<c0139de7>] buffered_rmqueue+0xd3/0x16a
 [<c0139f16>] __alloc_pages+0x98/0x2d4
 [<c013cdb1>] cache_init_objs+0x4f/0x54
 [<c013cf6b>] cache_grow+0x185/0x29c
 [<c011afa6>] do_page_fault+0x0/0x4dd
 [<c02bb9f7>] error_code+0x2f/0x38
 [<c02176b3>] elv_queue_empty+0x1d/0x20
 [<c0219ab4>] __make_request+0x80/0x4ae
 [<c021a016>] generic_make_request+0x134/0x186
 [<c01534a7>] submit_bh+0x97/0x1e6
 [<c021a09d>] submit_bio+0x35/0x60
 [<c0151659>] __bread_slow_wq+0x4b/0xdc
 [<c0151952>] __bread+0x2c/0x32
 [<e08949e8>] fat__get_entry+0x9e/0x16e [fat]
 [<e08913be>] fat_readdirx+0xdc0/0xe86 [fat]
 [<c01868c3>] ext3_do_update_inode+0x19f/0x36c
 [<c018a5d7>] __ext3_journal_stop+0x1b/0x3c
 [<c013638e>] find_get_page+0x1e/0x44
 [<c015178f>] bh_lru_install+0xa5/0xdc
 [<c0191af8>] __journal_file_buffer+0x168/0x228
 [<c0191af8>] __journal_file_buffer+0x168/0x228
 [<c013638e>] find_get_page+0x1e/0x44
 [<c013732b>] filemap_nopage+0x1e7/0x2b6
 [<c0147240>] pte_chain_alloc+0x7a/0x7e
 [<c0143150>] do_no_page+0x17c/0x32e
 [<c0143485>] handle_mm_fault+0xa7/0x124
 [<c011b284>] do_page_fault+0x2de/0x4dd
 [<e08914a0>] fat_readdir+0x1c/0x1e [fat]
 [<c015f62c>] filldir64+0x0/0x10a
 [<c015f36d>] vfs_readdir+0x6d/0x72
 [<c015f62c>] filldir64+0x0/0x10a
 [<c015f798>] sys_getdents64+0x62/0x9d
 [<c015f62c>] filldir64+0x0/0x10a
 [<c02bafeb>] syscall_call+0x7/0xb


