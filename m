Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267609AbUHPNXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267609AbUHPNXq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 09:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267622AbUHPNXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 09:23:46 -0400
Received: from 64.89.71.154.nw.nuvox.net ([64.89.71.154]:5249 "EHLO
	gate.apago.com") by vger.kernel.org with ESMTP id S267609AbUHPNXm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 09:23:42 -0400
SMTP-Relay: dogwood.freil.com
Message-Id: <200408161323.i7GDNeod020199@dogwood.freil.com>
X-Mailer: exmh version 2.0.2 2/24/98
To: linux-kernel@vger.kernel.org
Subject: Re: Serious Kernel slowdown with HIMEM (4Gig) in 2.6.7
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 16 Aug 2004 09:23:40 -0400
From: "Lawrence E. Freil" <lef@freil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Iteresting idea, here is the /proc/mtrr output:

reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0x20000000 ( 512MB), size= 256MB: write-back, count=1
reg02: base=0x30000000 ( 768MB), size= 128MB: write-back, count=1
reg03: base=0x38000000 ( 896MB), size=  64MB: write-back, count=1
reg04: base=0x3c000000 ( 960MB), size=  32MB: write-back, count=1
reg05: base=0x3e000000 ( 992MB), size=  16MB: write-back, count=1
reg06: base=0xf0000000 (3840MB), size=   2MB: write-combining, count=1

The memory in question is the block from 896 to 1Gig.  Looks pretty
normal.

At this point I need to recompile "ls" with full profiling and time it
with and without extended memory.  I have a suspicion that it is related
to "mmap" on data in a high memory buffer.  It does not effect actual
file read/write.  Performance on that is pretty much the same.

>On Sat, Aug 14, 2004 at 12:43:11PM -0400, Lawrence E. Freil wrote:
>> Though there is a consistant sys component that is slightly higher.  I ran
>> profiles three times for "fast" and three times for "slow".  Here they are
>
>Try cat /proc/mtrr.  I bet your system isn't marking some of its RAM 
>cachable in the MTRRs.
>
>		-ben

-- 
        Lawrence Freil                      Email:lef@freil.com
        1768 Old Country Place              Phone:(770) 667-9274
        Woodstock, GA 30188


