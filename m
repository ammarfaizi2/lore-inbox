Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVF0AGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVF0AGt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 20:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVF0AGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 20:06:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34525 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261658AbVF0AGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 20:06:47 -0400
Date: Sun, 26 Jun 2005 15:31:02 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: increased translation cache footprint in v2.6
Message-ID: <20050626183102.GA6091@logos.cnet>
References: <20050626172334.GA5786@logos.cnet> <17087.15740.442831.617781@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17087.15740.442831.617781@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 09:42:52AM +1000, Paul Mackerras wrote:
> Marcelo Tosatti writes:
> 
> > We've noticed a slowdown while moving from v2.4 to v2.6 on a small PPC platform
> > (855T CPU running at 48Mhz, containing pair of separate I/D TLB caches with 
> > 32 entries each), with a relatively recent kernel (v2.6.11).
> > 
> > Test in question is a "dd" copying 16MB from /dev/zero to RAMDISK. 
> > 
> > Pinning an 8Mbyte TLB entry at KERNELBASE brought performance back to v2.4 levels.
> 
> Why are we not pinning a large TLB entry at KERNELBASE in 2.6?  Was
> that taken out to reduce the size of the tlb miss handler or
> something?

Paul,

There are buggy instances of tlbie() destroying the 8Mbyte TLB entry - 
this is going to be fixed soon (its MPC8xx specific...)

I worry about machines who can't pin and/or smaller number of TLB entries.

