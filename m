Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267858AbUHESOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267858AbUHESOB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267842AbUHESK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:10:28 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:33490 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S267857AbUHESDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:03:45 -0400
Date: Thu, 5 Aug 2004 11:03:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Giuliano Pochini <pochini@shiny.it>, kumar.gala@freescale.com,
       tnt@246tNt.com, linuxppc-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH][PPC32] Makefile cleanups and gcc-3.4+binutils-2.14 c
Message-ID: <20040805180344.GC555@smtp.west.cox.net>
References: <20040729144347.GE16468@smtp.west.cox.net> <20040730205901.4d4181f4.pochini@shiny.it> <20040730190731.GQ16468@smtp.west.cox.net> <20040730224828.0f06e37a.pochini@shiny.it> <20040730210318.GS16468@smtp.west.cox.net> <20040805141257.GA14826@suse.de> <20040805165410.GA555@smtp.west.cox.net> <20040805170044.GA5388@suse.de> <20040805172033.GB555@smtp.west.cox.net> <20040805173926.GA14028@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805173926.GA14028@suse.de>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 07:39:26PM +0200, Olaf Hering wrote:
>  On Thu, Aug 05, Tom Rini wrote:
> 
> > On Thu, Aug 05, 2004 at 07:00:44PM +0200, Olaf Hering wrote:
> > >  On Thu, Aug 05, Tom Rini wrote:
> > > 
> > > > On Thu, Aug 05, 2004 at 04:12:57PM +0200, Olaf Hering wrote:
> > > > >  On Fri, Jul 30, Tom Rini wrote:
> > > > > 
> > > > > > 
> > > > > > +aflags-$(CONFIG_PPC64BRIDGE)	+= -mppc64bridge
> > > > > 
> > > > > this should be -Wa,-mppc64bridge for some reasons.
> > > > 
> > > > That, er, doesn't make sense.  The assembler needs -Wa,?
> > > 
> > > The cmdline was 'gcc .. -mppc64bridge ..'
> > > But there is more breakage with g5 32bit, I'm looking at it right now.
> > 
> > Hmm.  Was cflags-... done correctly?
> 
> I have currently no idea whats going on with the cflags. power3 and g5
> fails for me with current binutils and hammer branch.
> 
> g5 needs the altivec option, because -maltivec -mppc64bridge  will disable
> altivec again in as. And arch/ppc/kernel/Makefile adds -mppc64bridge
> after the cflags in arch/ppc/Makefile. Maybe the EXTRA_CFLAGS can be
> removed from arch/ppc/kernel/Makefile?

EXTRA_CFLAGS can go, yes (I was assuming -rc2 then -final, or I would
have done this already_.  The problem looks like AFLAGS being used when
CFLAGS are wanted to be used.

-- 
Tom Rini
http://gate.crashing.org/~trini/
