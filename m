Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263400AbTIGSVr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 14:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbTIGSVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 14:21:46 -0400
Received: from web14906.mail.yahoo.com ([216.136.225.58]:29282 "HELO
	web14906.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263400AbTIGSVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 14:21:45 -0400
Message-ID: <20030907182144.87346.qmail@web14906.mail.yahoo.com>
Date: Sun, 7 Sep 2003 11:21:44 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Mapping large framebuffers into kernel space
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kronos@kronoz.cjb.net
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got a new P4 machine with 1GB memory and I'm trying to make radeonfb
work on it.  I am compiled with HIGHMEM4G. The motherboard is i875P based which
supports 64b DMA.

When I first loaded radeonfb it would fail because ioremap was failing. I
tracked the problem down to not having any free kernel address space below 1GB.
I created some by adding reserve=FE000000-100000000 to the kernel command line.
 This allowed radeonfb to load.

I'm beginning to wonder if framebuffers should be mapped into kernel space. 
What's going to happen when I get a 512MB video card? Does the framebuffer have
to be mapped in the first 1GB of kernel address space?

If the framebuffer is mapped, it's a perfect candidate for a large page table
entry because it is a very large piece of linear memory that not's going to be paged.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
