Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUCSDJu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 22:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUCSDJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 22:09:50 -0500
Received: from waste.org ([209.173.204.2]:57767 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261661AbUCSDJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 22:09:47 -0500
Date: Thu, 18 Mar 2004 21:09:42 -0600
From: Matt Mackall <mpm@selenic.com>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Tom Rini <trini@kernel.crashing.org>
Subject: Re: [CFT] inflate.c rework arch testing needed
Message-ID: <20040319030942.GM11010@waste.org>
References: <20040318231006.GK11010@waste.org> <20040319003252.GB11450@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040319003252.GB11450@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 01:32:52AM +0100, J?rn Engel wrote:
> On Thu, 18 March 2004 17:10:06 -0600, Matt Mackall wrote:
> > 
> > I've reworked the mess that is lib/inflate.c, including:
> > 
> > - proper formatting
> > - killing a ton of legacy code
> > - cleaning up IO and CRC handling
> > - eliminating all the global variables
> > - using __init for the core kernel
> > - proper linking rather than the #include "../lib/inflate.c" hack
> > - lots of minor cleanups along the way
> > 
> > This drops a ton of support code from all the users of this code as
> > well:
> > 
> >  arch/arm/boot/compressed/Makefile    |    5
> >  arch/arm/boot/compressed/misc.c      |  244 --
> >  arch/i386/boot/compressed/Makefile   |    6
> >  arch/i386/boot/compressed/misc.c     |  224 --
> >  arch/x86_64/boot/compressed/Makefile |    6
> >  arch/x86_64/boot/compressed/misc.c   |  212 --
> >  include/linux/inflate.h              |    9
> >  init/do_mounts_rd.c                  |  129 -
> >  init/initramfs.c                     |  139 -
> >  lib/Makefile                         |    4
> >  lib/inflate.c                        | 3047 ++++++++++++++++-----------------
> >  11 files changed, 1688 insertions(+), 2337 deletions(-)
> 
> I like the patch in general.  This is definitely the wrong time for
> it, but at least parts of it could go into 2.7 sometime.

Well it's been sitting in -tiny for a while already and will stay
there until someone else is ready for it. I may try to push it to -mm
at some point.
 
> Have you thought about updating to a more recent version of zlib?  It
> is most likely not worth it but I'd like to know for sure.

The code for new versions of zlib is significantly scarier last I
checked and there's no particular advantage to it. But one of the
primary motivations here is to get to the point where something like
bunzip2 or even a new zlib is a drop-in replacement.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
