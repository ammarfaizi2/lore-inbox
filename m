Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbSJXIjo>; Thu, 24 Oct 2002 04:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265354AbSJXIjo>; Thu, 24 Oct 2002 04:39:44 -0400
Received: from tsv.sws.net.au ([203.36.46.2]:65291 "EHLO tsv.sws.net.au")
	by vger.kernel.org with ESMTP id <S265351AbSJXIjn>;
	Thu, 24 Oct 2002 04:39:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Nathan Scott <nathans@sgi.com>
Subject: Re: [PATCH] remove sys_security
Date: Thu, 24 Oct 2002 10:45:44 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
References: <20021023173635.A15896@infradead.org> <Pine.GSO.4.33.0210231241300.7042-100000@raven> <20021024062602.GD937@frodo>
In-Reply-To: <20021024062602.GD937@frodo>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210241045.44160.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2002 08:26, Nathan Scott wrote:
> > Also, the EA API lacks support for
> > creating files with specified security attributes (as opposed to creating
> > and then calling setxattr to change the attributes, possibly after
> > someone has already obtained access to the file), so it isn't ideal for
> > our purposes anyway.
>
> This is not a shortcoming of the xattr interfaces, they do what
> they were designed to do.  I think the only interfaces suited to
> setting up things in the way you've described are create, mkdir,
> mknod, and co.  It isn't clear to me how sys_security helps in
> this situation? -- it would also seem to be non-atomic wrt the
> inode creation syscalls, in the same way the xattr calls are.

Currently sys_security is used to implement open_secure(), mkdir_secure(), etc 
which do this atomically.

> The ACL code has to address a similar problem to the one you've
> described - if a directory has a default ACL set on it, then new
> children must be created with that ACL.  This is implemented by
> giving filesystems knowledge of the semantics of this attribute,
> and having them create the ACL along with the inode if need be.

SE Linux needs that functionality, but also it needs the ability to support 
file type automatic transition rules, for example when a program in fingerd_t 
domain creates a file in a directory of var_log_t then the file will have 
type var_log_fingerd_t.  But this doesn't require any extra system calls 
either.

What requires more system calls is the logrotate program which has to create 
new log files with the same security context as the log file it renamed.


I suggest that you check the archives for the full thread as it explains all 
this and more in detail.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

