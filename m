Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267303AbUHSTko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267303AbUHSTko (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 15:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267313AbUHSTko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 15:40:44 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:34979 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267303AbUHSTkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 15:40:35 -0400
From: jmerkey@comcast.net
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: 2.6.8 kmem_cache_alloc barfs
Date: Thu, 19 Aug 2004 19:40:23 +0000
Message-Id: <081920041940.21770.41250226000ADB920000550A2200735446970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jul 16 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,

Here you go....

#define MAX_BUFFER_SIZE 0x10000
                                                                                
                                                                                
NOTE:  This code barfs in kmalloc while allocating 64KB blocks.  I
allocate a large number of these blocks from this routine.  2.6.4,2.6.7,
and 2.6.8 all crash in kmem_cache_alloc when kmalloc gets called and
I have exceeded the 1GB memory space in the kernel.  I am using 2.4.20
kernels with the userspace/kernelspace patch that allows the
kernel page space to be increased from 1GB to 3GB to allow me
to allocate 2.5 GB of memory in the kernel.  I am not using
this patch at present, but was testing 2.6.8 to see if it returned
proper failure states when large amounts of memory were allocated
and kernel memory was exhausted.
                                                                                
Jeff

   for (i = 0; i < (32 * 2048); i++)
    {
       buffer = kmalloc(MAX_BUFFER_SIZE, GFP_KERNEL);
       if (!buffer)
       {
          P_Print("could not allocate data buffer (%d bytes)\n",
                  MAX_BUFFER_SIZE);
          break;
       }
       P_Set(buffer, 0, MAX_BUFFER_SIZE);
    }
                                                                                
Pretty easy to make it fail.

Jeff

                                                                                


> On Thu, Aug 19, 2004 at 06:18:20PM +0000, jmerkey@comcast.net wrote:
> > 
> > in 2.6.8 with all features and config options (at least those that will build) 
> with 4GB memory option selected, kmem_cache_alloc crashes when called with 
> requests for 64KB chunks of memory which exceed the kernel address space of 1GB 
> in size rather than returning an out of memory error.  
> 
> testcase please.
> 
