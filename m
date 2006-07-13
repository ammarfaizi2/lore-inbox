Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030399AbWGMV1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030399AbWGMV1K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 17:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbWGMV1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 17:27:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15051 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030399AbWGMV1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 17:27:08 -0400
Date: Thu, 13 Jul 2006 14:27:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Tim Pepper" <lnxninja@us.ibm.com>
Cc: viro@ftp.linux.org.uk, hpa@zytor.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] symlink nesting level change
Message-Id: <20060713142702.9b1f7c61.akpm@osdl.org>
In-Reply-To: <eada2a070607131135k7e361132t957bfbb78f341cc2@mail.gmail.com>
References: <14CFC56C96D8554AA0B8969DB825FEA0012B309B@chicken.machinevisionproducts.com>
	<44580CF2.7070602@tlinx.org>
	<e3966u$dje$1@terminus.zytor.com>
	<20060503030849.GZ27946@ftp.linux.org.uk>
	<20060503183554.87f0218d.akpm@osdl.org>
	<eada2a070607131135k7e361132t957bfbb78f341cc2@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006 11:35:28 -0700
"Tim Pepper" <lnxninja@us.ibm.com> wrote:

> On 5/3/06, Andrew Morton <akpm@osdl.org> wrote:
> > On Wed, 3 May 2006 04:08:49 +0100
> > Al Viro <viro@ftp.linux.org.uk> wrote:
> >
> > > No.  It's way past time to bump it to 8.  Everyone had been warned - for
> > > months now.
> > >
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > ----
> > > --- a/include/linux/namei.h   2006-03-31 20:08:42.000000000 -0500
> > > +++ b/include/linux/namei.h   2006-05-02 23:06:46.000000000 -0400
> > > @@ -11,7 +11,7 @@
> > >       struct file *file;
> > >  };
> > >
> > > -enum { MAX_NESTED_LINKS = 5 };
> > > +enum { MAX_NESTED_LINKS = 8 };
> > >
> > >  struct nameidata {
> > >       struct dentry   *dentry;
> >
> > It's a non-back-compatible change which means that people will install
> > 2.6.18+, will set stuff up which uses more that five nested links and some
> > will discover that they can no longer run their software on older kernels.
> >
> > It'll only hurt a very small number of people, but for those people, it
> > will hurt a lot.  And I can't really think of anything we can do to help
> > them, apart from making the new behaviour runtime-controllable, defaulting
> > to "off", but add a once-off printk when we hit MAX_NESTED_LINKS, pointing
> > them at a document which tells them how to turn on the new behaviour and
> > which explains the problems.  Which sucks.
> >
> > But I guess as major distros are 2.6.16-based, this is a good time to make
> > this change.
> 
> Doesn't look like this ended up in 2.6.18-rc nor -mm.  The email
> thread in May was tending towards finally bumping it.  Major distros
> already have it at 8 for a long time.  Is there any reason left (aside
> now from possibly waiting until 2.6.19's window?) to wait?

hm, thanks, it fell through a crack.  I queued it.

Given that distros are already shipping this, I guess we should do this
asap (ie: 2.6.18), to keep the various Linuxes out there in sync.
