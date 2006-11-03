Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753485AbWKCWBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbWKCWBe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 17:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753497AbWKCWBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 17:01:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:28394 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1753485AbWKCWBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 17:01:33 -0500
From: Andi Kleen <ak@suse.de>
To: Amul Shah <amul.shah@unisys.com>
Subject: Re: [RFC] [PATCH 2.6.19-rc4] kdump panics early in boot when    reserving MP Tables located in high memory
Date: Fri, 3 Nov 2006 23:01:31 +0100
User-Agent: KMail/1.9.5
Cc: vgoyal@in.ibm.com, LKML <linux-kernel@vger.kernel.org>
References: <1162506272.19677.33.camel@ustr-linux-shaha1.unisys.com> <200611032052.05738.ak@suse.de> <1162588660.19677.118.camel@ustr-linux-shaha1.unisys.com>
In-Reply-To: <1162588660.19677.118.camel@ustr-linux-shaha1.unisys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611032301.32094.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 November 2006 22:17, Amul Shah wrote:
> On Fri, 2006-11-03 at 20:52 +0100, Andi Kleen wrote:
> > On Friday 03 November 2006 20:47, Amul Shah wrote:
> > 
> > > Andi, Vivek is right.  We can use end_pfn_map.  My observation is wrong.
> > 
> > Ok. Then my patch should work?
> 
> The patch does work on a 2.6.16 derived kernel (SLES 10 kernel).  The
> 2.6.19-rc4 kernel is doing some funny things when I use it as a kdump
> kernel (regardless of the patch).

Magnus had another patch for that which I applied

ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/setup-saved_max_pfn-correctly-kdump

Does it work with that?

 
> > > Vivek, the problem condition is in generic reserve_bootmem_core
> > > (mm/bootmem.c), where this
> > > 	BUG_ON(PFN_DOWN(addr) >= bdata->node_low_pfn);
> > > checks the target address against the top of that node's memory.
> > 
> > In general these early BUGs should be eliminated - they are always
> > messy because the kernel exception handlers are not fully functional
> > yet. printks or worst case panics are better.
> > 
> > -Andi
> 
> I assume that we are not going to change mm/bootmem.c since your patch
> works.  Am I right?

Yep.

-Andi
