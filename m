Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbVIXF4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbVIXF4s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 01:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbVIXF4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 01:56:48 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:43026 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751439AbVIXF4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 01:56:47 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <20050923142758.641189f2.akpm@osdl.org> (message from Andrew
	Morton on Fri, 23 Sep 2005 14:27:58 -0700)
Subject: Re: [PATCH 3/3] fuse: check O_DIRECT
References: <E1EIoQZ-0006Rz-00@dorka.pomaz.szeredi.hu> <20050923142758.641189f2.akpm@osdl.org>
Message-Id: <E1EJ31V-0007TB-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 24 Sep 2005 07:56:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	/* VFS checks this, but only _after_ ->open() */
> > +	if (file->f_flags & O_DIRECT)
> > +		return -EINVAL;
> > +
> >  	err = generic_file_open(inode, file);
> >  	if (err)
> >  		return err;
> 
> This hardly seems worth optimising for?

It could be a correctness issue too: if filesystem has open() with
side effect, then it should fail before doing the open, not after.

Not a big deal, but I think it's worth the 3 lines.

Miklos
