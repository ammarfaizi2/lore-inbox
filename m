Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVEUJtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVEUJtS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 05:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVEUJtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 05:49:18 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:15123 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261715AbVEUJtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 05:49:14 -0400
To: linuxram@us.ibm.com
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, jamie@shareable.org
In-reply-to: <1116665101.4397.71.camel@localhost> (message from Ram on Sat, 21
	May 2005 01:45:01 -0700)
Subject: Re: [RFC][PATCH] rbind across namespaces
References: <1116627099.4397.43.camel@localhost>
	 <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu>
	 <1116660380.4397.66.camel@localhost>
	 <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu> <1116665101.4397.71.camel@localhost>
Message-Id: <E1DZQbI-0006mp-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 21 May 2005 11:48:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am not getting this comment.  R u assuming that a detached mount
> will have NULL namespace?  If so I dont see it being the case.
> Or am I missing some subtle point?

On a related note: now that it's not necessarily current->namespace
that's used as a destination for the mount, you'll have to pass
mntpt_ns into copy_tree() and clone_mnt() so that mnt->mnt_namespace
can correctly be set.  That will also enable some cleanup in
copy_namespace(), where you can remove the of setting ->mnt_namespace.

Miklos
