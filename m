Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266019AbUAVPXb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 10:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265815AbUAVPXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 10:23:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5270 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266019AbUAVPTo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 10:19:44 -0500
Date: Thu, 22 Jan 2004 15:19:43 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-rc1-mm1
Message-ID: <20040122151943.GW21151@parcelfarce.linux.theplanet.co.uk>
References: <20040122013501.2251e65e.akpm@osdl.org> <20040122110342.A9271@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040122110342.A9271@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 11:03:42AM +0000, Christoph Hellwig wrote:
> > sysfs-class-06-raw.patch
> >   From: Greg KH <greg@kroah.com>
> >   Subject: [PATCH] add sysfs class support for raw devices [06/10]
> 
> This one exports get_gendisk, which is a no-go.

Moreover, it obviously leaks references to struct gendisk _and_ changes
semantics of RAW_SETBIND in incompatible way.

Consider that vetoed.  And yes, get_gendisk() issue alone would be enough.

Greg, please, RTFS to see at which point do we decide which driver will
be used by raw device.  It's _not_ RAW_SETBIND, it's open().  So where
your symlink should point is undecided until the same point.
