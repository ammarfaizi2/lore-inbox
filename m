Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267408AbUITXjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267408AbUITXjd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 19:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUITXjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 19:39:33 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:8116 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267388AbUITXj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 19:39:29 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Matthew Wilcox <willy@debian.org>
Subject: Re: Documentation/io_ordering.txt is wrong
Date: Mon, 20 Sep 2004 16:39:13 -0700
User-Agent: KMail/1.7
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>, pj@sgi.com,
       linux-scsi@vger.kernel.org, mdr@cthulhu.engr.sgi.com,
       jeremy@cthulhu.engr.sgi.com, djh@cthulhu.engr.sgi.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040917183029.GW642@parcelfarce.linux.theplanet.co.uk> <20040918061001.GC21456@colo.lackof.org> <20040918175714.GD642@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040918175714.GD642@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409201639.13533.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, September 18, 2004 10:57 am, Matthew Wilcox wrote:
> On Sat, Sep 18, 2004 at 12:10:01AM -0600, Grant Grundler wrote:
> > Jesse Barnes wrote:
> > ...
> >
> > > Btw Andrew (Vasquez), there's a small doc I put together that should
> > > describe when you have to worry about PCI posting.  It's in the tree:
> > > Documentation/io_ordering.txt.  If it's incomplete or confusing, just
> > > let me know and I'll update it.
> >
> > Jesse,
> > Both. incomplete and confusing.
> > "concrete example of a hypothetical driver" wasn't my first warning
> > this document needed work. :^)
>
> Not just incomplete and confusing, but actively wrong.  spin_lock/
> spin_unlock should imply ordering of readb().  What you're describing
> there is __readb().  See Documentation/DocBook/deviceiobook.tmpl.  Also,
> rmb() should ensure ordering of io reads; there should be no need to
> touch the device.

I already sent a reply to this, so you now know that I was wrong in describing 
the ordering issue as one of weak ordering, rather it's just supposed to be 
describing simple write posting.  Also, the first sample code is incorrect, 
since the second spinlock protected region has a read before a write and 
incorrectly states that the second write may arrive before the first.  I 
think Grant has some updates, if not I'll post a patch to fixup the doc.

Thanks,
Jesse
