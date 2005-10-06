Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbVJFRcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbVJFRcP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 13:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbVJFRcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 13:32:14 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:34566 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751256AbVJFRcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 13:32:14 -0400
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1128619526.16534.8.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Thu, 06 Oct 2005 13:25:26 -0400)
Subject: Re: [RFC] atomic create+open
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
	 <1128616864.8396.32.camel@lade.trondhjem.org>
	 <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
	 <E1ENZCQ-0003K3-00@dorka.pomaz.szeredi.hu> <1128619526.16534.8.camel@lade.trondhjem.org>
Message-Id: <E1ENZZl-0003OO-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 06 Oct 2005 19:30:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > The reason why we do it as a lookup intent is because this has to be
> > > atomic lookup+create+open in order to be at all useful to NFS.
> > 
> > Oh, and btw there's a problem with atomic lookup+create+open: mounts.
> > Do you want to follow mounts inside ->lookup().  Ugly.
> 
> No. Why do you think you would need to? The VFS is supposed to protect
> you against races with mount and other local objects (dcache races,
> inode races,...). The problem is remote objects.

Say you have NFS mount on /mnt and a bind mount over the regular file
/mnt/foo.  You do open("/mnt/foo", O_RDWR | O_CREAT, 0644).  How do
you solve the atomic open case.

If you open in ->lookup("foo") you will be opening the wrong file,
unless you want to follow mounts inside ->lookup.

Miklos
