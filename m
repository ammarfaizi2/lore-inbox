Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbVHQJQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbVHQJQm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 05:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbVHQJQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 05:16:42 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:32011 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751013AbVHQJQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 05:16:41 -0400
To: hch@infradead.org
CC: kumar.gala@freescale.com, davem@davemloft.net, paulus@samba.org,
       galak@freescale.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, zach@vmware.com
In-reply-to: <20050817090920.GA12716@infradead.org> (message from Christoph
	Hellwig on Wed, 17 Aug 2005 10:09:20 +0100)
Subject: Re: [PATCH] ppc32: removed usage of <asm/segment.h>
References: <20050816.203312.77701192.davem@davemloft.net> <032E6AED-9456-4271-9B06-C5DCE5970193@freescale.com> <20050817083048.GA11892@infradead.org> <E1E5Jii-0004Yc-00@dorka.pomaz.szeredi.hu> <20050817090920.GA12716@infradead.org>
Message-Id: <E1E5K1L-0004bH-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 17 Aug 2005 11:15:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > There are perfectly valid uses of kernel headers from userspace.  For
> > example if a program uses the netlink interface, it should include
> > <linux/netlink.h>.  It's the interface definition after all.
> > 
> > Glibc headers also include <linux/*> and <asm/*> in quite few places.
> 
> But these files in /usr/include/ aren't provided by the kernel anymore.

They are provided by _one_ kernel, not necessarily the running kernel.

That doesn't make them any less a kernel header.

So if some userspace program depends on header <linux/x.h> to get the
interface definition for feature x, and you remove <linux/x.h> from
the current kernel, it _will_ break the userspace program some time
later, when glibc picks up the new kernel.

Having said that that, <asm/segment.h> may or may not be validly
exported to userspace.

Miklos
