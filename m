Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbSJWLiA>; Wed, 23 Oct 2002 07:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262181AbSJWLiA>; Wed, 23 Oct 2002 07:38:00 -0400
Received: from tsv.sws.net.au ([203.36.46.2]:40203 "EHLO tsv.sws.net.au")
	by vger.kernel.org with ESMTP id <S261900AbSJWLh6>;
	Wed, 23 Oct 2002 07:37:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] remove sys_security
Date: Wed, 23 Oct 2002 13:43:55 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
References: <Pine.GSO.4.21.0210171742050.18575-100000@weyl.math.psu.edu> <200210180014.16512.russell@coker.com.au> <20021023013551.A23214@redhat.com>
In-Reply-To: <20021023013551.A23214@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210231343.55811.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002 02:35, Stephen C. Tweedie wrote:
> > If for example I want to create a file of context
> > "system_u:object_r:fingerd_log_t" under /var/log (instead of taking the
> > context from that of the /var/log directory
> > "system_u:object_r:var_log_t") then how would I go about doing it other
> > than through a modified open system call?
>
> With a "setesid(2)" syscall to set the effective sid.
>
> A new file already inherits a ton of context, from the current uid/gid
> to the umask.  Those are already selectable by setting up the current
> process context.  And for the uid/gid bits, we also have setfsuid to
> set the id for creation without causing the whole process to suddenly
> change ownership.

Good idea, however there are two potential problems that I can see.

When creating a file the UID/GID name space for the file is the same as that 
for the process.  In SE Linux the name space for files to be created does not 
intersect the name space of the processes.  This makes it much less clean 
than setfsuid().

Secondly there is the issue of a lack of atomicity.  Is there a potential for 
a signal handler to create a file between the setesid() and creat() in the 
main code?  I guess the API open_secure() could remain the same and block all 
signals for it's operation...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

