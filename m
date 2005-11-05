Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbVKEF5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbVKEF5I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 00:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbVKEF5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 00:57:08 -0500
Received: from ns2.suse.de ([195.135.220.15]:18352 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751234AbVKEF5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 00:57:06 -0500
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Sat, 5 Nov 2005 16:37:01 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17260.17661.523593.420313@cse.unsw.edu.au>
Cc: cplk@itee.uq.edu.au, bunk@stusta.de, heiko.carstens@de.ibm.com,
       linux-kernel@vger.kernel.org, aherrman@de.ibm.com, dm-devel@redhat.com
Subject: Re: [PATCH resubmit] do_mount: reduce stack consumption
In-Reply-To: message from Andrew Morton on Friday November 4
References: <20051104105026.GA12476@osiris.boeblingen.de.ibm.com>
	<20051104084829.714c5dbb.akpm@osdl.org>
	<20051104212742.GC9222@osiris.ibm.com>
	<20051104235500.GE5368@stusta.de>
	<20051104160851.3a7463ff.akpm@osdl.org>
	<Pine.GSO.4.60.0511051108070.2449@mango.itee.uq.edu.au>
	<20051104173721.597bd223.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday November 4, akpm@osdl.org wrote:
> cplk@itee.uq.edu.au wrote:
> >
> > > > > This part of the call trace is actually good for >1500 bytes of stack
> > > > > usage and is what kills us and should be fixed.
> > > > > I'm surprised that there are no other bug reports regarding DM and
> > > > > stack overflow with 4k stacks.
> > > > >...
> > > > 
> > > > There were some reports of dm+xfs overflows with 4k stacks on i386.
> > > > 
> > > > The xfs side was sorted out, but I son't know the state of the dm part.
> > > > 
> > > 
> > > The state is Very Bad, IMO.  At the very least, DM should struggle to the
> > > utmost to reduce the stack utilisation around that recursion point.
> > 
> > Neil Brown suggested a change to generic_make_request to convert recursion 
> > through it into iteration (see http://lkml.org/lkml/2005/9/2/34 ), but 
> > there was no discussion at the time.  Would this help with this case?
> 
> It certainly would.  That looks like a good thing to do some more work on.

Ok, I'll dust it off, make sure it seems to work (at the time I first
wrote it, I think it caused 'md' to deadlock) and submit it.

NeilBrown
