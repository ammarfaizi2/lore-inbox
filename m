Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVGBO7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVGBO7R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 10:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVGBO7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 10:59:17 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:4619 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261181AbVGBO7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 10:59:12 -0400
To: ebiederm@xmission.com
CC: ericvh@gmail.com, akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com,
       v9fs-developer@lists.sourceforge.net
In-reply-to: <m1acl5frw6.fsf@ebiederm.dsl.xmission.com>
Subject: Re: FUSE merging?
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	<E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu>
	<20050630235059.0b7be3de.akpm@osdl.org>
	<E1DoFcK-0002Ox-00@dorka.pomaz.szeredi.hu>
	<20050701001439.63987939.akpm@osdl.org>
	<E1DoG6p-0002Rf-00@dorka.pomaz.szeredi.hu>
	<20050701010229.4214f04e.akpm@osdl.org>
	<E1DoIUz-0002a5-00@dorka.pomaz.szeredi.hu>
	<a4e6962a050701062136435471@mail.gmail.com>
	<E1DoLxK-0002ua-00@dorka.pomaz.szeredi.hu>
	<a4e6962a05070107183862ed22@mail.gmail.com>
	<E1DoMYJ-0002ya-00@dorka.pomaz.szeredi.hu> <m1acl5frw6.fsf@ebiederm.dsl.xmission.com>
Message-Id: <E1DojRm-00047s-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 02 Jul 2005 16:58:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Taking a quick glance at v9fs and fuse I fail to see how either
> plays nicely with the page cache.
> 
> v9fs according to my reading of the protocol specification does
> not have any concept of a lease.  So you can't tell if you are
> talking about a virtual filesystem where all calls should be passed
> straight to the server or a real filesystem where you can perform
> caching.  The implementation simply appears to bypass the pagecache
> which seems sane.
> 
> Skimming through the FUSE code I see the same problem, in that you can't
> autodetect the right thing.  This is currently hacked around with
> "direct_io" mount option selecting between a cached and a non-cached
> status on a filesystem basis at mount time.  But having
> a per file flag would be nicer.

There's a plan to make this work.  The kernel ABI has alredy been
prepared for this, it would be relatively little work to implement.
But I usually wait with something like this until people actually
start asking for this feature.

> I also don't understand why in fuse direct_io is an if statement in
> fuse_file_read/write instead of simply being a different set of
> filesystem operations.

Good point.  I'll fix that.

> Neither implementation seems to forward user space locks to the
> filesystem server.

This too has been discussed.  The last half year has been mostly spend
with ironing out problems cought during integration.  Sometime this
summer I'll start implementing these new features (inode based API,
locking, userspace NFS serving, maybe shared writable mmap support).

Miklos
