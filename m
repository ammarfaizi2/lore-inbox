Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbVLVRhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbVLVRhL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 12:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbVLVRhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 12:37:11 -0500
Received: from [206.124.142.26] ([206.124.142.26]:54998 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S1030234AbVLVRhJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 12:37:09 -0500
Date: Thu, 22 Dec 2005 09:37:04 -0800
From: Marc Singer <elf@buici.com>
To: Axel Kittenberger <axel.kernel@kittenberger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible Bootloader Optimization in inflate (get rid of unnecessary 32k Window)
Message-ID: <20051222173704.GB23411@buici.com>
References: <200512221352.23393.axel.kernel@kittenberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512221352.23393.axel.kernel@kittenberger.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 01:52:23PM +0100, Axel Kittenberger wrote:
> Hello, Whom do I talk to about acceptance of Patches in the Bootloader?
> 
> I have seen, and coded once some time ago for priv. uses, do infalte the 
> gziped linux kernel at boottime in "arch/i386/boot/compressed/misc.c" and " 
> windowlib/inflate.c" the deflation algorthimn uses a 32k backtrack window. 
> Whenever it is full, it copies it .... into the memory. 
> 
> While this window makes a lot of sense in an userspace application like 
> gunzip, it does not make a lot sense in the bootloader. As userspace 
> application the window is flushed to a file when full. The bootloader 
> "flushes" it to memory (copies it in memory). That 1 time copy of the whole 
> kernel can be optimized away, since we do not keep track of a window since 
> the inflater can read what it has written right in the computer memory, while 
> it unpacks the kernel.
> 
> What would the optimization be worth? 
> * A faster uncompressing of the kernel, since a total 1-time memcopy of the 
> whole kernel is been optimized away.

Have you timed this operation?  I would predict that the time to copy
the kernel is nominal as compared the the time taken to perform the
decompression.
