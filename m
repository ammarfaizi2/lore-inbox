Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267291AbUIEWLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267291AbUIEWLc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 18:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267294AbUIEWLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 18:11:32 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:42140 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267291AbUIEWL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 18:11:29 -0400
Message-ID: <9e4733910409051511148d74f0@mail.gmail.com>
Date: Sun, 5 Sep 2004 18:11:25 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New proposed DRM interface design
Cc: Keith Whitwell <keith@tungstengraphics.com>, Dave Jones <davej@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@yahoo.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mharris@redhat.com
In-Reply-To: <1094417612.1936.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040904102914.B13149@infradead.org>
	 <4139C8A3.6010603@tungstengraphics.com>
	 <9e47339104090408362a356799@mail.gmail.com>
	 <4139FEB4.3080303@tungstengraphics.com>
	 <9e473391040904110354ba2593@mail.gmail.com>
	 <1094386050.1081.33.camel@localhost.localdomain>
	 <9e47339104090508052850b649@mail.gmail.com>
	 <1094398257.1251.25.camel@localhost.localdomain>
	 <9e47339104090514122ca3240a@mail.gmail.com>
	 <1094417612.1936.5.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the advantage to continuing a development model where two
groups of programmers work independently, with little coordination on
two separate code bases trying to simultaneously control the same
piece of hardware? This is a continuous source of problems. Why can't
we fix the development model to stop this?

On Sun, 05 Sep 2004 21:53:41 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Sul, 2004-09-05 at 22:12, Jon Smirl wrote:
> > Sure you can use this to get around both fbdev and DRM trying to claim
> > the resource. But it doesn't help at all to fix the problem that fbdev
> > and DRM are programming the radeon chip in conflicting ways.
> 
> Once you have the common structure the rest of the problems go away
> rather nicely over time.
> 
> > What is so awful about merging the code? I'm the one doing the all of
> > the work. I intend to use 95% of the code extracted from fbdev without
> > change. I'm not getting rid of fbdev capability in the merged code,
> > I'm just coordinating use of the hardware.
> 
> It doesn't solve the problem. That is the fundamental part of it. I can
> put the code in the same place or in different places, the problem you
> have to fix is co-ordination, and when you fix that not suprisingly you
> still don't care where the code lives.
> 
> Create a top level video device object to hold dri and fb info pointers.
> End of problem #1. Make that top level video object the one which is
> handling the pci device irrespective of DRI/fb loading first. You've now
> solved the load order problem. Make DRI tell fb about display layout in
> X and provide sync functions. You've now solved the Oops problem.
> 
> After that you can begin to worry about dual head and memory management
> which is a *lot* harder than you seem to realise and much of which
> cannot be done user space side for performance reasons.
> 
> Alan
> 
> 



-- 
Jon Smirl
jonsmirl@gmail.com
