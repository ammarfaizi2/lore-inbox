Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbTIZJiW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 05:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbTIZJiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 05:38:22 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:7888 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S262036AbTIZJiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 05:38:21 -0400
Subject: Re: [PATCH] s390 (2/19): common i/o layer.
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF5495CCE6.2AE96924-ONC1256DAD.003484EC-C1256DAD.0034D0EC@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Fri, 26 Sep 2003 11:36:53 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 26/09/2003 11:37:31
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +static inline void
> > +__ccwgroup_remove_symlinks(struct ccwgroup_device *gdev)
> > +{
> > +        int i;
> > +        char str[8];
> > +
> > +        for (i = 0; i < gdev->count; i++) {
> > +                    sprintf(str, "cdev%d", i);
> > +                    sysfs_remove_link(&gdev->dev.kobj, str);
> > +                    /* Hack: Make sure we act on still valid subdirs.
*/
> > +                    if (atomic_read(&gdev->cdev[i]
->dev.kobj.dentry->d_count))
> > +                                sysfs_remove_link(&gdev->cdev[i]
->dev.kobj,
> > +
"group_device");
> > +        }
>
> This looks like you have a bad refcounting problem somewhere.  I'd rather
> see it fixed than hacked around..

Now that you point this out, this really does look suspicious. Either the
link
needs to get remove or it doesn't. If we have to remove it then we need a refcount
on the group device so that we can safely do it. I'll hit the apropriate developer.

blue skies,
   Martin


