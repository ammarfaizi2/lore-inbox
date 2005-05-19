Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVESRhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVESRhy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 13:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVESRhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 13:37:54 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:39347 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261176AbVESRhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 13:37:46 -0400
Subject: Re: Illegal use of reserved word in system.h
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-os@analogic.com
Cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
       "Gilbert, John" <JGG@dolby.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Adrian Bunk <bunk@stusta.de>, Arjan van de Ven <arjan@infradead.org>,
       "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <Pine.LNX.4.61.0505191304540.31202@chaos.analogic.com>
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>
	 <20050518195337.GX5112@stusta.de>
	 <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
	 <20050519112840.GE5112@stusta.de>
	 <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
	 <1116505655.6027.45.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61L.0505191342460.10681@blysk.ds.pg.gda.pl>
	 <Pine.LNX.4.61.0505190853310.29611@chaos.analogic.com>
	 <jeacmr5mzk.fsf@sykes.suse.de>
	 <1116512140.15866.42.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0505191024110.30237@chaos.analogic.com>
	 <je64xf450i.fsf@sykes.suse.de>
	 <Pine.LNX.4.61.0505191150070.30960@chaos.analogic.com>
	 <1116519739.4075.2.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0505191304540.31202@chaos.analogic.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 19 May 2005 13:36:23 -0400
Message-Id: <1116524183.4097.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 13:06 -0400, Richard B. Johnson wrote:

> >
> > You forgot to include ARCH_DL_INFO which is defined in asm-i386/elf.h
> > as:
> >
> > #define ARCH_DLINFO						\
> > do {								\
> > 		NEW_AUX_ENT(AT_SYSINFO,	VSYSCALL_ENTRY);	\
> > 		NEW_AUX_ENT(AT_SYSINFO_EHDR, VSYSCALL_BASE);	\
> > } while (0)
> >
> > AT_SYSINFO = 32 or 0x20  and AT_SYSINFO_EHDR = 33 or 0x21
> >
> > -- Steve
> 
> Okay, good. At least I have the right vector. Now to find
> a clean way to use it. The whole idea was to not have to
> use kernel headers, BTW.
> 

The real question is whether or not getpagesize uses this?  This should
be information that is passed to libc and not be something that the user
program uses directly.  As you noticed, this vector is also architecture
specific, and should be only used by libc.  I believe that the linker is
probably the driving factor for this information and not the kernel, so
the kernel headers should not be included.

-- Steve

BTW, I'm still not getting any direct email from you.

