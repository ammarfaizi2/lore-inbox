Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbVAJXG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbVAJXG0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 18:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262616AbVAJXGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 18:06:23 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:42420 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262612AbVAJXDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 18:03:39 -0500
To: Michael.Waychison@Sun.COM
CC: miklos@szeredi.hu, akpm@osdl.org, torvalds@osdl.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <41E2FF3F.8070307@sun.com> (message from Mike Waychison on Mon,
	10 Jan 2005 17:18:39 -0500)
Subject: Re: [PATCH 4/11] FUSE - read-only operations
References: <E1Co4o8-00046I-00@dorka.pomaz.szeredi.hu> <41E2FF3F.8070307@sun.com>
Message-Id: <E1Co8Z8-0004iw-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Jan 2005 00:03:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +static inline unsigned long time_to_jiffies(unsigned long sec,
> > +					    unsigned long nsec)
> > +{
> > +	/* prevent wrapping of jiffies */
> > +	if (sec + 1 >= LONG_MAX / HZ)
> > +		return 0;
> > +
> > +	return jiffies + sec * HZ + nsec / (1000000000 / HZ);
> > +}
> 
> Use timespec_to_jiffies ?

OK.

> > +
> > +	req = fuse_get_request(fc);
> > +	if (!req)
> > +		return -ERESTARTNOINTR;
> 
> Is this trying to restart the action over and over if the system is low
> on memory?

No, memory is not allocated in fuse_get_request().  Rather it returns
an unused preallocated request.  If there are no unused requests it
will block.  If interrupted it will return NULL.

> This else clause would be better to use vfs_permission().

Later patch will introduce mount option that does exactly this.  The
default behavior is deliberately more liberal than
generic_permission().

> > +	link = read_link(dentry);
> > +	ret = vfs_follow_link(nd, link);
> > +	free_link(link);
> > +	return ret;
> > +}
> 
> If you don't have to do magic for follow_link, please use the recently
> added interface that is stack friendly.  See:
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc1/2.6.7-rc1-mm1/broken-out/SL0-core-RC6-bk5.patch

OK.  I didn't know this.

Thanks,
Miklos
