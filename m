Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262997AbTIRHJL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 03:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262998AbTIRHJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 03:09:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:44441 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262997AbTIRHJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 03:09:08 -0400
Date: Thu, 18 Sep 2003 09:08:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Olivier Galibert <galibert@limsi.fr>,
       Stephan von Krawczynski <skraw@ithnet.com>, neilb@cse.unsw.edu.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-ID: <20030918070845.GS906@suse.de>
References: <20030917191946.GQ906@suse.de> <Pine.LNX.4.44.0309171629520.3994-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309171629520.3994-100000@logos.cnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17 2003, Marcelo Tosatti wrote:
> 
> 
> On Wed, 17 Sep 2003, Jens Axboe wrote:
> 
> > On Wed, Sep 17 2003, Alan Cox wrote:
> > > On Maw, 2003-09-16 at 20:58, Olivier Galibert wrote:
> > > > On Tue, Sep 16, 2003 at 04:29:02PM +0100, Alan Cox wrote:
> > > > > The kernel has no idea what you will do with given ram. It does try to
> > > > > make some guesses but you are basically trying to paper over hardware
> > > > > limits.
> > > > 
> > > > Is there a way to specifically turn that ram into a tmpfs though?
> > > 
> > > 
> > > Something like z2ram copied and hacked a little to kmap the blocks it
> > > wants would give you a block device you could use for swap or for /tmp.
> > > Im not sure tmpfs would work here
> > 
> > Aditionally, you need GFP_DMA32 or similar. Would also alleviate the
> > nasty pressure on ZONE_NORMAL which is often quite stressed.
> 
> IMO such GFP_DMA32 flag is a bit intrusive for 2.4, isnt it?

Not really, it's just an extra zone. Maybe I can dig such a patch up, I
had one for 2.4.2-pre something...

> What has been done in 2.6 in respect to the excessive normal zone 
> pressure and bounce buffering problems? 

Nothing, afaic. 2.6 isn't even completely deadlock free when it comes to
bounce buffering.

-- 
Jens Axboe

