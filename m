Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290423AbSAPLz1>; Wed, 16 Jan 2002 06:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290425AbSAPLzU>; Wed, 16 Jan 2002 06:55:20 -0500
Received: from gnu.in-berlin.de ([192.109.42.4]:4868 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S290423AbSAPLzF>;
	Wed, 16 Jan 2002 06:55:05 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 16 Jan 2002 10:57:47 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory problem with bttv driver
Message-ID: <20020116105747.B1190@bytesex.org>
In-Reply-To: <20020114210039.180c0438.skraw@ithnet.com> <E16QETz-0002yD-00@the-village.bc.nu> <20020115004205.A12407@werewolf.able.es> <slrna480cv.68d.kraxel@bytesex.org> <20020115121424.10bb89b2.skraw@ithnet.com> <20020115142017.D8191@bytesex.org> <20020115161653.A9550@bytesex.org> <20020115173551.5a3fc051.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020115173551.5a3fc051.skraw@ithnet.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Yes.  Instead of remapping vmalloced kernel memory it gives you shared
> > > > anonymous pages, then does zerocopy DMA using kiobufs.  You may run in
> > > > trouble with >4GB machines.
> > > 
> > > Interesting.
> > > What's the problem on > 4GB ?
> > 
> > The bt878/848 is a 32bit PCI device, it simply can't go DMA to main
> > memory above 4GB.  At least on ia32, on architecures with a iommu
> > (sparc, ...) it should work without trouble.
> 
> Sorry, maybe I should have clarified: what is the problem with allocating those
> pages below 4GB in a >4GB box?

do_anonymous_page() may give you pages above 4GB.  Need to write my own
nopage handler to fix this.

  Gerd

-- 
#define	ENOCLUE 125 /* userland programmer induced race condition */
