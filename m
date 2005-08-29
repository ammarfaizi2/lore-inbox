Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbVH2Sqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVH2Sqa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 14:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVH2Sqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 14:46:30 -0400
Received: from cantor2.suse.de ([195.135.220.15]:42172 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751290AbVH2Sq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 14:46:29 -0400
From: Andi Kleen <ak@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [patch 08/16] Add support for X86_64 platforms to KGDB
Date: Mon, 29 Aug 2005 20:46:15 +0200
User-Agent: KMail/1.8
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, amitkale@linsyssoft.com,
       Bob Picco <bob.picco@hp.com>
References: <resend.7.2982005.trini@kernel.crashing.org> <200508291913.48648.ak@suse.de> <20050829174525.GD3827@smtp.west.cox.net>
In-Reply-To: <20050829174525.GD3827@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508292046.15888.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 August 2005 19:45, Tom Rini wrote:

>
> Bob did this part (forgot to CC him, oops).  But I believe it's needed
> for setting traps so much earlier.

Ok looking again I guess he needed it for the GDT access in cpu_init

> > > +	if (notify_die(DIE_PAGE_FAULT, "no context", regs, error_code, 14,
> > > +				SIGSEGV) == NOTIFY_STOP)
> > > +		return;
> > > +
> >
> > I can see the point of that. It's ok if you submit it as a separate
> > patch.
>
> I can split that out into one that follows the KDB_VECTOR rename easily
> enough.

That's fine. The rename is fine for me too btw.

>
> > Regarding early trap init: I would have no problem to move all of
> > traps_init into setup_arch (and leave traps_init empty for generic code).
> > I actually don't know why it runs so late. But doing it half way is ugly.
>
> Should I make setup_per_cpu_area and trap_init empty and turn the real
> ones into early_foo?

setup_per_cpu_area is still needed later because it needs to allocate for non 
BP and you cannot do that that early. 

-Andi


