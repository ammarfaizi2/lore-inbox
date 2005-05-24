Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVEXGin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVEXGin (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 02:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVEXGim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 02:38:42 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:36873 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261321AbVEXGiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 02:38:10 -0400
To: mikew@google.com
CC: jamie@shareable.org, linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <429277CA.9050300@google.com> (message from Mike Waychison on
	Mon, 23 May 2005 17:39:38 -0700)
Subject: Re: [RFC][PATCH] rbind across namespaces
References: <1116627099.4397.43.camel@localhost> <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu> <1116660380.4397.66.camel@localhost> <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu> <20050521134615.GB4274@mail.shareable.org> <E1DZlVn-0007a6-00@dorka.pomaz.szeredi.hu> <429277CA.9050300@google.com>
Message-Id: <E1DaSCb-0003Tw-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 24 May 2005 07:43:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> FWIW, all this stuff has already been done and posted here.
> 
> Detachable chunks of vfsmounts:
> http://marc.theaimsgroup.com/?l=linux-fsdevel&m=109872862003192&w=2
> 
> 'Soft' reference counts for manipulating vfsmounts without pinning them 
> down:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109872797030644&w=2

I think this might just interest Jamie Lokier.  He had a very similar
poposal recently, but without reference to this patch, so I guess he
wasn't aware of it.

> Referencing vfsmounts in userspace using a file descriptor:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109871948812782&w=2

Why not just use /proc/PID/fd/FD?

> walking mountpoints in userspace: 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109875012510262&w=2

Is this needed?  Userspace can find out mountpoints from /proc/mounts
(or something similar for detached trees).

> attaching mountpoints in userspace:
> http://marc.theaimsgroup.com/?l=linux-fsdevel&m=109875063100111&w=2

Again, bind from/to /proc/PID/fd/FD should work without any new
interfaces.

> detaching mountpoints in userspace:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109880051800963&w=2

What's wrong with sys_umount()?

> getting info from a vfsmount:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109875135030473&w=2

/proc or /sys should do fine for this purpose I think.

I agree, that having "floating trees" could be useful, but I don't see
the point of adding new interfaces to support it.

Miklos
