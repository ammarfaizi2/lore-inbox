Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992864AbWJTVtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992864AbWJTVtF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992792AbWJTVtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:49:02 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:42449 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S2992803AbWJTVs7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:48:59 -0400
Date: Fri, 20 Oct 2006 22:49:16 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       anemo@mba.ocn.ne.jp, linux-arch@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
Message-ID: <20061020214916.GA27810@linux-mips.org>
References: <Pine.LNX.4.64.0610200846260.3962@g5.osdl.org> <20061020.123635.95058911.davem@davemloft.net> <Pine.LNX.4.64.0610201251440.3962@g5.osdl.org> <20061020.125851.115909797.davem@davemloft.net> <Pine.LNX.4.64.0610201302090.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610201302090.3962@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 01:10:59PM -0700, Linus Torvalds wrote:

> Ok, this sounds sane.
> 
> What should we do about this? How does this patch look to people?
> 
> (Totally untested, and I'm not sure we should even do that whole 
> "oldmm->mm_users" test, but I'm throwing it out here for discussion, in 
> case it matters for performance. The second D$ flush should obviously be 
> unnecessary for the common unthreaded case, which is why none of this has 
> mattered historically, I think).
> 
> Comments? We need ARM, MIPS, sparc and S390 at the very least to sign off 
> on this, and somebody to write a nice explanation for the changelog (and 
> preferably do this through -mm too).

As a minimal solution your patch would work for MIPS but performance would be
suboptimal.

With my D-cache alias series applied the flush_cache_mm() in dup_mmap()
becomes entirely redundant.  When I delete the call (not part of my patchset)
it means 12% faster fork.  But I'm not proposing this for 2.6.19.

Note this does not make the flush_cache_mm() on process termination
redundant ...

  Ralf
