Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbREOJFb>; Tue, 15 May 2001 05:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262693AbREOJFV>; Tue, 15 May 2001 05:05:21 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:4113 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S262692AbREOJFL>;
	Tue, 15 May 2001 05:05:11 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: kraxel
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: mmap
Date: 15 May 2001 07:33:12 GMT
Organization: [x] network byte order
Message-ID: <slrn9g1mto.74g.kraxel@bytesex.org>
In-Reply-To: <CA256A4D.00256728.00@d73mta05.au.ibm.com>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Trace: bytesex.org 989911992 7324 127.0.0.1 (15 May 2001 07:33:12 GMT)
User-Agent: slrn/0.9.7.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mdaljeet@in.ibm.com wrote:
>  I am doing the following:
>  
>     malloc some memory is user space
>     pass its pointer to some kernel module
>     in the kernel module...do a pci_alloc_consistent so that i get a memory
>     region for PCI DMA operations

Wrong approach, you can use kiobufs if you want DMA to the malloc()ed
userspace memory:

 * lock down the user memory using map_user_kiobuf() + lock_kiovec()
   (see linux/iobuf.h).
 * translate the iobuf->maplist into a scatterlist [1]
 * feed pci_map_sg() with the scatterlist to get DMA addresses.
   you can pass to the hardware.

And the reverse to free everything when you are done of course.

  Gerd

[1] IMHO it would be more useful if iobufs would use a scatterlist
    instead of an struct page* array.


-- 
Gerd Knorr <kraxel@bytesex.org>  --  SuSE Labs, Auﬂenstelle Berlin
