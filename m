Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263875AbUGFNkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUGFNkZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 09:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbUGFNkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 09:40:25 -0400
Received: from relay01a.clb.oleane.net ([213.56.31.145]:13958 "EHLO
	relay01a.clb.oleane.net") by vger.kernel.org with ESMTP
	id S263881AbUGFNkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 09:40:20 -0400
Message-ID: <40EAABC2.8060703@eve-team.com>
Date: Tue, 06 Jul 2004 15:40:18 +0200
From: Frederic Dumoulin <frederic_dumoulin@eve-team.com>
Organization: EVE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Frederic Dumoulin <frederic_dumoulin@eve-team.com>
Subject: PCI device driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got several questions about PCI device driver (some of them have
nothing to do with kernel, but one never knows, maybe somone can help
me or give me the address of the right mailing list):



1) In my driver, I allocate memory for the dma.

What are the difference between the following methods :
     * kmalloc (PAGE_SIZE, GFP_KERNEL | GFP_ATOMIC | GFP_DMA)
     * __get_dma_pages (GFP_KERNEL | GFP_ATOMIC | GFP_DMA, 1)
     * pci_alloc_consistent (pci_device, PAGE_SIZE, &buffer_phys)

On the performance point of view, is there any difference between
consistent and streaming DMA mappings?



2) I'd like to have information about the master write latency.

When I launch a master write access, I'm doing a software polling on
the PC memory in order to know when the data is present. I measure
this time with the RDTSC Pentium instruction and it give me about 1.3
us, with an oscilloscope I can see that the data "leave" the PCI after
only 0.550us!

Where is my data during those 0.7us?
How can I reduce this latency?

How can I use the function "ioremap_nocache"? (I can't see any difference with ioremap)



3) I'd like to have information about the use of the CACHE_LINE_SIZE
register.

When this register is used?
     only when using master write and invalidate commands
     or also in slave read / write accesses

I'm trying to increase the performance of my slave read accesses
I try to force the CACHE_LINE_SIZE register with
$ setpci -v -s 02:0a.0 CACHE_LINE_SIZE
02:0a.0:0c = 00
$ setpci -v -s 02:0a.0 CACHE_LINE_SIZE=10
02:0a.0:0c 10
$ setpci -v -s 02:0a.0 CACHE_LINE_SIZE
02:0a.0:0c = 00


I've got the same problem with the COMMAND register when I try to set
the FAST_BACK_TO_BACK bit, or the PREFETCH bit in the BASE_ADDRESS_0
register.


How can I overwrite the configuration set by the PCI board?
(I cannot configurate all the PCI registers in my IP)



4) I try to modify the Memory Type Range Register.

I use the /proc/mtrr system file :
$ echo "base=0xfd000000 size=0x01000000 type=write-combining" >>
/proc/mtrr
$ cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
reg01: base=0x10000000 ( 256MB), size= 128MB: write-back, count=1
reg02: base=0x18000000 ( 384MB), size=   1MB: write-back, count=1
reg03: base=0x18000000 ( 384MB), size=   1MB: uncachable, count=1
reg04: base=0xfd000000 (4048MB), size=  16MB: write-combining, count=1

If I re-do the same operation, count=2
What is the use of "count"? The speed doesn't seem to be increased if count = 1 or 2.

Which type is the best for simple memory slave read / write and master
write accesses?

I don't know how to have the longest burst as possible in slave read?




Thanks for your help

Best regards



Frederic
