Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261911AbRESQv3>; Sat, 19 May 2001 12:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261905AbRESQvR>; Sat, 19 May 2001 12:51:17 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:61316 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261902AbRESQvK>;
	Sat, 19 May 2001 12:51:10 -0400
Date: Sat, 19 May 2001 12:51:07 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: bcrl@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]
 device arguments from lookup)
In-Reply-To: <UTC200105191641.SAA53411.aeb@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0105191244520.5339-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 May 2001 Andries.Brouwer@cwi.nl wrote:

> One would like to have a version of the open() call that was
> guaranteed free of side effects, and gave a fd only -
> perhaps for stat(), perhaps for ioctl().
> This guarantee could perhaps be obtained by omitting the
> 	f->f_op->open(inode,f);
> call in dentry_open() when the open call is
> 	open("file", O_FDONLY);
> Of course it may be that we afterwards decide that fd must
> be used, and then it needs upgrading:
> 	fd = f_open(fd, O_RDWR);

clone(), walk(), clunk(), stat() and open() ;-) Basically, we can add
unopened descriptors. I.e. no IO until you open it (turning the thing into
opened one), but we can do lookups (move to child), we can clone and
kill them and we can stat them.

It makes tree traversals much easier, but AFAIK nobody had exported that
API directly to userland. Might be a good idea, but it's completely
non-portable...

