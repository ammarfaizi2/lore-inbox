Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUIJAI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUIJAI5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 20:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUIJAHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 20:07:03 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:24813 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S266901AbUIJABe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 20:01:34 -0400
Message-ID: <4140EEDA.2040909@nortelnetworks.com>
Date: Thu, 09 Sep 2004 18:01:30 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: having problems with remap_page_range() and virt_to_phys()
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to allocate a page of in-kernel memory and make it accessable to 
userspace and to late asm code where we don't have virtual memory enabled.

I'm running code essentially equivalent to the following, where "map_addr" is a 
virtual address passed in by userspace, and "vma" is the appropriate one for 
that address:


struct page *pg = alloc_page(GFP_KERNEL);
void *virt = page_address(pg);
unsigned long phys = virt_to_phys(virt)
remap_page_range(vma, map_addr, phys, PAGE_SIZE, vma->vm_page_prot)


The problem that I'm having is that after the call to remap_page_range, the 
result of

virt_to_phys(map_addr)

is not equal to "phys", and I assume it should be since its supposed to be 
pointing to the same physical page as "virt".

Anyone have any ideas?  I can't post the exact code right now since the machine 
is at work and hung (Oops.) but I could post it tomorrow if that is necessary.

I'm using 2.6.5 for ppc, if it makes any difference.

Thanks,

Chris
