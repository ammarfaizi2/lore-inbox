Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263785AbTEYWG5 (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 18:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263787AbTEYWG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 18:06:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13710 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263785AbTEYWG4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 18:06:56 -0400
Date: Sun, 25 May 2003 23:20:06 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
   "David S. Miller" <davem@redhat.com>
Subject: Re: netlink init order
Message-ID: <20030525222005.GK6270@parcelfarce.linux.theplanet.co.uk>
References: <20030525220709.GJ6270@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0305251511140.1741-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305251511140.1741-100000@home.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 25, 2003 at 03:12:28PM -0700, Linus Torvalds wrote:
> 
> On Sun, 25 May 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> >
> > BTW, is there any reason why init_netlink_dev() is not a module_init()?

Grr... init_netlink(), that is.

> Probably not. I don't know if the thing even makes sense without a user 
> space, which definitely implies that it shouldn't be a "core" initcall.
> 
> Even more true as it seems to depend on other core subsystems already 
> being initialized.
> 
> Davem? Who uses this thing?

After looking at the code in question, I _really_ doubt that other initcalls
might rely on it.  It does
	* register character device
	* create a /dev/netlink (on devfs) and a bunch of entries there.

That's it.  Unless we have some initcall code that cares to mount devfs
and open files on it (or does such mknod on rootfs and opens the result)...
