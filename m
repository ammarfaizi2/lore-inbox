Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262209AbSJQWIa>; Thu, 17 Oct 2002 18:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbSJQWIa>; Thu, 17 Oct 2002 18:08:30 -0400
Received: from tsv.sws.net.au ([203.36.46.2]:56841 "EHLO tsv.sws.net.au")
	by vger.kernel.org with ESMTP id <S262209AbSJQWI2>;
	Thu, 17 Oct 2002 18:08:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] remove sys_security
Date: Fri, 18 Oct 2002 00:14:16 +0200
User-Agent: KMail/1.4.3
References: <Pine.GSO.4.21.0210171742050.18575-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0210171742050.18575-100000@weyl.math.psu.edu>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210180014.16512.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2002 23:49, Alexander Viro wrote:
> On Thu, 17 Oct 2002, Russell Coker wrote:
> > > What specific information differs per-operation, such that security
> > > identifiers cannot be stored internally inside a file handle?
> >
> > My previous message obviously wasn't clear enough.
> >
> > When you want to read or set the SID of a file handle then you need to
> > pass in a SID pointer or a SID.
>
> So fscking what?  _Nothing_ of the above warrants a new syscall.  There
> are struct file * attributes and there are descriptor attributes.
> Rather than excreting a new syscall you could look what already exists
> in the API.

OK, how do you go about supplying extra data to a file open than to modify the 
open system call?

If for example I want to create a file of context 
"system_u:object_r:fingerd_log_t" under /var/log (instead of taking the 
context from that of the /var/log directory "system_u:object_r:var_log_t") 
then how would I go about doing it other than through a modified open system 
call?

When are extended attributes going to be in Ext2/3?  This issue could be 
solved through them, but not in any other way AFAIK.

> Frankly, SELinux has some interesting ideas, but interfaces are appalling.
> Either they've never cared about it, or they have no taste (or have, er,
> overriding manag^Wissues actively hostile to any taste).  Take your pick.
>
> And don't get me started on access to file by inumber and other beauties
> in that excuse of an API.  It wasn't designed.  It happened.  As in, "it
> happens".

ichsid() was created to allow relabeling of the mount points of mounted file 
systems.

When you install SE Linux you need to have the mount points labelled 
appropriately.  The default file_t is usually OK, however there is the issue 
of re-installing SE Linux on a machine that previously had it, and as the SE 
Linux type labels are not integrated into the file system (need extended 
attributes) the type database could be out of sync with the file system.  Of 
course most mount points can be relabelled in single user mode after 
umounting the file systems - except /dev on a devfs system...

Admittedly ichsid() is pretty ugly even when you consider the ugly problem 
it's trying to solve.

What are the "other beauties" you refer to?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

