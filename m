Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162876AbWLBJt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162876AbWLBJt4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 04:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162877AbWLBJt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 04:49:56 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:47370 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1162876AbWLBJtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 04:49:55 -0500
Date: Sat, 2 Dec 2006 09:49:29 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, David Miller <davem@davemloft.net>,
       nickpiggin@yahoo.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       anemo@mba.ocn.ne.jp, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com,
       James.Bottomley@SteelEye.com
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
Message-ID: <20061202094929.GA12294@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
	akpm@osdl.org, linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp,
	linux-arch@vger.kernel.org, schwidefsky@de.ibm.com,
	James.Bottomley@SteelEye.com
References: <Pine.LNX.4.64.0610201302090.3962@g5.osdl.org> <20061020214916.GA27810@linux-mips.org> <Pine.LNX.4.64.0610201500040.3962@g5.osdl.org> <20061020.152247.111203913.davem@davemloft.net> <20061020225118.GA30965@linux-mips.org> <Pine.LNX.4.64.0610201625190.3962@g5.osdl.org> <20061021000609.GA32701@linux-mips.org> <Pine.LNX.4.64.0610201733490.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610201733490.3962@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 05:38:32PM -0700, Linus Torvalds wrote:
> On Sat, 21 Oct 2006, Ralf Baechle wrote:
> > > That said, maybe nobody does that. Virtual caches are a total braindamage 
> > > in the first place, so hopefully they have limited use.
> > 
> > On MIPS we never had pure virtual caches.
> 
> Ok, so on MIPS my schenario doesn't matter.
> 
> I think (but may be mistaken) that ARM _does_ have pure virtual caches 
> with a process ID, but people have always ended up flushing them at 
> context switch simply because it just causes too much trouble.

Just read this, sorry.

The majority of ARM CPU implementations have pure virtual caches
_without_ process IDs.  (Some have a nasty hack which involves
remapping the lower 32MB of virtual memory space to other areas
of the cache's virtual space, but obviously that limits you to
32MB of VM.)

Thankfully, with ARM version 6, they had an inkling of clue, and
decided to move to VIPT caches but with _optional_ aliasing, and
if the CPU design was Harvard there's a possibility for D/I cache
aliasing.

> > Be sure I'm sending a CPU designers a strong message about aliases.
> 
> Castration. That's the best solution. We don't want those people 
> procreating.

Absolutely.  Can we start such a program in Cambridge, England ASAP
please?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
