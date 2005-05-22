Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVEVIJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVEVIJo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 04:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVEVIJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 04:09:30 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:30987 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261325AbVEVIJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 04:09:24 -0400
To: jamie@shareable.org
CC: linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <20050521134615.GB4274@mail.shareable.org> (message from Jamie
	Lokier on Sat, 21 May 2005 14:46:15 +0100)
Subject: Re: [RFC][PATCH] rbind across namespaces
References: <1116627099.4397.43.camel@localhost> <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu> <1116660380.4397.66.camel@localhost> <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu> <20050521134615.GB4274@mail.shareable.org>
Message-Id: <E1DZlVn-0007a6-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 22 May 2005 10:08:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I still see a problem: what if old_nd.mnt is already detached, and
> > bind is non-recursive.  Now it fails with EINVAL, though it used to
> > work (and I think is very useful).
> 
> Hey, you just made another argument for not detaching mounts when the
> last task with that current->namespace exits, but instead detaching
> mounts when the last reference to any vfsmnt in the namespace is dropped.
> 
> Hint :)

I have a better idea:

 - create a "dead_mounts" namespace.
 - chain each detached mount's ->mnt_list on dead_mounts->list
 - set mnt_namespace to dead_mounts
 - export the list via proc through the usual mount list interface

The last would be a nice bonus: I've always wanted to see the list of
detached, but not-yet destroyed mounts.

Does anybody see a problem with that?

Miklos
