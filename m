Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263586AbTEEQTb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbTEEQTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:19:30 -0400
Received: from franka.aracnet.com ([216.99.193.44]:59831 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262567AbTEEQTI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:19:08 -0400
Date: Mon, 05 May 2003 09:31:03 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 647] New: sym53c8xx module doesn't load
Message-ID: <9490000.1052152263@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=647

           Summary: sym53c8xx module doesn't load
    Kernel Version: 2.5.68
            Status: NEW
          Severity: blocking
             Owner: andmike@us.ibm.com
         Submitter: s.rivoir@gts.it


Distribution: debian unstable 
Hardware Environment: SCSI adapter LSI Logic / Symbios Logic 53c875 (rev
01)  Software Environment: kernel 2.5.68 Linus tree 
Problem Description: SCSI Host module not loading 
 
module sym53c8xx oopses when trying to modprobe. This is the call trace: 
 
sym53c8xx: at PCI bus 0, device 8, function 0 
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up) 
sym53c8xx: 53c875 detected with Tekram NVRAM 
sym53c875-0: rev 0x1 on pci bus 0 device 8 function 0 irq 10 
ERROR: SCSI host `sym53c8xx' has no error handling 
ERROR: This is not a safe way to run your SCSI host 
ERROR: The error handling must be added to this driver 
Call Trace: 
[<d0885f42>] scsi_register+0x2d2/0x2e0 [scsi_mod] 
[<d088e3c0>] +0x1e0/0xbc8 [scsi_mod] 
[<d096dbd5>] +0x18d/0x754 [sym53c8xx] 
[printk+285/384] printk+0x11d/0x180 
[<d096c6c4>] +0x284/0x1608 [sym53c8xx] 
[unmap_area_pmd+75/96] unmap_area_pmd+0x4b/0x60 
[<d0939ef6>] ncr_attach+0x76/0xa10 [sym53c8xx] 
[<d096ff40>] driver_template+0x0/0x80 [sym53c8xx] 
[<d093b4cd>] sym53c8xx_detect+0x29d/0x390 [sym53c8xx] 
[<d096ff40>] driver_template+0x0/0x80 [sym53c8xx] 
[<d096dafa>] +0xb2/0x754 [sym53c8xx] 
[__alloc_pages+146/704] __alloc_pages+0x92/0x2c0 
[do_anonymous_page+332/608] do_anonymous_page+0x14c/0x260 
[handle_mm_fault+222/384] handle_mm_fault+0xde/0x180 
[do_page_fault+572/1111] do_page_fault+0x23c/0x457 
[update_process_times+70/96] update_process_times+0x46/0x60 
[update_wall_time+11/64] update_wall_time+0xb/0x40 
[do_timer+233/240] do_timer+0xe9/0xf0 
[buffered_rmqueue+177/336] buffered_rmqueue+0xb1/0x150 
[do_page_fault+0/1111] do_page_fault+0x0/0x457 
[error_code+45/56] error_code+0x2d/0x38 
[<d0884a10>] scsi_adjust_queue_depth+0x0/0xe0 [scsi_mod] 
[<d096ffc0>] +0x0/0x140 [sym53c8xx] 
[common_interrupt+24/32] common_interrupt+0x18/0x20 
[<d0884a10>] scsi_adjust_queue_depth+0x0/0xe0 [scsi_mod] 
[<d0893fc0>] +0x0/0x140 [scsi_mod] 
[<d096ffc0>] +0x0/0x140 [sym53c8xx] 
[unmap_area_pmd+75/96] unmap_area_pmd+0x4b/0x60 
[<d0964000>] +0x0/0xb0 [sym53c8xx] 
[unmap_vm_area+55/128] unmap_vm_area+0x37/0x80 
[<d096ffc0>] +0x0/0x140 [sym53c8xx] 
[vfree+39/64] vfree+0x27/0x40 
[load_module+1857/2304] load_module+0x741/0x900 
[<d0970100>] +0x0/0x80 [sym53c8xx] 
[<d096f0b8>] +0x0/0xcc8 [sym53c8xx] 
[<d0939000>] +0x0/0x20 [sym53c8xx] 
[<d096ffc0>] +0x0/0x140 [sym53c8xx] 
[<d096ff40>] driver_template+0x0/0x80 [sym53c8xx] 
[<d096ffc0>] +0x0/0x140 [sym53c8xx] 
[<d0885f70>] scsi_register_host+0x20/0xc0 [scsi_mod] 
[<d096ff40>] driver_template+0x0/0x80 [sym53c8xx] 
[<d093c7f9>] init_this_scsi_driver+0x19/0x3b [sym53c8xx] 
[<d096ff40>] driver_template+0x0/0x80 [sym53c8xx] 
[sys_init_module+303/480] sys_init_module+0x12f/0x1e0 
[<d096ffc0>] +0x0/0x140 [sym53c8xx] 
[syscall_call+7/11] syscall_call+0x7/0xb 
 
sym53c875-0: Tekram format NVRAM, ID 1, Fast-20, Parity Checking 
scsi0 : sym53c8xx-1.7.3c-20010512

