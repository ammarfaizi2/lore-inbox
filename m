Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422673AbWIGXBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422673AbWIGXBm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422684AbWIGXBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:01:41 -0400
Received: from cantor2.suse.de ([195.135.220.15]:1944 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422673AbWIGXBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:01:40 -0400
Date: Thu, 7 Sep 2006 16:01:30 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>
Subject: Re: Naughty ramdrives
Message-ID: <20060907230130.GA9289@kroah.com>
References: <20060907205927.GA5193@martell.zuzino.mipt.ru> <20060907145412.db920bb5.akpm@osdl.org> <20060907220852.GA5192@martell.zuzino.mipt.ru> <20060907152037.a4e1437b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060907152037.a4e1437b.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 03:20:37PM -0700, Andrew Morton wrote:
> On Fri, 8 Sep 2006 02:08:53 +0400
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > > So I assume udev is still madly crunching on its message backlog while
> > > this is happening?
> > >
> > > If so, ug.
> > 
> > OK. I'll let it stabilize, sorry.
> 
> You shouldn't have to.

You shouldn't have to what?  You purposefully add and remove a block
driver as fast as is possible, creating a ton of new events and you
expect userspace processing of those events to be able to keep up in
real-time with it?

On the later versions of udev we are _way_ faster, we only listen to the
netlink socket, no extra programs are spawned, but still, we can only
work so fast :)

My machine had no interactive response issues while this was happening,
even with both processors being run at 100% cpu usage until I stoped the
loop and then udev recovered a few seconds later.  This is even with
HALD recieving all of these events from udev, remember it's not just
udev in the event processing chain.

thanks,

greg k-h
