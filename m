Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315535AbSEHXCI>; Wed, 8 May 2002 19:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315542AbSEHXCH>; Wed, 8 May 2002 19:02:07 -0400
Received: from ns1.affordablehost.com ([206.104.238.105]:38841 "HELO
	callisto.affordablehost.com") by vger.kernel.org with SMTP
	id <S315535AbSEHXCF>; Wed, 8 May 2002 19:02:05 -0400
Message-ID: <3CD9AE75.60105@keyed-upsoftware.com>
Date: Wed, 08 May 2002 18:02:13 -0500
From: David Stroupe <dstroupe@keyed-upsoftware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mmap issues
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-BlackHole: Version 0.9.75 by Chris Kennedy (C) 2002
X-BlackHole-Sender: (null)
X-BlackHole-Relay: 12.238.66.88
X-BlackHole-Match: No Match
X-BlackHole-Info: (null)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the driver is:
static int S_Mmap(struct file * flip, struct vm_area_struct *vma)
{
 
<snip>
  unsigned long size = (unsigned long)vma->vm_end - vma->vm_start; 
<------size = 2000 for this case
  unsigned long start = (unsigned long)vma->vm_start;

   vma->vm_flags |= VM_LOCKED;

 
  vaddy = kmalloc(size , GFP_KERNEL);
  strcpy((char*)vaddy, "testing\0");
  mem_map_reserve(virt_to_page(vaddy));
  result = remap_page_range(start, virt_to_phys(vaddy), size, 
vma->vm_page_prot);
   if (result)
        return -EAGAIN;
 return 0;
 
in user space is:
<snip>
  pdma->dwBytes = 2000;
  pdma->pUserAddr =  mmap(0, pdma->dwBytes, PROT_READ | PROT_WRITE, 
MAP_SHARED, hWd, 0);
  str = (char*)pdma->pUserAddr;
<snip)

when I try to view the memory that I just mmap()ed using gdb I see:
$12 = 0x40018000 <Address 0x40018000 out of bounds>

If I don't do the mem_map_reserve() command I can view the memory but it 
is all zeros.

What am I missing?

TIA

-- 
Best regards,
David Stroupe
Keyed-Up Software


