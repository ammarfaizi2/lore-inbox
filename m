Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264847AbTIDKGW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 06:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264846AbTIDKGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 06:06:22 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:36580 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264847AbTIDKGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 06:06:21 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "David S. Miller" <davem@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Paul Mackerras <paulus@samba.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030904092834.A27774@infradead.org>
References: <20030904010940.5fa0e560.davem@redhat.com>
	 <Pine.LNX.4.44.0309040111290.20151-100000@home.osdl.org>
	 <20030904011010.21857a1c.davem@redhat.com>
	 <20030904092834.A27774@infradead.org>
Message-Id: <1062669964.1780.66.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 04 Sep 2003 12:06:04 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-04 at 10:28, Christoph Hellwig wrote:
> On Thu, Sep 04, 2003 at 01:10:10AM -0700, David S. Miller wrote:
> > What we could do in the interim is create an ioremap_resource()
> > and then move things over gradually.
> 
> ioremap_resource() looks like a fine idea.  It's cleaner, easily
> emulateable on <= 2.4 and solves the problem this hack wanted to
> work around properly.
> 
> This still doesn't make the phys_addr_t a good interims solution,
> though.  Just use ioremap_resource from the beginning for those
> drivers that care for the bigger address space on ppc44x.
> 
> Paul, what does actually use this higher addresses?

The great thing with ioremap_resource() is that we can make it work
for PCI IO as well as MMIO and slowly get rid of anything tapping
ports without first ioremapp'ing them. That would help some platforms
with bazillons PCI busses as well so in the end, we don't have to
keep the whole PCI IO space of those machines ioremapped all the time,
this is especially useful on 32 bits archs where we can run short on
virtual space easily.

At first, it would just "do nothing" for PCI IO (just return the same
token), and once enough drivers have been ported, the arch can decide
to change the inx/outx implementation to rely on ioremap_resource
doing the actual mapping.

Ben.


