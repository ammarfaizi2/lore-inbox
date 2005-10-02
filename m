Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbVJBXFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbVJBXFa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 19:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbVJBXFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 19:05:30 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:47342 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750897AbVJBXFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 19:05:30 -0400
Date: Sun, 2 Oct 2005 15:34:22 -0400
From: Christopher Li <usb-devel@chrisli.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Christopher Li <chrisl@vmware.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH] incrase usbdevfs bulk buffer size
Message-ID: <20051002193422.GH3453@64m.dyndns.org>
References: <20051001202059.GE3453@64m.dyndns.org> <20051002150829.35107f91.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051002150829.35107f91.zaitcev@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2005 at 03:08:29PM -0700, Pete Zaitcev wrote:
> On Sat, 1 Oct 2005 16:20:59 -0400, Christopher Li <chrisl@vmware.com> wrote:
> 
> > I hit this limit with running ehci in the VM. The a single ehci
> > qTD transfer buffer can be 5 pages long, that is 20K. [...]
> 
> Even 16K is too much, IMHO.
> 
> > I can complicate the user space part to work around that,
> > but it seems much simpler just allow usbdevfs to accept bigger buffers.
> 
> It seems, yes. However, I assure you that this is not going to
> work for anyone who has anything reasonable swapped out, because
> of the kmalloc().
> 
> 16K is an order 2 allocation on systems with 4KB pages, such as
> Opteron. It kinda sorta works, but not really.
> 
> This looks like a requirement to think about a better API. Also,

I think the API is kind of fine in this aspect. The usbdevfs should be
able to take bigger than 16K, but the internal copy of the urb does not
have to use kmalloc on data buffers.

> the things that Harald was trying to fix, with pids and signals,
> just tell me that something was really wrong from the start.

More detail please?

Chris
