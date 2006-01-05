Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWAEXS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWAEXS5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWAEXS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:18:56 -0500
Received: from waste.org ([64.81.244.121]:54737 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750774AbWAEXS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:18:56 -0500
Date: Thu, 5 Jan 2006 17:11:50 -0600
From: Matt Mackall <mpm@selenic.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
Message-ID: <20060105231150.GR3356@waste.org>
References: <43BC716A.5080204@mbligh.org> <1136463553.2920.22.camel@laptopd505.fenrus.org> <20060105170255.GK3356@waste.org> <43BD5E6F.1040000@mbligh.org> <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org> <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org> <20060105213442.GM3356@waste.org> <Pine.LNX.4.64.0601051402550.3169@g5.osdl.org> <20060105223656.GP3356@waste.org> <20060105225513.GA1570@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105225513.GA1570@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 11:55:13PM +0100, Ingo Molnar wrote:
> 
> * Matt Mackall <mpm@selenic.com> wrote:
> 
> > > I don't believe it is actually all _that_ volatile. Yes, it would be a 
> > > huge issue _initially_, but the incremental effects shouldn't be that big, 
> > > or there is something wrong with the approach.
> > 
> > No, perhaps not. But it would be nice in theory for people to be able 
> > to do things like profile their production system and relink. And 
> > having to touch hundreds of files to do it would be painful.
> 
> we can (almost) do that: via -ffunction-sections. It does seem to work 
> on both the gcc and the ld side. [i tried to use this for --gc-sections 
> to save more space, but that ld option seems unstable, i couldnt link a 
> bootable image. -ffunction-sections itself seems to work fine in gcc4.]

Yeah, we've been talking about --gc-sections for years. It'd be nice
if we could work the build system in that direction with this
profiling concept.

(I suspect something silly happened in your test like dropping the
fixup table, btw.)

> i think all that is needed to reorder the functions is a build-time 
> generated ld script, which is generated off the 'popularity list'.
> 
> so i think the two concepts could nicely co-exist: in-source annotations 
> help us maintain the popularity list, -ffunction-sections allows us to 
> reorder at link time. In fact such a kernel could be shipped in 
> 'unlinked' state, and could be relinked based on per-system profiling 
> data. As long as we have KALLSYMS, it's not even a big debuggability 
> issue.

I'm still not sure about in-source annotations for popularity. My
suspicion is that it's just too workload-dependent, and a given
author's workload will likely be biased towards their code.

-- 
Mathematics is the supreme nostalgia of our time.
