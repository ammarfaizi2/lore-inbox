Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288528AbSAHWor>; Tue, 8 Jan 2002 17:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288532AbSAHWoi>; Tue, 8 Jan 2002 17:44:38 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:1806 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288528AbSAHWo2>; Tue, 8 Jan 2002 17:44:28 -0500
Message-ID: <3C3B750D.610F7D48@zip.com.au>
Date: Tue, 08 Jan 2002 14:39:09 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bruce Blinn <blinn@MissionCriticalLinux.com>
CC: Dave Anderson <anderson@mclinux.com>, linux-kernel@vger.kernel.org,
        blinn@mclinux.com
Subject: Re: [BUG][PATCH] 2.4.* mlockall(MCL_FUTURE) is broken -- child inherits 
 VM_LOCKED
In-Reply-To: <3C3B5D1B.45CBF593@mclinux.com> <3C3B6ADF.4AAABE58@zip.com.au> <3C3B702C.4BF3819@MissionCriticalLinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruce Blinn wrote:
> 
> Andrew Morton wrote:
> >
> > Dave Anderson wrote:
> > >
> > > In 2.4.*, mlockall(MCL_FUTURE) is erroneously inherited by child processes
> > > across fork() and exec():
> >
> > The Linux manpage says that it is not inherited across either.
> >
> > However SUS says that it is not inherited across exec, and
> > doesn't mention fork() at all.
> > http://www.opengroup.org/onlinepubs/007908799/xsh/mlockall.html
> >
> > So...  Shouldn't we be clearing it in the exec() path?
> >
> 
> But, the SUS documentation for fork() says that it does not inherit the
> memory locks of the parent.  It explicitly mentions mlockall().
> 
>         http://www.opengroup.org/onlinepubs/007908799/xsh/fork.html

So it does.  So clearing it on fork is correct.  And my comment
regarding def_flags was nonsense.  Probably it's best to explicitly
clear VM_LOCKED, just in case something else gets added to def_flags
in the future.

Apart from that - ship it :)

-
