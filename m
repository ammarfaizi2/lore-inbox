Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbUCCHyZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 02:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbUCCHyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 02:54:25 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:59534 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262412AbUCCHyX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 02:54:23 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Pavel Machek <pavel@ucw.cz>, Tom Rini <trini@kernel.crashing.org>
Subject: Re: [KGDB PATCH][1/7] Add / use kernel/Kconfig.kgdb
Date: Wed, 3 Mar 2004 13:24:14 +0530
User-Agent: KMail/1.5
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net
References: <20040227212301.GC1052@smtp.west.cox.net> <20040302223403.GI20227@smtp.west.cox.net> <20040302223526.GH1225@elf.ucw.cz>
In-Reply-To: <20040302223526.GH1225@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403031324.14651.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 Mar 2004 4:05 am, Pavel Machek wrote:
> Hi!
>
> > > > > It also makes core.patch dependent on 8250.patch
> > > > > Any ideas on fixing that?
> > > >
> > > > No, it's intentional.  eth.patch also depends on 8250.patch.
> > >
> > > Perhaps that parts should be moved to core-lite? It should not be
> > > neccessary to have serial support...
> > >
> > > Or perhaps we want to decrease number of modules, and merge 8250 into
> > > core-lite, having one less patch to care about?

Let's keep currents splits as they are. (core-lite, i386-lite, core, i386, 
x86_64, ppc, 8250, eth) It's very tempting to start merging, but that makes 
it difficult to modify only a few of them and eventually user won't have the 
choice of selecting only those that are needed.

> > If it's really important to not have patches depend on eachother until
> > we get to the non-lite core, i386 (and soon ppc, x86_64) patches, then
> > we should put all of the Kconfig bits in the main patch, so long as we
> > think all of the related drivers will be able to make it in as well (or
> > will move those bits out again when it's time).  Or we could just
> > document dependancies and move on.
>
> I believe "put kconfig into core" is the right thing to do.

I have a different opinion. Ideally these patches are best kept completely 
independent of each other. We may not be able to achieve that all the time. 
Right now we have following order of patches. [core-lite, i386-lite, 
8250][core, i386, x86_64, eth]. Second set depends on first. Patches in each 
set are independent of each other. We anyway have this dependency because of 
lite patches. So 8250 dependency should be ok.

-Amit
