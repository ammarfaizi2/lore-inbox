Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVDKXvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVDKXvi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 19:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVDKXvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 19:51:38 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11395 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261682AbVDKXvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 19:51:31 -0400
Date: Tue, 12 Apr 2005 01:51:10 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nathan Scott <nathans@sgi.com>
Cc: "Barry K. Nathan" <barryn@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, hare@suse.de, linux-xfs@oss.sgi.com
Subject: Re: [xfs-masters] swsusp vs. xfs [was Re: 2.6.12-rc2-mm1]
Message-ID: <20050411235110.GA2472@elf.ucw.cz>
References: <20050406142749.6065b836.akpm@osdl.org> <20050407030614.GA7583@ip68-4-98-123.oc.oc.cox.net> <20050408103327.GD1392@elf.ucw.cz> <20050410211808.GA12118@ip68-4-98-123.oc.oc.cox.net> <20050410212747.GB26316@elf.ucw.cz> <20050410225708.GB12118@ip68-4-98-123.oc.oc.cox.net> <20050410230053.GD12794@elf.ucw.cz> <20050411043124.GA24626@ip68-4-98-123.oc.oc.cox.net> <20050411105759.GB1373@elf.ucw.cz> <20050411231213.GD702@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411231213.GD702@frodo>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > No, XFS is my root filesystem. :( (Now that I think about it, would
> > > > > modularizing XFS and using an initrd be OK?)
> > > > 
> > > > Yes, loading xfs from initrd should help. [At least it did during
> > > > suse9.3 testing.]
> > > 
> > > Once I modularized xfs and switched to using an initrd, the problem
> > > disappeared.
> > 
> > I reproduced it locally. Problem is that xfsbufd goes refrigerated,
> > but someone still tries to wake it up *very* often. Probably something
> > else in xfs needs refrigerating, too, but I'm not a XFS wizard...
> 
> Thanks Pavel - I've been reading the thread from the other side
> of the fence, not understanding the swsusp side of things. :)
> 
> There are two ways the xfsbufd thread will wake up - either by its
> timer going off (for it to flush delayed write metadata buffers)
> or by being explicitly woken up when we're low on memory (in which
> case it also flushes out dirty metadata, such that pages can be
> cleaned and made available to the system).
> 
> Since the refrigerator() call is in place in the main xfsbufd loop,
> I suspect we're hitting that second case here, where a low memory
> situation is resulting in someone attempting to wakeup xfsbufd --
> I'm not sure if this is the right way to check if we're in that
> state, but does this patch help?  (it would certainly prevent the
> spurious wakeups, but only if the caller has PF_FREEZE set - will
> that be the case here?)

I should take some sleep now, so I can't test the patch, but I don't
think it will help. If someone has PF_FREEZE set, he should be in
refrigerator.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
