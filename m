Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263889AbUCZAhb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263852AbUCZAgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:36:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:22664 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263874AbUCZAW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 19:22:26 -0500
Subject: Re: swsusp with highmem, testing wanted
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040325225946.GI2179@elf.ucw.cz>
References: <20040324235702.GA497@elf.ucw.cz>
	 <1080185300.1147.62.camel@gaston> <20040325120250.GC300@elf.ucw.cz>
	 <1080254461.1195.40.camel@gaston>  <20040325225946.GI2179@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1080260526.3068.15.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 26 Mar 2004 11:22:07 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-26 at 09:59, Pavel Machek wrote:
> Hi!
> 
> > > I'd need to do atomic copy. (Unless someone can guarantee that during
> > > writing to disk, no highmem page is going to be changed...)
> > > 
> > > "copy back" during resume is done in assembly, and I'd rather not
> > > dealed with highmem there.
> > 
> > Can you make that an option ? The PPC version runs in real mode and
> > can perfectly copy highmem pages (with small tweaks maybe)
> 
> What is real mode on PPC? I do not have PPC here, I guess you'd have
> to do that.

MMU OFF, access to entire physical memory. This will not work on
things like pSeries with hypervisor or iSeries, but I could deal with
that if/when needed. I know that x86 with more than 4Gb cannot access
the entire RAM in a linear way though, dunno what other facilities
you have outside of kmap then. But leave the door open to archs that
can do it ;)
 
> Yes, swsusp2 is faster. It is also 10x more code. We could probably
> stop freeing as soon as half of memory is free; OTOH if memory is
> disk cache, it might be faster to drop it than write to swap, then
> read back [swsusp2 shows its not usually the case, through].
> 								Pavel
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

