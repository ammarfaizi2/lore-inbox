Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbUBJXiN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 18:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbUBJXiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 18:38:12 -0500
Received: from mail.siemenscom.com ([12.146.131.10]:23776 "EHLO
	mail.siemenscom.com") by vger.kernel.org with ESMTP id S262838AbUBJXiK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 18:38:10 -0500
Message-ID: <7A25937D23A1E64C8E93CB4A50509C2A0310F0A7@stca204a.bus.sc.rolm.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: linux-kernel@vger.kernel.org
Subject: 
Date: Tue, 10 Feb 2004 15:36:43 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a system with 2GB of memory. One of my processes calls mmap to try to
map a 100MB file into memory. This calls fails with -ENOMEM. I rebuilt the
kernel with a few debug printk statements in mmap.c to see where the failure
was occurring it occurred in the function arch_get_unmapped_area. the code
is as follows:

for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
		/* At this point:  (!vma || addr < vma->vm_end). */
		unsigned long __heap_stack_gap;
		if (TASK_SIZE - len < addr)
                { 
                        printk("%d TASK SIZE - LEN LESS THAN
ADDR\n",__LINE__);
			return -ENOMEM;
                } 
		if (!found_hole && (!vma || addr < vma->vm_start)) {
			mm->free_area_cache = addr;
			found_hole = 1;
		}
		if (!vma)
			return addr;
		__heap_stack_gap = 0;
		if (vma->vm_flags & VM_GROWSDOWN)
			__heap_stack_gap = heap_stack_gap << PAGE_SHIFT;
		if (addr + len + __heap_stack_gap <= vma->vm_start)
			return addr;
		addr = vma->vm_end;
	}

The printk is mine. What exactly is meant by the fact that TASK_SIZE - len <
addr?

Regards,


Jack Bloch 
Siemens ICN
phone                (561) 923-6550
e-mail                jack.bloch@icn.siemens.com

