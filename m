Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbSJQVcD>; Thu, 17 Oct 2002 17:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262191AbSJQVcC>; Thu, 17 Oct 2002 17:32:02 -0400
Received: from tsv.sws.net.au ([203.36.46.2]:55817 "EHLO tsv.sws.net.au")
	by vger.kernel.org with ESMTP id <S262190AbSJQVcB>;
	Thu, 17 Oct 2002 17:32:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] remove sys_security
Date: Thu, 17 Oct 2002 23:37:49 +0200
User-Agent: KMail/1.4.3
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
References: <20021017195015.A4747@infradead.org> <200210172300.05131.russell@coker.com.au> <3DAF272B.8040301@pobox.com>
In-Reply-To: <3DAF272B.8040301@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210172337.49463.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2002 23:10, Jeff Garzik wrote:
> >>Any idea if security identifiers change with each syscall?
> >>
> >>If not, a lot of the xxx_secure syscalls could go away...
> >
> > None of them can go away.
> >
> > Security identifiers are for the operation you perform.  For example
> > open_secure() is so that you can specify the security context for a new
> > file that you are creating.  connect_secure() is used to specify the
> > security context of the socket you want to connect to.  In the default
> > setup the only way that connect_secure() and open_secure() can use the
> > same SID is for unix domain sockets (which are labeled with file types). 
> > A TCP connection will be to a process, the SID of a process is not a
> > valid type label for a file.
> >
> > lstat_secure(), recv_secure() and others are used to retrieve the
> > security context of the file, network message, etc.
>
> What specific information differs per-operation, such that security
> identifiers cannot be stored internally inside a file handle?

My previous message obviously wasn't clear enough.

When you want to read or set the SID of a file handle then you need to pass in 
a SID pointer or a SID.

This is what the *_secure() system calls do, they set a SID or read a SID.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

