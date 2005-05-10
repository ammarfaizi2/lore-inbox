Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVEJMnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVEJMnD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 08:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVEJMnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 08:43:03 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:31931 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261626AbVEJMm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 08:42:58 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG][Resend] 2.6.12-rc3-mm3: Kernel BUG at "mm/slab.c":1219 [update]
Date: Tue, 10 May 2005 14:43:30 +0200
User-Agent: KMail/1.8
Cc: ak@suse.de, linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Alexander Nyberg <alexn@dsv.su.se>, li nux <lnxluv@yahoo.com>
References: <200505092239.37834.rjw@sisk.pl> <20050509145424.6ffba49a.akpm@osdl.org>
In-Reply-To: <20050509145424.6ffba49a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505101443.31229.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 9 of May 2005 23:54, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > I get this from 2.6.12-rc3-mm3 on a UP AMD64 box (Asus L5D), 100% of the time:
> > 
> > ]--snip--[
> > ACPI: bus type pci registered
> > PCI: Using configuration type 1
> > mtrr: v2.0 (20020519)
> > kmem_cache_create: Early error in slab <NULL>
> > ----------- [cut here ] --------- [please bite here ] ---------
> > Kernel BUG at "mm/slab.c":1219
> > invalid operand: 0000 [1]
]--snip--[ 
> 
> Something kooky is happening.
> 
> Clearly init_bio() is not passing in a NULL `name' parameter.  Maybe the
> backtrace is screwed due to dopey gcc autoinlining and the bad caller is
> really biovec_init_slabs().  Try removing the
> __cacheline_aligned_mostly_readonly from the declaration of bvec_slabs[].

Heh, it boots without the __cacheline_aligned_mostly_readonly (ie the BUG is
only triggered if the __cacheline_aligned_mostly_readonly is present in the
declaration of bvec_slabs[]).  I've double-checked it.  Interesting ... ;-)

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
