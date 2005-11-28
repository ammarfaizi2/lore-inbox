Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbVK1UJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbVK1UJj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 15:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbVK1UJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 15:09:39 -0500
Received: from adsl-80.mirage.euroweb.hu ([193.226.228.80]:59153 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932231AbVK1UJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 15:09:39 -0500
To: trond.myklebust@fys.uio.no
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <1133207831.27574.95.camel@lade.trondhjem.org> (message from
	Trond Myklebust on Mon, 28 Nov 2005 14:57:11 -0500)
Subject: Re: [PATCH 1/7] fuse: check directory aliasing in mkdir
References: <E1EgosN-0006s3-00@dorka.pomaz.szeredi.hu>
	 <E1EgouE-0006sp-00@dorka.pomaz.szeredi.hu> <1133207831.27574.95.camel@lade.trondhjem.org>
Message-Id: <E1EgpJJ-0006ym-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 28 Nov 2005 21:09:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Check the created directory inode for aliases in the mkdir() method.
> 
> 
> Can't you use d_add_unique() here?

The patch is checking for hashed aliases of an inode.  E.g. if /foo is
a directory and has a ID of 28, and mkdir /bar returns the same ID,
then the mkdir should fail.

It's an illegal for the filesystem to create two directories refering
to the same inode.

OTOH d_add_unique() is looking for unhashed aliases to resurrect,
which may or may not make sense in fuse.  I'll think about it a bit
more.

Thanks,
Miklos
