Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTIAFDJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 01:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262595AbTIAFDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 01:03:09 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:32905 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262591AbTIAFDG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 01:03:06 -0400
Date: Mon, 1 Sep 2003 06:03:04 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030901050304.GD748@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk.suse.lists.linux.kernel> <p733cfkpvp8.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p733cfkpvp8.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> > I already got a surprise (to me): my Athlon MP is much slower
> > accessing multiple mappings which are within 32k of each other, than
> > mappings which are further apart, although it is coherent.  The L1
> 
> Most x86 and probably most other modern CPUs have virtually
> addressed L1 caches.  It's just too slow to wait for the MMU for an
> L1 access which is really critical.
> 
> So such artifacts are expected

I hadn't thought at first because there's no artefact at all (not even
a small one) on my Celeron, but you're right.  They don't appear on
any Intels(*), but they do on all AMDs that I have results for.

(*) With the possible exception of one P4 that reports varying results.

> 
> > data cache is 64k.  (The explanation is easy: virtually indexed,
> > physically tagged cache moves data among cache lines, possibly via L2).
> 
> On x86 L2 is usually physically tagged.

I'm speculating that L1 is physically tagged, and when there's a
virtual alias the CPU moves data from one L1 line to another.  L2 only
comes into it because the line transfer is slow enough that a
MESI-style transfer through L2 (as if another CPU or device requested
the line) would account for the slowness.

-- Jamie
