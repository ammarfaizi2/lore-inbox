Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262828AbUKRS0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262828AbUKRS0Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262836AbUKRSXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:23:39 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:53469 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S262805AbUKRSVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:21:48 -0500
To: torvalds@osdl.org
CC: hbryan@us.ibm.com, akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
In-reply-to: <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> (message from
	Linus Torvalds on Thu, 18 Nov 2004 10:01:40 -0800 (PST))
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>
 <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org>
Message-Id: <E1CUquZ-0004Az-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 18 Nov 2004 19:21:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why do you think it would kill the FUSE process? And why do you think 
> killing _any_ process would make the system come back to life? After all, 
> memory wasn't filled by process usage, it was filled by dirty FS pages.

Well, killing the fuse process _will_ make the system come back to
life, since then all the dirty pages belonging to the filesystem will
be discarded. 

> I really do believe that user-space filesystems have problems. There's a 
> reason we tend to do them in kernel space. 

Well, NFS with a network failure has the same problem.  It's not the
userspace that's the problem, it's the non-reliability.

> But limiting the outstanding writes some way may at least hide the thing.

Currently shared writable mappings aren't allowed for non-root by
default in FUSE.  And since non-mmap writes do not dirty pages on the
long run, it's harder to run out of space with them: you need a new
filedescriptor for each page you want to steal, and you will run out
of them sooner than of pages.

So I believe that FUSE is quite secure in this respect.  Please prove
me wrong!

Thanks,
Miklos
