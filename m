Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbUB0LB6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 06:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbUB0LB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 06:01:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:39354 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261810AbUB0LAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 06:00:20 -0500
Subject: Re: how does one disable processor cache on memory allocated with
	get_free_pages?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ross Tyler <retyler@raytheon.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <403E1DF1.9060901@raytheon.com>
References: <403E1DF1.9060901@raytheon.com>
Content-Type: text/plain
Message-Id: <1077879093.22215.328.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 21:51:33 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-27 at 03:25, Ross Tyler wrote:
> Andrew,
> 
> Thank you for taking the time to reply. I really appreciate your help.
> 
> My understanding of ioremap_nocache is that it falls short of what I 
> need to do.
> It is appropriate for, say, mapping physical memory on a PCI device that 
> is marked prefetchable (and otherwise subject to caching when mapped 
> with ioremap) as non-caching.
> Can you confirm my understanding?

No, ioremap always maps non-cacheable, this has nothing to do with
the prefetching attribute

> If so, it will not work for me as I am not mapping physical memory but 
> memory allocated by get_free_pages.
> Do you concur?

get_free_pages() returns you physical memory...

> AFAIK, the only way to access this memory without using processor cache 
> is to have a device driver memory map it for a process like 
> drivers/char/mem.c does.
> When the memory is accessed through these memory mapped pages, the 
> access will not be cached.
> When the memory is accessed through the get_free_pages pages, the access 
> will be cached.
> Concur?

get_free_page allocates cacheable physical memory, nothing to do
with your PCI device... ioremap maps your device non-cacheable
into the kernel address space.
 
> In order to access this process mapped memory from outside the context 
> of the process it was mapped for, one either needs to independently 
> remap it for the current process (what to do in interrupt code?) or set 
> up a kiobuf to the memory.
> It has been my experience, however, that the pages referenced by the 
> kiobuf are the same pages returned by get_free_pages.
> I expect these same pages have the same (caching) attributes associated 
> with them which would not work.

What are you trying to do exactly ?

Ben.


