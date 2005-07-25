Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVGYX0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVGYX0F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 19:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVGYX0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 19:26:02 -0400
Received: from orb.pobox.com ([207.8.226.5]:35508 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261222AbVGYXZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 19:25:07 -0400
Date: Mon, 25 Jul 2005 18:25:02 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>
Subject: Re: topology api confusion
Message-ID: <20050725232502.GC30720@otto>
References: <20050722213316.GE17865@otto> <42E55C7E.50301@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E55C7E.50301@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson wrote:
> Nathan Lynch wrote:
> > We need some clarity on how asm-generic/topology.h is intended to be
> > used.  I suspect that it's supposed to be unconditionally included at
> > the end of the architecture's topology.h so that any elements which
> > are undefined by the arch have sensible default definitions.  Looking
> > at 2.6.13-rc3, this is what ppc64, ia64, and x86_64 currently do,
> > however i386 does not (i386 pulls in the generic version only when
> > !CONFIG_NUMA).
> > 
> > The #ifndef guards around each element of the topology api
> > cannot serve their apparent intended purpose when the architecture
> > implements a given bit as a function instead of a macro
> > (e.g. cpu_to_node in ppc64):
> 
> When I originally wrote this all up, I had planned it to be used the way
> i386 does: offer a full implementation of topology if appropriate, else
> include the generic "sane" default.  It has since changed to work more like
> you described: implement some (or all) of the topology functions, then
> include the generic one to define any you missed.

OK.

> You are correct in noticing that things should (though apparently don't?)
> go wonky when arches define their topology functions as *functions*, rather
> than macros.  It hasn't really seemed to bite anyone yet, so I've left it
> alone, though to be honest, it is as surprising to me that it works as it
> is to you.  I've resisted creating #ifdef ARCH_HAVE_XXX all over the place,
> though maybe it is finally time?

Things _do_ go wonky, but likely only on ppc64 -- all cpus show up in
all nodes' cpumaps in sysfs.  The other architectures which provide
overrides and unconditionally include the generic topology.h define
only macros iirc.  If i386 were to include the generic topology.h it
would have similar issues since it uses functions for some things too.

> > Thought I'd ask for input first since this would involve a sweep of
> > include/asm-*.
> 
> It would indeed...  I'd be more than happy to look at any patches you care
> to generate.  As I said, it seems to work, though I'm certain it's all held
> together by GCC black magic & voodoo, and probably a little duct-tape.  A
> more obviously correct solution would not be a bad thing. :)

I've got the changes ready, just need to test them a little more.

Thanks.

Nathan
