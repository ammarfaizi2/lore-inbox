Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262882AbUKRTIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbUKRTIR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262895AbUKRTGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:06:05 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:33772 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S262882AbUKRS4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:56:23 -0500
To: torvalds@osdl.org
CC: hbryan@us.ibm.com, akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
In-reply-to: <Pine.LNX.4.58.0411181027070.2222@ppc970.osdl.org> (message from
	Linus Torvalds on Thu, 18 Nov 2004 10:31:27 -0800 (PST))
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>
 <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org>
 <E1CUquZ-0004Az-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411181027070.2222@ppc970.osdl.org>
Message-Id: <E1CUrS0-0004Hi-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 18 Nov 2004 19:56:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Well, killing the fuse process _will_ make the system come back to
> > life, since then all the dirty pages belonging to the filesystem will
> > be discarded. 
> 
> They will? Why? They're still mapped into other processes, still dirty. 
> How do they go away?

Just as if they were written back properly.  It makes no sense to keep
pages under writeback around if we know the filesystem is gone for
good.

> In contrast, a fuse process that needs to do IO is _not_ protected from 
> the clients having eaten up all the memory it needs to do the IO.

Will the clients be allowed to fill up the _whole_ memory with dirty
pages?  Page writeback will start sooner than that, and then the
client will not be able to dirty more pages until some are freed.

BTW, I've never myself seen a deadlock, and I've not had any report of
it.  I've been able to deadlock FUSE on 2.4 with a shared writable
mapping and an artificial program that was designed for this, but I
haven't managed this on 2.6.

Maybe someone can help me.  Anybody who writes a program that
deadlocks Linux with a FUSE filesystem, gets a medal, and I'll humbly
apologize :)

Thanks,
Miklos
