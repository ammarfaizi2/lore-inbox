Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbSJQUy0>; Thu, 17 Oct 2002 16:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262076AbSJQUy0>; Thu, 17 Oct 2002 16:54:26 -0400
Received: from tsv.sws.net.au ([203.36.46.2]:54793 "EHLO tsv.sws.net.au")
	by vger.kernel.org with ESMTP id <S262067AbSJQUyZ>;
	Thu, 17 Oct 2002 16:54:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] remove sys_security
Date: Thu, 17 Oct 2002 23:00:05 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
References: <20021017195015.A4747@infradead.org> <20021017201030.GA384@kroah.com> <3DAF1DC8.1090708@pobox.com>
In-Reply-To: <3DAF1DC8.1090708@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210172300.05131.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2002 22:30, Jeff Garzik wrote:
> Greg KH wrote:
> > Hm, in looking at the SELinux documentation, here's a list of the
> > syscalls they need:
> > 	http://www.nsa.gov/selinux/docs2.html
> >
> > That's a lot of syscalls :)
>
> Any idea if security identifiers change with each syscall?
>
> If not, a lot of the xxx_secure syscalls could go away...

None of them can go away.

Security identifiers are for the operation you perform.  For example 
open_secure() is so that you can specify the security context for a new file 
that you are creating.  connect_secure() is used to specify the security 
context of the socket you want to connect to.  In the default setup the only 
way that connect_secure() and open_secure() can use the same SID is for unix 
domain sockets (which are labeled with file types).  A TCP connection will be 
to a process, the SID of a process is not a valid type label for a file.

lstat_secure(), recv_secure() and others are used to retrieve the security 
context of the file, network message, etc.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

