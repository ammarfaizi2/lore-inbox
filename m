Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264461AbUFSSYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbUFSSYI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 14:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbUFSSYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 14:24:08 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:6314 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S264461AbUFSSYF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 14:24:05 -0400
Message-ID: <40D4849B.3070001@pacbell.net>
Date: Sat, 19 Jun 2004 11:23:23 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: Ian Molton <spyro@f2s.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       greg@kroah.com, tony@atomide.com, jamey.hicks@hp.com,
       joshua@joshuawise.com
Subject: Re: DMA API issues
References: <1087582845.1752.107.camel@mulgrave>	<20040618193544.48b88771.spyro@f2s.com>			<1087584769.2134.119.camel@mulgrave>	<20040618195721.0cf43ec2.spyro@f2s.co	m	> <40D34078.5060909@pacbell.net>		<20040618204438.35278560.spyro@f2s.com>	<1087588627.2134.155.camel@mulgrave	>  <40D359BB.3090106@pacbell.net> <1087593282.2135.176.camel@mulgrave> 	<40D36EDE.2080803@pacbell.net> <1087600052.2135.197.camel@mulgrave>
In-Reply-To: <1087600052.2135.197.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Fri, 2004-06-18 at 17:38, David Brownell wrote:

>>You mentioned ioremap(), which doesn't help here since
>>the need is for a block of memory, not just address space,
>>and also memcpy_toio(), which just another tool to implement
>>the dma bouncing (which is on the "strongly avoid!" list).
>>
>>As I said, those still don't make dma_alloc_coherent() work.
> 
> 
> Right, that's rather the point.  The memory you get by doing an ioremap
> on this chip area may have to be treated differently from real memory on
> some platforms.

And that point/difference would be ... what?  It IS real memory.
Not "main memory", so the device's DMA access never consumes
bandwidth on the "main" memory bus, but real nonetheless.

I'm having to guess at your point here, even from other emails.
You've asserted a difference, but not what it is.  Maybe it's
something to do with the problem's NUMA nature?  Are you for
some reason applying DMA _mapping_ requirements (main-memory
only) to the DMA memory _allocation_ problem?


> That's the fundamental problem of trying to treat it as memory obtained
> from dma_alloc_coherent().

Well, no other memory in the entire system meets the requirements
for the dma_alloc_coherent() API, since _only that_ chunk of memory
is works with that device's DMA hardware.  Which is the fundamental
problem that needs to be solved.  It can clearly done at the platform
level, using device- or bus-specific implementations.

- Dave

