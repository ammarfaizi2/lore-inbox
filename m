Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbVCIXFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVCIXFO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbVCIXCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:02:48 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:8925 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262506AbVCIWYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:24:13 -0500
Date: Wed, 9 Mar 2005 17:23:08 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Support for GEODE CPUs
Message-ID: <20050309222308.GB24873@csclub.uwaterloo.ca>
References: <200503081935.j28JZ433020124@hera.kernel.org> <1110387668.28860.205.camel@localhost.localdomain> <20050309173344.GD17865@csclub.uwaterloo.ca> <1110405563.3072.250.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110405563.3072.250.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 09:59:26PM +0000, Alan Cox wrote:
> If you build 486 it will still use the TSC because it is available (The
> PIT is buggy but the kernel knows about that anyway and handles it). 

Hmm, I thought that was the whole point of the different cpu type
choices in the kernel.  Then again the MTRR is still available with a
386 kernel on a newer cpu as far as I remember, so I guess I will try a
486 optimized kernel next.

> There are a few Geode tricks to know for performance
> 
> - Turn off the video

That is the plan long term, although the BIOS's serial console doesn't
seem to work well with grub at least on minicom.  I think switching to
lilo may help that.

> - If you can't turn it off use solid areas of colour to speed the system
> up (The hardware uses RLE encoding to reduce ram fetch bandwidth)
> - Remember the cache is only 16K (12K when running X11 as 4K is borrowed
> for the blitter)

Even more reason to keep the video off (I think it steals some system
ram when on as well).

> - The onboard audio is a software SB emulation on older GX. It burns
> CPU.

I have audio disabled since I have no need for it.

> Also avoid touching various legacy registers as much as possible, many
> cause BIOS traps in SMM emulation code. The list I have is NDA but you
> can use rdtsc/inb or outb/rdtsc to work out which 8)

Only PCI and LPC devices in use, so I don't think I will be poking any
legacy registers directly, although I have no idea if the kernel would
be poking any of them as part of running the drivers.  Hopefully not.

Thanks for the information.

Len Sorensen
