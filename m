Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267755AbTAaKpz>; Fri, 31 Jan 2003 05:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267757AbTAaKpz>; Fri, 31 Jan 2003 05:45:55 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47121 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267755AbTAaKpz>; Fri, 31 Jan 2003 05:45:55 -0500
Date: Fri, 31 Jan 2003 10:55:18 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: vmalloc/module_alloc: unable to handle two memory regions
Message-ID: <20030131105518.B19646@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030131102013.A19646@flint.arm.linux.org.uk> <20030131024820.4c1290ca.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030131024820.4c1290ca.akpm@digeo.com>; from akpm@digeo.com on Fri, Jan 31, 2003 at 02:48:20AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2003 at 02:48:20AM -0800, Andrew Morton wrote:
> Boggle.
> 
> Isn't this totally abusing get_vma_area?
> 
> What stops an ioremap region from landing in module space?

Exactly the problem.

What's more is that fs/proc/kcore.c:get_kcore_size() also breaks, so
this isn't an acceptable solution.  get_kcore_size wants the module
region to be above PAGE_OFFSET.

In order to place the module in the normal vmalloc space, we end up with
a chicken and egg problem - we need to scan the module from kernel space
to find out how large to make the jump table, but we can't because the
module hasn't been loaded into kernel memory - this is the reason why it
was suggested to go down this route.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

