Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVACOKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVACOKH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 09:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVACOKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 09:10:06 -0500
Received: from [213.146.154.40] ([213.146.154.40]:4584 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261366AbVACOJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 09:09:43 -0500
Date: Mon, 3 Jan 2005 14:09:38 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Patrick Gefre <pfg@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       matthew@wil.cx
Subject: Re: [PATCH] 2.6.10 Altix : ioc4 serial driver support
Message-ID: <20050103140938.GA20070@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org,
	matthew@wil.cx
References: <200412220028.iBM0SB3d299993@fsgi900.americas.sgi.com> <20041222134423.GA11750@infradead.org> <41C9D0B8.9000208@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C9D0B8.9000208@sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 01:53:28PM -0600, Patrick Gefre wrote:
> Christoph Hellwig wrote:
> 
> >So both claim the same PCI ID?  In this case you need to creat a small
> >shim driver that exports a pseudo-bus to the serial and ide driver using
> >the driver model.  You must never return an error from ->probe if you
> >actually use that particular device.
> >
> 
> Has this been done before ? Any example I can use ??

Well, just about any secondary bus (e.g. usb, iee1394, i2c) works that way,
but I guess all those examples are a little too complicated for your example.
the PPC OCP stuff might be a better example as it's an on-chip pseudo-bus,
otoh it's a top-level bus and not parented by PCI.

> >The second argumnet to writeX (and readX) is actually void __iomem *,
> >but to see the difference you need to run sparse (from sparse.bkbits.net)
> >over the driver.  Please store all I/O addresses in void __iomem * pointers
> >in your structures and avoid the cast here and in all the other places.
> >
> 
> So then I'd have to declare the end elements as:
> void __iomem foo;
> 
> They are 32 bit values, so it's OK to assume that void __iomem is 32bits ?

Hmm?  void __iomem must only ever be used as a pointer and passed to
readX/writeX.  Pointer arithmetics are allowed and it's treated equally
to char * for that (GCC extension)

> >no need to cast the return value from kmalloc (dito for the other places)
> >
> 
> Why is that ? Seems if kmalloc returns a void * and the left side is not, a 
> casting is appropriate ?

void * is magic in C and can be assigned to any pointer and vice versa.

