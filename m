Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132567AbREHOZ6>; Tue, 8 May 2001 10:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132571AbREHOZs>; Tue, 8 May 2001 10:25:48 -0400
Received: from comverse-in.com ([38.150.222.2]:61894 "EHLO
	eagle.comverse-in.com") by vger.kernel.org with ESMTP
	id <S132567AbREHOZm>; Tue, 8 May 2001 10:25:42 -0400
Message-ID: <6B1DF6EEBA51D31182F200902740436802678EA2@mail-in.comverse-in.com>
From: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
To: linux-kernel@vger.kernel.org
Subject: kmalloc(..., GFP_ATOMIC) buffers contiguous - hence suitable for 
	PCI DMA?
Date: Tue, 8 May 2001 10:24:58 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="koi8-r"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks!

(I have looked up in the archive the linux-kernel threads for kwds 
"DMA, contiguous, address" before writing this mail, and read the 
corresponding threads.)

I am trying to port some driver to Linux2.4/i386. I have just read 
the "Linux device drivers" book by A.Rubini, and this is what he 
says there in Ch.13 "Mmap & DMA", on the GFP_DMA allocator flag:

"The kernel guarantees that DMA-capable buffers have 2 features. 
1st, the phys. addrs must be conseccutive when get_free_page() 
returns > 1 page (but this is always true, indep. of GFP_DMA, 
because the kernel arranges free memory in clusters of consecutive pages).
And second, when GFP_DMA is set, the kernel guarantees that only addrs lower
than MAX_DMA_ADDRESS are returned. The macro MAX_DMA_ADDRESS is set to 16MB
on the PC, to deal with the 
ISA [...].

As far as PCI is concerned, there's no MAX_DMA_ADDRESS limit, 
and a PCI dev. driver should avoid setting GFP_DMA when 
allocating its buffers."

Is this really still true at kernels 2.2 and on? (The book 
refers to 2.1.43 as to the most modern version as of the time 
of its writing) I.e., can I just assume a buffer which I know 
to have been successfully allocated with just a 
kmalloc(..., GFP_ATOMIC) 
will be physically contiguous and hence suitable for PCI DMA?

I tried to understand the corresponding code path in mm/slab.c, 
but failed to come up with a 100%-assuring opinion out of it.

The driver and the device at present are not oriented for 
doing scatter-gather.

TIA for any possible help,
	Vassilii
