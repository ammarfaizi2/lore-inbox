Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266216AbUH0PnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266216AbUH0PnH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 11:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUH0Pmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 11:42:51 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:56265 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S266240AbUH0PmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 11:42:15 -0400
Message-ID: <412F5650.3050003@nortelnetworks.com>
Date: Fri, 27 Aug 2004 11:42:08 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: help with cleanup of pages mapped to userspace
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I would like to have a page of memory accessable from both kernel space and 
userspace.  Ideally it would be nice to have the page allocated from the kernel 
address space so as to be able to use pte_offset_kernel() rather than 
pte_offset_map().

It has been suggested that we could do something like:


mypage =  __get_free_page(GFP_KERNEL);
SetPageReserved(virt_to_page(mypage));
remap_page_range(vma->vm_start, virt_to_phys((void *) mypage), PAGE_SIZE, 
vma->vm_page_prot);

When the task dies, how much cleanup will be done on the page?  Does the memory 
subsystem handle everything, or do I need to explicitly do something like:

reservedClearPageReserved(virt_to_page(mypage));
free_page(mypage);

Is there a better way of doing this?  I had considered mmap(), but I think that 
could give me pages with their page tables up in high memory, necessitating the 
use of pte_offset_map().


Thanks,

Chris
