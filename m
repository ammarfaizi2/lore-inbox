Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267383AbUIFBjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267383AbUIFBjM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 21:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267385AbUIFBjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 21:39:12 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:12808 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267383AbUIFBi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 21:38:29 -0400
Message-ID: <9e47339104090518387bdf2d0a@mail.gmail.com>
Date: Sun, 5 Sep 2004 21:38:28 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: multi-domain PCI and sysfs
Cc: Matthew Wilcox <willy@debian.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200409051706.50455.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e4733910409041300139dabe0@mail.gmail.com>
	 <200409041603.56324.jbarnes@engr.sgi.com>
	 <20040905230425.GU642@parcelfarce.linux.theplanet.co.uk>
	 <200409051706.50455.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another way to look at this would be to create one vga device per
domain. I could then hook the vga=0/1 attribute off from this device
and avoid the problem of creating domain nodes under /sys/devices


On Sun, 5 Sep 2004 17:06:50 -0700, Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> On Sunday, September 5, 2004 4:04 pm, Matthew Wilcox wrote:
> > On Sat, Sep 04, 2004 at 04:03:56PM -0700, Jesse Barnes wrote:
> > > On Saturday, September 4, 2004 3:45 pm, Jon Smirl wrote:
> > > > Is this a multipath configuration where pci0000:01 and pci0000:02 can
> > > > both get to the same target bus? So both busses are top level busses?
> > > >
> > > > I'm trying to figure out where to stick the vga=0/1 attribute for
> > > > disabling all the VGA devices in a domain. It's starting to look like
> > > > there isn't a single node in sysfs that corresponds to a domain, in
> > > > this case there are two for the same domain.
> > >
> > > Yes, I think that's the case.  Matthew would probably know for sure
> > > though.
> >
> > Huh, eh, what?  There's no such thing as multipath PCI configurations.
> > The important concepts in PCI are:
> 
> Right, but I was answering his question about whether or not there was a place
> to stick his 'vga' control file on a per-domain basis.  There would be if the
> layout was something like this:
> 
> /sys/devices/pciDDDD/BB/SS.F/foo
> rather than the current
> /sys/devices/pciDDDD:BB/DDDD:BB:SS.F/foo
> 
> > I haven't really looked at the VGA attribute.  I think Ivan or Grant
> > would be better equipped to help you on this front.  I remember them
> > rehashing it 2-3 years ago.
> 
> I'm actually ok with a system wide vga arbitration driver, assuming that we'll
> never have to worry about the scalability of stuff that wants to do legacy
> vga I/O.
> 
> Thanks,
> Jesse
> 
> 



-- 
Jon Smirl
jonsmirl@gmail.com
