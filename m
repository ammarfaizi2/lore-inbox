Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbTIHARU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 20:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTIHART
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 20:17:19 -0400
Received: from web14901.mail.yahoo.com ([216.136.225.53]:44647 "HELO
	web14901.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261766AbTIHARR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 20:17:17 -0400
Message-ID: <20030908001716.78049.qmail@web14901.mail.yahoo.com>
Date: Sun, 7 Sep 2003 17:17:16 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Mapping large framebuffers into kernel space
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kronos@kronoz.cjb.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1062973512.19548.0.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> The kernel has 4Gb of virtual address space. Because of the way x86
> works it really wants to keep the user map, the view of main memory and 
> io mappings visible at once. For larger objects you have to use kmap and
> map them through a window (anyone remember they joys of EMS). On
> 64bit this of course all goes away
> 

On my system I have 1GB physical and 1GB swap. So there should always be some
open address space in the 1-4GB kernel address space. Would it be better to map
the framebuffer to 1-4GB when HIGHMEM is configured? Is there an ioremap() that
will map to high memory? Seems that this would be better than reserving 256MB
in the 0-1GB range and forcing 256MB of physical RAM into highmem.

The kernel DRM drivers map framebuffers up to 256MB in size into user space.
Could this be mapped as a single 256MB page instead of 64K 4KB ones?

We're working on the radeon drivers right now so I can try a few things out.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
