Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262678AbVD2ON6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbVD2ON6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262698AbVD2ON5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:13:57 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:3245 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262678AbVD2ONy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:13:54 -0400
To: linuxram@us.ibm.com
CC: jamie@shareable.org, ericvh@gmail.com, pavel@ucw.cz,
       viro@parcelfarce.linux.theplanet.co.uk, miklos@szeredi.hu,
       hch@infradead.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-reply-to: <1114761430.4180.1566.camel@localhost> (message from Ram on Fri,
	29 Apr 2005 00:57:10 -0700)
Subject: Re: [PATCH] private mounts
References: <E1DPoCg-0000W0-00@localhost>
	 <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk>
	 <20050424213822.GB9304@mail.shareable.org>
	 <20050425152049.GB2508@elf.ucw.cz>
	 <20050425190734.GB28294@mail.shareable.org>
	 <20050426092924.GA4175@elf.ucw.cz>
	 <20050426140715.GA10833@mail.shareable.org>
	 <a4e6962a050428064774e88f4a@mail.gmail.com>
	 <20050428192048.GA2895@mail.shareable.org>
	 <1114717183.4180.718.camel@localhost>
	 <20050428220839.GA5183@mail.shareable.org> <1114761430.4180.1566.camel@localhost>
Message-Id: <E1DRWEt-000149-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 29 Apr 2005 16:13:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > Which means proc_root_link, when it switches to the vfsmnt at the root
> > of the other process, should traverse into the tree of vfsmnts which
> > make up the other namespace.
> 
> Yes. But proc_check_root() in proc_pid_follow_link() is failing the 
> traversal, because it is expecting the root vfsmount of the traversed
> process to belong to the vfsmount tree of the traversing process.
> In other words its expecting them to be both in the same namespace.
> 
> The permissions get denied by this code in proc_check_root():
> 

Removing the check makes chroot enter the tree under the other
process's namespace.  However it does not actually change the
namespace, hence mount/umount won't work.

So joinig a namespace does need a new syscall unfortunately.

Miklos
