Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVD0OrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVD0OrZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 10:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVD0OrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 10:47:24 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:48804 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261660AbVD0OrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 10:47:19 -0400
To: jamie@shareable.org
CC: pavel@suse.cz, hch@infradead.org, linuxram@us.ibm.com, 7eggert@gmx.de,
       bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-reply-to: <20050427143126.GB1957@mail.shareable.org> (message from Jamie
	Lokier on Wed, 27 Apr 2005 15:31:26 +0100)
Subject: Re: [PATCH] private mounts
References: <E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu> <20050426093628.GA30208@infradead.org> <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu> <20050426094727.GA30379@infradead.org> <20050426131943.GC2226@openzaurus.ucw.cz> <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu> <20050426201411.GA20109@elf.ucw.cz> <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu> <20050427092450.GB1819@elf.ucw.cz> <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu> <20050427143126.GB1957@mail.shareable.org>
Message-Id: <E1DQno0-00029a-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Apr 2005 16:46:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why, exactly, is this check in the kernel and not the FUSE daemon?
> 
> Someone said the FUSE daemon knows which user is making filesystem
> requests, and can therefore do this.  Is it true?

Yes.

The check is in the kernel, because otherwise it couldn't be enforced.

It is not there for the purpose of protecting user's data.  Rather for
protecting other users (including root) from unknowingly entering the
FUSE directory and thus leaking otherwise inaccessible information
(exact file operations performed) to the mount owner.

It's probably not a great security risk, but it's better to be safe
than sorry.  If a sysadmin decides, it's not problematic, he can
relax this by 

  echo user_allow_other >> /etc/fuse.conf

Miklos
