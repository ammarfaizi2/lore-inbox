Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314287AbSEFIyU>; Mon, 6 May 2002 04:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314288AbSEFIyU>; Mon, 6 May 2002 04:54:20 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:43788 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S314287AbSEFIyS>; Mon, 6 May 2002 04:54:18 -0400
Date: Mon, 6 May 2002 10:54:06 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Andrea Arcangeli <andrea@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
In-Reply-To: <E174Vq8-0004BK-00@starship>
Message-ID: <Pine.LNX.4.21.0205061046180.23113-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 6 May 2002, Daniel Phillips wrote:

> I must be guilty of not explaining clearly.  Suppose you have the following
> physical memory map:
> 
> 	          0: 128 MB
> 	  8000,0000: 128 MB
> 	1,0000,0000: 128 MB
> 	1,8000,0000: 128 MB
> 	2,0000,0000: 128 MB
> 	2,8000,0000: 128 MB
> 	3,0000,0000: 128 MB
> 	3,8000,0000: 128 MB
> 
> The total is 1 GB of installed ram.  Yet the kernel's 1G virtual space,
> can only handle 128 MB of it.  The rest falls out of the addressable range and
> has to be handled as highmem, that is if you preserve the linear relationship
> between kernel virtual memory and physical memory, as config_discontigmem does.
> Even if you go to 2G of kernel memory (restricting user space to 2G of virtual)
> you can only handle 256 MB.

Why do you want to preserve the linear relationship between virtual and
physical memory? There is little common code (and only during
initialization), which assumes a direct mapping. I can send you the
patches to fix this. Then you can map as much physical memory as you want
into a single virtual area and you only need a single pgdat.

bye, Roman

