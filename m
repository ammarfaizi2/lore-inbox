Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265736AbUFRXSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265736AbUFRXSj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 19:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264957AbUFRXLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 19:11:17 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:36812 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265541AbUFRXHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 19:07:45 -0400
Subject: Re: DMA API issues
From: James Bottomley <James.Bottomley@steeleye.com>
To: David Brownell <david-b@pacbell.net>
Cc: Ian Molton <spyro@f2s.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       greg@kroah.com, tony@atomide.com, jamey.hicks@hp.com,
       joshua@joshuawise.com
In-Reply-To: <40D36EDE.2080803@pacbell.net>
References: <1087582845.1752.107.camel@mulgrave>	<20040618193544.48b88771.spyro@f2s.com>
			<1087584769.2134.119.camel@mulgrave>	<20040618195721.0cf43ec2.spyro@f2s.co
	m	> <40D34078.5060909@pacbell.net>
		<20040618204438.35278560.spyro@f2s.com>	<1087588627.2134.155.camel@mulgrave
	>  <40D359BB.3090106@pacbell.net> <1087593282.2135.176.camel@mulgrave> 
	<40D36EDE.2080803@pacbell.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Jun 2004 18:07:30 -0500
Message-Id: <1087600052.2135.197.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 17:38, David Brownell wrote:
> James Bottomley wrote:
> > The statement was "That's dma_alloc_coherent at its core ... it should
> > allocate from that 32K region." and what I was pointing out is that not
> > all platforms can treat an on-chip memory region as a real memory area. 
> 
> But this one can, and it sure seems like the appropriate
> solution.  For reasons like the one not quoted above:  it's
> a good way to eliminate what would otherwise be a case
> where a dmabounce is needed.  And hey wow, it even uses
> the API designed to reduce such DMA "mapping" costs, and
> there are drivers already using it for such purposes.

Well, yes, but the problem: chips have onboard memory is generic.  The
proposed solution in the DMA API can't only work on certain platforms.

> 
> > That's why we have the iomem accessor functions.
> 
> You mentioned ioremap(), which doesn't help here since
> the need is for a block of memory, not just address space,
> and also memcpy_toio(), which just another tool to implement
> the dma bouncing (which is on the "strongly avoid!" list).
> 
> As I said, those still don't make dma_alloc_coherent() work.

Right, that's rather the point.  The memory you get by doing an ioremap
on this chip area may have to be treated differently from real memory on
some platforms.

That's the fundamental problem of trying to treat it as memory obtained
from dma_alloc_coherent().

James


