Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbVKEBk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbVKEBk7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 20:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbVKEBk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 20:40:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30849 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751446AbVKEBk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 20:40:58 -0500
Date: Fri, 4 Nov 2005 17:37:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: cplk@itee.uq.edu.au, Neil Brown <neilb@cse.unsw.edu.au>
Cc: bunk@stusta.de, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
       aherrman@de.ibm.com, dm-devel@redhat.com
Subject: Re: [PATCH resubmit] do_mount: reduce stack consumption
Message-Id: <20051104173721.597bd223.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.60.0511051108070.2449@mango.itee.uq.edu.au>
References: <20051104105026.GA12476@osiris.boeblingen.de.ibm.com>
	<20051104084829.714c5dbb.akpm@osdl.org>
	<20051104212742.GC9222@osiris.ibm.com>
	<20051104235500.GE5368@stusta.de>
	<20051104160851.3a7463ff.akpm@osdl.org>
	<Pine.GSO.4.60.0511051108070.2449@mango.itee.uq.edu.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cplk@itee.uq.edu.au wrote:
>
> > > > This part of the call trace is actually good for >1500 bytes of stack
> > > > usage and is what kills us and should be fixed.
> > > > I'm surprised that there are no other bug reports regarding DM and
> > > > stack overflow with 4k stacks.
> > > >...
> > > 
> > > There were some reports of dm+xfs overflows with 4k stacks on i386.
> > > 
> > > The xfs side was sorted out, but I son't know the state of the dm part.
> > > 
> > 
> > The state is Very Bad, IMO.  At the very least, DM should struggle to the
> > utmost to reduce the stack utilisation around that recursion point.
> 
> Neil Brown suggested a change to generic_make_request to convert recursion 
> through it into iteration (see http://lkml.org/lkml/2005/9/2/34 ), but 
> there was no discussion at the time.  Would this help with this case?

It certainly would.  That looks like a good thing to do some more work on.
