Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269612AbTGZUfG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 16:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269619AbTGZUfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 16:35:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:27363 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269612AbTGZUfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 16:35:02 -0400
Date: Sat, 26 Jul 2003 13:50:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 devfs question
Message-Id: <20030726135012.6386c185.akpm@osdl.org>
In-Reply-To: <200307262351.33808.arvidjaar@mail.ru>
References: <200307262351.33808.arvidjaar@mail.ru>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov <arvidjaar@mail.ru> wrote:
>
> > Is the problem simply that the device has moved from /dev/md1 to /dev/md/1?
> > If so, is this change sufficient?
> >
> > diff -puN drivers/md/md.c~a drivers/md/md.c
> > --- 25/drivers/md/md.c~a        2003-07-26 11:24:58.000000000 -0700
> > +++ 25-akpm/drivers/md/md.c     2003-07-26 11:25:15.000000000 -0700
> > @@ -3505,7 +3505,7 @@ int __init md_init(void)
> >         for (minor=0; minor < MAX_MD_DEVS; ++minor) {
> >                 devfs_mk_bdev(MKDEV(MAJOR_NR, minor),
> >                                 S_IFBLK|S_IRUSR|S_IWUSR,
> > -                               "md/%d", minor);
> > +                               "md%d", minor);
> >         }
> 
> should not such things be done by devfsd in user space?

Darned if I know - I do not have operational experience with devfs.

> This patch makes it even more incompatible with 2.4 ...

The patch is broken - 2.4 does /dev/md/2 as well.

So what is the bug?  Why are people suddenly having problems with this?
