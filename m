Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbTI3WDu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 18:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbTI3WDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 18:03:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:14546 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261733AbTI3WDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 18:03:47 -0400
Date: Tue, 30 Sep 2003 14:43:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: arun.sharma@intel.com, linux-kernel@vger.kernel.org, kevin.tian@intel.com,
       willy@debian.org
Subject: Re: [PATCH] incorrect use of sizeof() in ioctl definitions
Message-Id: <20030930144313.601a4655.akpm@osdl.org>
In-Reply-To: <20030930223531.B10154@flint.arm.linux.org.uk>
References: <3F79ED60.2030207@intel.com>
	<20030930140805.0e3158e7.akpm@osdl.org>
	<20030930223531.B10154@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> wrote:
>
> >  /* out param: u32*	backlight value: 0 to 15 */
> > -#define FBIO_ATY128_GET_MIRROR	_IOR('@', 1, sizeof(__u32*))
> > +#define FBIO_ATY128_GET_MIRROR	_IOR('@', 1, __u32*)
> >  /* in param: u32*	backlight value: 0 to 15 */
> > -#define FBIO_ATY128_SET_MIRROR	_IOW('@', 2, sizeof(__u32*))
> > +#define FBIO_ATY128_SET_MIRROR	_IOW('@', 2, __u32*)
> >  
> >  static int aty128fb_ioctl(struct inode *inode, struct file *file, u_int cmd,
> >  			  u_long arg, struct fb_info *info)
> > 
> > 
> > Matthew's conversion mainly converted things to size_t, but from the looks
> > of it, __u32* is the right thing to use in this case, I think?
> 
> sizeof(__u32*) may not be sizeof(sizeof(__u32*)), so this would be an API
> change...  Therefore, all these wrong entries need to change to size_t
> (preferably with the real type following inside a comment so we don't
> loose useful information.)

In that case I'm going to need a bit of education as to what the whole
thing is trying to do.

If FBIO_ATY128_SET_MIRROR is really supposed to be passing a pointer into
the ioctl then we *want* the encoded ioctl number to be different for
32-bit-compiled userspace and 64-bit-compiled userspace, don't we?

