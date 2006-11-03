Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753542AbWKCVS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542AbWKCVS5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 16:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753543AbWKCVS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 16:18:57 -0500
Received: from usea-naimss2.unisys.com ([192.61.61.104]:36612 "EHLO
	usea-naimss2.unisys.com") by vger.kernel.org with ESMTP
	id S1753542AbWKCVS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 16:18:56 -0500
Subject: Re: [RFC] [PATCH 2.6.19-rc4] kdump panics early in boot when   
	reserving MP Tables located in high memory
From: Amul Shah <amul.shah@unisys.com>
To: Andi Kleen <ak@suse.de>
Cc: vgoyal@in.ibm.com, LKML <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
In-Reply-To: <200611032052.05738.ak@suse.de>
References: <1162506272.19677.33.camel@ustr-linux-shaha1.unisys.com>
	 <20061103171757.GC9371@in.ibm.com>
	 <1162583277.19677.108.camel@ustr-linux-shaha1.unisys.com>
	 <200611032052.05738.ak@suse.de>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 16:17:39 -0500
Message-Id: <1162588660.19677.118.camel@ustr-linux-shaha1.unisys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Nov 2006 21:18:38.0129 (UTC) FILETIME=[A0E23A10:01C6FF8D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-03 at 20:52 +0100, Andi Kleen wrote:
> On Friday 03 November 2006 20:47, Amul Shah wrote:
> 
> > Andi, Vivek is right.  We can use end_pfn_map.  My observation is wrong.
> 
> Ok. Then my patch should work?

The patch does work on a 2.6.16 derived kernel (SLES 10 kernel).  The
2.6.19-rc4 kernel is doing some funny things when I use it as a kdump
kernel (regardless of the patch).

> > Vivek, the problem condition is in generic reserve_bootmem_core
> > (mm/bootmem.c), where this
> > 	BUG_ON(PFN_DOWN(addr) >= bdata->node_low_pfn);
> > checks the target address against the top of that node's memory.
> 
> In general these early BUGs should be eliminated - they are always
> messy because the kernel exception handlers are not fully functional
> yet. printks or worst case panics are better.
> 
> -Andi

I assume that we are not going to change mm/bootmem.c since your patch
works.  Am I right?

Amul

