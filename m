Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291348AbSAaVvn>; Thu, 31 Jan 2002 16:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291349AbSAaVve>; Thu, 31 Jan 2002 16:51:34 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:2040 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S291348AbSAaVv1>;
	Thu, 31 Jan 2002 16:51:27 -0500
Date: Thu, 31 Jan 2002 16:51:04 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Robert Love <rml@tech9.net>
cc: Jan Harkes <jaharkes@cs.cmu.edu>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: further llseek cleanup (1/3)
In-Reply-To: <1012513925.3392.175.camel@phantasy>
Message-ID: <Pine.GSO.4.21.0201311649460.17860-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 31 Jan 2002, Robert Love wrote:

> On Thu, 2002-01-31 at 10:19, Jan Harkes wrote:
> 
> > I'm not sure whether the Coda part of this patch is correct. Coda does
> > rely in the inode semaphore to protect from concurrency between the
> > userspace cachemanager that accesses the file on the host filesystem
> > directly and the applications that access the same file through the
> > /coda mount.
> > 
> > See for instance coda_file_write, where we also use the host inode
> > semaphore for protection. Only sys_stat() accesses i_size unprotected,
> > but that doesn't matter much in my opinion. Any application relying on
> > the result of sys_stat to do appending or subsequent lseeks would be
> > racy anyways. (and it can only be fixed correctly when we get a FS
> > specific getattr method).

That will happen pretty soon, actually.
 
> Hmm ... the race you mention in sys_stat is the problem I saw.  I also
> can't say for sure whether any code, or future code, would touch
> i_size.  It is just not safe.
> 
> Note also that reverting to the remote_llseek method won't break
> anything; it is the previous behavior.  Certainly I would much rather
> just use the inode semaphore, but I'd prefer to not introduce any
> races.  Ideally we need a solution that eliminates the BKL _and_ is not
> racy.
> 
> I'd be happy to keep Coda using the new generic_file_llseek if Al Viro
> agrees with you.  Al?

I'm OK with that.

