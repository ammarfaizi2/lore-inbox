Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbUFRWnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbUFRWnE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 18:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263995AbUFRWkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 18:40:16 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:34503 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262065AbUFRWjL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 18:39:11 -0400
Message-ID: <40D36EDE.2080803@pacbell.net>
Date: Fri, 18 Jun 2004 15:38:22 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: Ian Molton <spyro@f2s.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       greg@kroah.com, tony@atomide.com, jamey.hicks@hp.com,
       joshua@joshuawise.com
Subject: Re: DMA API issues
References: <1087582845.1752.107.camel@mulgrave>	<20040618193544.48b88771.spyro@f2s.com>		<1087584769.2134.119.camel@mulgrave>	<20040618195721.0cf43ec2.spyro@f2s.com	> <40D34078.5060909@pacbell.net> 	<20040618204438.35278560.spyro@f2s.com>	<1087588627.2134.155.camel@mulgrave>  <40D359BB.3090106@pacbell.net> <1087593282.2135.176.camel@mulgrave>
In-Reply-To: <1087593282.2135.176.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Fri, 2004-06-18 at 16:08, David Brownell wrote:
> 
>>I'm not following you.  This isn't using the PCI DMA calls.
>>These dots don't connect:  different hardware needs different
>>solutions.  How would those calls make dma_alloc_coherent work?
> 
> 
> 
> The statement was "That's dma_alloc_coherent at its core ... it should
> allocate from that 32K region." and what I was pointing out is that not
> all platforms can treat an on-chip memory region as a real memory area. 

But this one can, and it sure seems like the appropriate
solution.  For reasons like the one not quoted above:  it's
a good way to eliminate what would otherwise be a case
where a dmabounce is needed.  And hey wow, it even uses
the API designed to reduce such DMA "mapping" costs, and
there are drivers already using it for such purposes.


> That's why we have the iomem accessor functions.

You mentioned ioremap(), which doesn't help here since
the need is for a block of memory, not just address space,
and also memcpy_toio(), which just another tool to implement
the dma bouncing (which is on the "strongly avoid!" list).

As I said, those still don't make dma_alloc_coherent() work.

- Dave


> James
> 
> 
> 


