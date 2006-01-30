Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbWA3XP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWA3XP3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 18:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbWA3XP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 18:15:29 -0500
Received: from lixom.net ([66.141.50.11]:19426 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S964925AbWA3XP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 18:15:28 -0500
Date: Tue, 31 Jan 2006 10:13:48 +1100
To: Mark Haverkamp <markh@osdl.org>
Cc: Olof Johansson <olof@lixom.net>,
       "linuxppc64-dev@ozlabs.org" <linuxppc64-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, moilanen@austin.ibm.com,
       james.smart@emulex.com
Subject: Re: iommu_alloc failure and panic
Message-ID: <20060130231348.GC9368@pb15.lixom.net>
References: <1138381060.11796.22.camel@markh3.pdx.osdl.net> <20060127204022.GA26653@pb15.lixom.net> <1138401590.11796.26.camel@markh3.pdx.osdl.net> <20060127233443.GB26653@pb15.lixom.net> <1138635178.5150.1.camel@markh3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138635178.5150.1.camel@markh3.pdx.osdl.net>
User-Agent: Mutt/1.5.9i
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 07:32:58AM -0800, Mark Haverkamp wrote:
> On Sat, 2006-01-28 at 12:34 +1300, Olof Johansson wrote:
> > On Fri, Jan 27, 2006 at 02:39:50PM -0800, Mark Haverkamp wrote:
> > 
> > > I would have thought that the npages would be 1 now.
> > 
> > No, npages is the size of the allocation coming from the driver, that
> > won't chance. The table blocksize just says how wide the cacheline size
> > is, i.e. how far it should advance between allocations.
> > 
> > This is a patch that should probably have been added a while ago, to
> > give a bit more info. Can you apply it and give it a go?
> > 
> > 
> > Thanks,
> > 
> > Olof
> > 
> 
> 
> Here are the last few lines of the log before it crashed.
> 
> 
> Jan 30 07:29:14 linux kernel: table size 10000 used f752

Ok, that's a 256MB table, which is standard, and it seems to have been
filled with mappings. in some cases there's a few entries left but it's
likely that fragmentation causes the 10-entry alloc to fail, quite
normal.

There's two things to look at, unfortunately I fall short on both of
them myself:

1) There's a way to get more than the default 256MB DMA window for a PCI
slot. I'm not aware of the exact details, but you need recent firmware
and you configure it in the ASM menues (the web interface for the
service processor). Cc:ing Jake Moilanen in case he has any more up to
date info.

2) The emulex driver has been prone to problems in the past where it's
been very aggressive at starting DMA operations, and I think it can
be avoided with tuning. What I don't know is if it's because of this,
or simply because of the large number of targets you have. Cc:ing James
Smart.


-Olof
