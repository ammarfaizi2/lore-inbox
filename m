Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbVIUSmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbVIUSmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbVIUSmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:42:13 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:61347 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1751369AbVIUSmM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:42:12 -0400
Date: Wed, 21 Sep 2005 20:42:11 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Frank van Maarseveen <frankvm@frankvm.com>,
       Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org,
       Jay Lan <jlan@engr.sgi.com>
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
Message-ID: <20050921184211.GC17272@janus>
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com> <20050921145833.GA15682@janus> <Pine.LNX.4.61.0509211621410.7001@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509211621410.7001@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 04:35:56PM +0100, Hugh Dickins wrote:
> On Wed, 21 Sep 2005, Frank van Maarseveen wrote:
> 
> > --- ./fs/proc/task_mmu.c.orig	2005-07-07 14:22:12.000000000 +0200
> > +++ ./fs/proc/task_mmu.c	2005-09-16 13:51:56.000000000 +0200
> > @@ -14,6 +14,7 @@
> >  	text = (PAGE_ALIGN(mm->end_code) - (mm->start_code & PAGE_MASK)) >> 10;
> >  	lib = (mm->exec_vm << (PAGE_SHIFT-10)) - text;
> >  	buffer += sprintf(buffer,
> > +		"VmPeak:\t%8lu kB\n"
> 
> Good naming.
> 
> >  		"VmSize:\t%8lu kB\n"
> >  		"VmLck:\t%8lu kB\n"
> >  		"VmRSS:\t%8lu kB\n"
> > @@ -22,6 +23,7 @@
> >  		"VmExe:\t%8lu kB\n"
> >  		"VmLib:\t%8lu kB\n"
> >  		"VmPTE:\t%8lu kB\n",
> > +		mm->hiwater_vm << (PAGE_SHIFT-10),
> >  		(mm->total_vm - mm->reserved_vm) << (PAGE_SHIFT-10),
> >  		mm->locked_vm << (PAGE_SHIFT-10),
> >  		get_mm_counter(mm, rss) << (PAGE_SHIFT-10),
> 
> I do keep wondering what's so interesting about this hiwater_vm
> (but would regret proposing other statistics to gather instead):
> perhaps you're showing it just because it's there?

No, hiwater_vm is exactly what we need. Before hiwater_vm I had my own patch
to get exactly the same result but the member was called "peak_vm" instead.

Most software we develop at my work uses this to test for regression
in memory usage. Just before program exit it reads /proc/pid/status:VmPeak
and reports it. Scripts do the rest.

-- 
Frank
