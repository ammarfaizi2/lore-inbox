Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314612AbSEBQKU>; Thu, 2 May 2002 12:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314611AbSEBQKT>; Thu, 2 May 2002 12:10:19 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:49062 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S314607AbSEBQKR>; Thu, 2 May 2002 12:10:17 -0400
Date: Thu, 02 May 2002 09:10:00 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>,
        Daniel Phillips <phillips@bonn-fries.net>
cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <3972036796.1020330599@[10.10.2.3]>
In-Reply-To: <20020502180632.I11414@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You can trivially map the phys mem between 1G and 1G+256M to be in a
> direct mapping between 3G+256M and 3G+512M, then you can put such 256M
> at offset 1G into the ZONE_NORMAL of node-id 1 with discontigmem too.
> 
> The constraints you have on the normal memory are only two:
> 
> 1) direct mapping
> 2) DMA
> 
> so as far as the ram is capable of 32bit DMA with pci32 and it's mapped
> in the direct mapping you can put it into the normal zone. There is no
> difference at all between discontimem or nonlinear in this sense.

Now imagine an 8 node system, with 4Gb of memory in each node.
First 4Gb is in node 0, second 4Gb is in node 1, etc.

Even with 64 bit DMA, the real problem is breaking the assumption
that mem between 0 and 896Mb phys maps 1-1 onto kernel space.
That's 90% of the difficulty of what Dan's doing anyway, as I
see it.

M.

