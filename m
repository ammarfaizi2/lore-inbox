Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267194AbUBSEqr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 23:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267213AbUBSEqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 23:46:47 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:6064 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S267194AbUBSEqn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 23:46:43 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH][0/6] A different KGDB stub
Date: Thu, 19 Feb 2004 10:16:29 +0530
User-Agent: KMail/1.5
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Andi Kleen <ak@suse.de>, George Anzinger <george@mvista.com>,
       Jim Houston <jim.houston@ccur.com>, Matt Mackall <mpm@selenic.com>
References: <20040217220236.GA16881@smtp.west.cox.net> <200402181026.29813.amitkale@emsyssoft.com> <20040218182100.GR16881@smtp.west.cox.net>
In-Reply-To: <20040218182100.GR16881@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402191016.29107.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 Feb 2004 11:51 pm, Tom Rini wrote:
> On Wed, Feb 18, 2004 at 10:26:29AM +0530, Amit S. Kale wrote:
> > On Wednesday 18 Feb 2004 4:22 am, Pavel Machek wrote:
> > > Hi!
> > >
> > > > > The following is my next attempt at a different KGDB stub
> > > > > for your tree
> > > >
> > > > Is this the patch which everyone agrees on?
> > >
> > > It is based on Amit's version, so I think answer is "yes". I certainly
> > > like this one.
> >
> > I don't agree. I did a few more cleanups after Andi expressed concerns
> > over globals kgdb_memerr and debugger_memerr_expected.
> >
> > I liked Pavel's approach. Let's first get a minimal kgdb stub into
> > mainline kernel. Even this much is going to involve some effort. We can
> > merge other features later.
> >
> > Let's create a cvs tree at kgdb.sourceforge.net for kgdb components to be
> > pushed int mainline kernel. This split is to keep current kgdb
> > unaffected. People who are already using it won't be affected.
> >
> > May I suggest we breakup this task into following tasklets. I have
> > expanded item 1 because Pavel has something that's already close. The
> > rest of the items can be discussed in detail later. These need not be
> > done in this order except for first 2 whose sequence is fixed.
> >
> > 1. A minimal kgdb stub
> >   core.patch:
> >     kgdbstub.c full.
> >     No changes to module.c
> >     No changes for CONFIG_KGDB_THREAD
> >     No changes to calling convention of do_IRQ (Needs to be done)
> >     CONFIG_KGDB_CONSOLE removed
> >   i386.patch
> >     No changes for CONFIG_KGDB_THREAD
> >     No manipulation of kernel stack before entry into do_IRQ
> >     No non-source level CFI directives.
>
> My question is now, is there anything in CVS other than patches?

No.
The CVS tree contains patches only.
What I have described above are features of two patches: core.patch and 
i386.patch.

> There's still a whole host of cleanups that need to be done to your
> version that I've got around here.

You are welcome to bring them into the cvs tree.
Thanks.
-Amit

>
> > 4. Patch to sync other architecture kgdbs with arch independent stub on
> > help from maintainers of those architectures.
> > 5. KGDB_CONSOLE patch
> >    This is a must for embedded boards that have only one serial port
> > 6. gdb automatic module loading
> > 7. CONFIG_KGDB_THREAD patch
> >    This may or may not be a separate config option. This patch will
> > include x86_64 support required to enable threads.
> > 8. i386 thread support
> > 9. Ethernet interface based on netconsole
> > 10. ... Any other features
>
> Personally, I'd swap 6 and 9.

