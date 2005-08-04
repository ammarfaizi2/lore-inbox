Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbVHDMpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbVHDMpG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 08:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVHDMm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 08:42:59 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.249]:17388 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262509AbVHDMlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 08:41:16 -0400
Message-ID: <42F20CEC.60206@anagramm.de>
Date: Thu, 04 Aug 2005 14:41:16 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML List <linux-kernel@vger.kernel.org>
Subject: How to get the physical page addresses from a kernel virtual address
 for DMA SG List?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This might be an FAQ - I've got several ideas from googling
around for days and reading 'Linux Device Drivers' or
'Understanding The Linux Kernel' which are both really good
books. However I am not really sure of how to do it on the latest
linux-2.6.

I am currently working on a dma driver for a ppc32 system.
The idea is that a userspace app allocates a big contigous
chunk of memory (i.e. 400MBytes, user virtual mem) and tells
my dma's char driver via ioctl the pointer to that memory.

In the driver I can now use that (void __user *) casted address
as a kernel virtual address, right? It's contigous there and I can
do a memcpy() to get data to userspace simliar to a copy_to_user().
fine!

But I want to setup a scatter/gather DMA list and blow my data
directly into the applications physical pages.

What's the best way to setup the dma_sg_list?
I have checked several things to get the pages and physical addresses
but with no real success now:
get_user_page()
vmalloc_to_page()
kvirt_to_bus() (deprecated?)
virt_to_phys()
virt_to_bus()

Or do I need to remap the whole thing before I can get all the pages and
physical addresses?
remap_page_range()
remap_pfn_range()
map_user_kiobuf()
unmap_kiobuf()

Or do I need the direct-io stuff or the block-io?
How do I need to alloc the mem in my app? (get_pages()?)
How do I need to lock the memory to make sure it's in phys memory? (mlockall()?)
Can somebody please put some light on what's _the_ way to do that on the
latest 2.6 kernels? I am pretty much confused which functions are current
and okay to use to solve my problem.
Pointers to some code is also very welcome. But it should be _current_.
I've spent already a lot of time reading outdated things. :-(

Best regards,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
