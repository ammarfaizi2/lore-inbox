Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932639AbVJGOGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbVJGOGp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbVJGOGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:06:45 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:10249 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932634AbVJGOGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:06:44 -0400
To: trond.myklebust@fys.uio.no
CC: akpm@osdl.org, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org
In-reply-to: <1128693175.8519.84.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Fri, 07 Oct 2005 09:52:55 -0400)
Subject: Re: [PATCH] nfs: don't drop dentry in d_revalidate
References: <E1ENqHd-0004cW-00@dorka.pomaz.szeredi.hu> <1128693175.8519.84.camel@lade.trondhjem.org>
Message-Id: <E1ENsqD-000587-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 07 Oct 2005 16:04:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > NFS d_revalidate() is doing things that are supposed to be done by
> > d_invalidate().
> > 
> > Dropping the dentry is especially bad, since it will make
> > d_invalidate() bypass all checks.
> 
> NAK!
> 
> Bypassing the stupid d_invalidate checks is precisely the point here.
> 
> Unlike local filesystems, we have to deal with the case where someone
> deletes a file on the server and then creates a new one with the same
> name. The d_invalidate checks will keep the wrong dentry hashed for as
> long as some borken process has the file open.
> 

d_invalidate() only makes sense for network filesystems like NFS.  If
it's broken, fix it.  But bypassing it is definitely the wrong thing
to do.

Miklos
