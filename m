Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752297AbWFME5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297AbWFME5E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 00:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbWFME5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 00:57:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:56470 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752294AbWFME5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 00:57:01 -0400
From: Andi Kleen <ak@suse.de>
To: David Miller <davem@davemloft.net>
Subject: Re: Using netconsole for debugging suspend/resume
Date: Tue, 13 Jun 2006 06:54:14 +0200
User-Agent: KMail/1.9.3
Cc: jeremy@goop.org, lkml@rtr.ca, mpm@selenic.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <200606121746.34880.ak@suse.de> <200606130547.49624.ak@suse.de> <20060612.214948.124554804.davem@davemloft.net>
In-Reply-To: <20060612.214948.124554804.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606130654.14477.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 June 2006 06:49, David Miller wrote:
> From: Andi Kleen <ak@suse.de>
> Date: Tue, 13 Jun 2006 05:47:49 +0200
> 
> > I've been playing with the idea of writing "early1394" that just
> > turns the DMA controller on as early as possible similar to earlyprintk
> > on the target. Then it would be possible to use it for early
> > debugging too. But so far it's not done yet.
> 
> Does this raw1394 thing with firescope just assume DMA address ==
> physical address? 

Yes.

> How would it work to access all of physical 
> memory properly on IOMMU platforms?

It assumes you don't have an IOMMU - relies on all memory
being accessible by ohci1394. On x86-64 it can't access > 4GB 
also, but that's normally ok because the kernel log buffer
is below that.

I guess if you use 1394 with remote DMA for other protocols (like
video etc.) there must be some way for the subsystem to map
the memory even on IOMMU systems. I admit I haven't dived that
deeply into the 1394 subsystem so I don't know how that works.

-Andi

