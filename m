Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbTH3HdE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 03:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbTH3HdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 03:33:04 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:10737
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S262296AbTH3Hc6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 03:32:58 -0400
Date: Sat, 30 Aug 2003 07:01:11 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Shantanu Goel <sgoel01@yahoo.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Antonio Vargas <wind@cocodriloo.com>,
       linux-kernel@vger.kernel.org,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: [VM PATCH] Faster reclamation of dirty pages and unused inode/dcache entries in 2.4.22
Message-ID: <20030830050111.GD640@wind.cocodriloo.com>
References: <20030829195543.GD24409@dualathlon.random> <20030829202001.38031.qmail@web12807.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030829202001.38031.qmail@web12807.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 01:20:01PM -0700, Shantanu Goel wrote:
> Thanks for the pointer to the benchmarks.
> 
> The patch I posted only helps the mmap case so it
> won't help (or hurt hopefully ;-) any program that
> primarily does read/write instead of mmap.  The
> extreme case where I observed this was a perl script
> that created a gigantic hash and tried to populate it.

I've experienced this workload and it's easily reproducible:
get the lxr tools and try to build the indexes.

>  The perl in question uses mmap for malloc.  The
> difference in execution time between stock 2.4.22 and
> one with the patch was insignificant because it is
> primarily I/O bound, however the other apps I was
> running, Mozilla and several xterm's, were paged out
> much less frequently in the latter case.  The machine
> has 256MB of memory and perl grew to about 1 GB.
> 
> I have written another patch that more aggresively
> tries to free pages with dirty buffers which should
> help with the buffer I/O case.  It essentially changes
> try_to_free_buffers() so it immediately starts and
> waits for I/O to complete if the gfp_mask allows it. 
> It does not do any clustering so its performance is
> questionable at the moment.
> 
> --- Andrea Arcangeli <andrea@suse.de> wrote:
> > On Fri, Aug 29, 2003 at 12:46:36PM -0700, Shantanu
> > Goel wrote:
> > > Andrea,
> > > 
> > > I'll test and submit a patch against -aa.  Also,
> > is
> > > there a common benchmark that you use to test for
> > > regression?
> > 
> > bonnie,tiobench,dbench would be a very good start
> > for the basics (note:
> > dbench can be misleading, but at the same fariness
> > levels, it's
> > interesting too, it's just that dbench doesn't
> > measure the fariness
> > level itself [like tiobench started doing relatively
> > recently]).
> > 
> > (I'm assuming the patch makes difference not only
> > for mmapped dirty
> > pages, in such case the above would be non
> > interesting)
> > 
> > thanks,
> > 
> > Andrea
> 
> 
> __________________________________
> Do you Yahoo!?
> Yahoo! SiteBuilder - Free, easy-to-use web site design software
> http://sitebuilder.yahoo.com

-- 
winden/network

1. Dado un programa, siempre tiene al menos un fallo.
2. Dadas varias lineas de codigo, siempre se pueden acortar a menos lineas.
3. Por induccion, todos los programas se pueden
   reducir a una linea que no funciona.
