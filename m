Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVACX2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVACX2R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVACX1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:27:42 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38406 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261961AbVACX1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:27:07 -0500
Date: Mon, 3 Jan 2005 23:27:01 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PREWARN] ARM DMA API extension
Message-ID: <20050103232701.H3442@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I'm planning to push these changes to Linus imminently (iow, tomorrow)
- they were discussed back in March 2003 (or was it 2004?) on various
mailing lists and I think it's about time I threw them out of my private
tree into something more public, especially as some drivers depend on them.
You can review a copy of the diff at:

	http://www.arm.linux.org.uk/~rmk/misc/linus-dma.diff

Discussion ground to a halt on the exact nature of the API, so I've gone
with my proposed ideas back then.  I hope no one's going to complain.

Comments only at this stage please.

diffstat:

 arch/arm/mach-integrator/impd1.c         |   13 +++++++
 arch/arm/mach-integrator/integrator_cp.c |    9 ++++
 arch/arm/mach-versatile/core.c           |    9 ++++
 arch/arm/mm/consistent.c                 |   56 ++++++++++++++++++++++++++++++-
 drivers/video/amba-clcd.c                |   18 +++++++++
 drivers/video/pxafb.c                    |   15 ++++++++
 drivers/video/sa1100fb.c                 |   32 ++++++++++++++++-
 include/asm-arm/dma-mapping.h            |   19 ++++++++++
 include/asm-arm/hardware/amba_clcd.h     |    5 ++
 9 files changed, 173 insertions(+), 3 deletions(-)

ChangeSets:

<rmk@flint.arm.linux.org.uk> (05/01/02 1.2091)
	[ARM] Add DMA mmap support for SA1100/PXA framebuffer drivers.
	
	Since the framebuffers are allocated via dma_alloc_writecombine() we
	should use the DMA mmap interface to map these buffers.
	
	Signed-off-by: Russell King <rmk@arm.linux.org.uk>

<rmk@flint.arm.linux.org.uk> (04/12/31 1.2090)
	[ARM] Add CLCD driver mmap method and callbacks.
	
	Convert CLCD driver such that boards can use the dma_mmap_*()
	interfaces where appropriate.
	
	Signed-off-by: Russell King <rmk@arm.linux.org.uk>

<rmk@flint.arm.linux.org.uk> (04/12/30 1.2089)
	[ARM] Add DMA mmap() support.
	
	This adds DMA mmap() support for the ARM architecture, as discussed
	around March 2003 on the linux-arch and linux-kernel mailing lists.
	
	Subsystems such as ALSA (for sample ring buffers) and video drivers
	(for framebuffers in system memory) require this infrastructure to
	provide userspace with an architecture clean method to mmap these
	memory areas.
	
	Signed-off-by: Russell King <rmk@arm.linux.org.uk>


-- 
Russell King

