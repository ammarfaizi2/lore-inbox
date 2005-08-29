Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbVH2Sts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbVH2Sts (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 14:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVH2Sts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 14:49:48 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:43219 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751303AbVH2Str (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 14:49:47 -0400
Date: Mon, 29 Aug 2005 11:49:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, amitkale@linsyssoft.com,
       Bob Picco <bob.picco@hp.com>
Subject: Re: [patch 08/16] Add support for X86_64 platforms to KGDB
Message-ID: <20050829184945.GE3827@smtp.west.cox.net>
References: <resend.7.2982005.trini@kernel.crashing.org> <200508291913.48648.ak@suse.de> <20050829174525.GD3827@smtp.west.cox.net> <200508292046.15888.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508292046.15888.ak@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2005 at 08:46:15PM +0200, Andi Kleen wrote:
> On Monday 29 August 2005 19:45, Tom Rini wrote:
> 
> >
> > Bob did this part (forgot to CC him, oops).  But I believe it's needed
> > for setting traps so much earlier.
> 
> Ok looking again I guess he needed it for the GDT access in cpu_init
> 
> > > > +	if (notify_die(DIE_PAGE_FAULT, "no context", regs, error_code, 14,
> > > > +				SIGSEGV) == NOTIFY_STOP)
> > > > +		return;
> > > > +
> > >
> > > I can see the point of that. It's ok if you submit it as a separate
> > > patch.
> >
> > I can split that out into one that follows the KDB_VECTOR rename easily
> > enough.
> 
> That's fine. The rename is fine for me too btw.
> 
> >
> > > Regarding early trap init: I would have no problem to move all of
> > > traps_init into setup_arch (and leave traps_init empty for generic code).
> > > I actually don't know why it runs so late. But doing it half way is ugly.
> >
> > Should I make setup_per_cpu_area and trap_init empty and turn the real
> > ones into early_foo?
> 
> setup_per_cpu_area is still needed later because it needs to allocate for non 
> BP and you cannot do that that early. 

OK.  So I'll send out a patch that makes trap_init() empty and use the
early_setup_per_cpu_areas() Bob wrote as well.

Andrew: In sum, there will be 3 patches that replace the x86_64 main
patch (2 split-out-stuff, 1 new kgdb patch).

-- 
Tom Rini
http://gate.crashing.org/~trini/
