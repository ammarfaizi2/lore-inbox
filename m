Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVCIWFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVCIWFu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 17:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVCIWFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:05:13 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:53131 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262144AbVCIWBd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:01:33 -0500
Subject: Re: [PATCH] Support for GEODE CPUs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050309173344.GD17865@csclub.uwaterloo.ca>
References: <200503081935.j28JZ433020124@hera.kernel.org>
	 <1110387668.28860.205.camel@localhost.localdomain>
	 <20050309173344.GD17865@csclub.uwaterloo.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110405563.3072.250.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 09 Mar 2005 21:59:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-03-09 at 17:33, Lennart Sorensen wrote:
> Now if the Geode GX1 in fact runs faster optimized for 486 rather than
> 586 (I have been running one as 586tsc since it had mmx and tsc in its
> feature list), then I think I will be recompiling my kernel to see if I
> can't make this 266MHz GX1 run almost as fast as a 400MHz PXA255 (arm).
> Right now it has somewhat lower ethernet bandwidth than the arm.

If you build 486 it will still use the TSC because it is available (The
PIT is buggy but the kernel knows about that anyway and handles it). 

There are a few Geode tricks to know for performance

- Turn off the video
- If you can't turn it off use solid areas of colour to speed the system
up (The hardware uses RLE encoding to reduce ram fetch bandwidth)
- Remember the cache is only 16K (12K when running X11 as 4K is borrowed
for the blitter)
- The onboard audio is a software SB emulation on older GX. It burns
CPU.

Also avoid touching various legacy registers as much as possible, many
cause BIOS traps in SMM emulation code. The list I have is NDA but you
can use rdtsc/inb or outb/rdtsc to work out which 8)

Alan

