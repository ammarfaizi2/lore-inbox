Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263493AbTDGQH5 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 12:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263494AbTDGQH4 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 12:07:56 -0400
Received: from cs.columbia.edu ([128.59.16.20]:18431 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id S263493AbTDGQHz (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 12:07:55 -0400
Subject: Re: [PATCH] new syscall: flink
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <b6r6ms$tuj$1@abraham.cs.berkeley.edu>
References: <3E907A94.9000305@kegel.com>
	 <1049663559.1602.46.camel@dhcp22.swansea.linux.org.uk>
	 <b6qo2a$ecl$1@cesium.transmeta.com> <b6r24v$f50$1@cesium.transmeta.com>
	 <b6r6ms$tuj$1@abraham.cs.berkeley.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1049732241.1243.45.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 07 Apr 2003 12:17:21 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-07 at 02:43, David Wagner wrote:
> H. Peter Anvin wrote:
> >Here is a better piece of sample code that actually shows a
> >permissions violation happening:
> >
> >[...]
> >mkdir("testdir", 0700)                  = 0
> >open("testdir/testfile", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
> >write(3, "Ansiktsburk\n", 12)           = 12
> >close(3)                                = 0
> >open("testdir/testfile", O_RDONLY)      = 3
> >chmod("testdir", 0)                     = 0
> >open("/proc/self/fd/3", O_RDWR)         = 4
> >write(4, "Tjo fidelittan hatt!\n", 21)  = 21
> 
> You're right!  Good point. I retract the comments in my previous email.
> (I did try an experiment like this, but apparently not the right one.)
> 
> My conclusion: /proc/*/fd is a security hole.  It should be fixed.
> Do you agree?

I'm somewhat confused, why don't /proc/*/fd entries behave like normal
symbolic links?  i.e. shouldn't the inodes just be a symbolic link to
the d_path() of the fd?  Since symbolic links have to travel the entire
path (hence calling fs->permission() or vfs_permission() on each dir) it
should catch that problem.

Is my understanding of the design wrong? Or is that right, and it's just
the implementation that's broken?

just wondering, thanks,

shaya

