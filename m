Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbULANcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbULANcn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 08:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbULANcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 08:32:43 -0500
Received: from barry.mail.mindspring.net ([207.69.200.25]:41240 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id S261242AbULANcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 08:32:39 -0500
Message-Id: <5.1.0.14.2.20041201082839.009f2340@pop.mindspring.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 01 Dec 2004 08:32:42 -0500
To: Andrew Morton <akpm@osdl.org>
From: Joe Korty <kortyads@mindspring.com>
Subject: Re: waitid breaks telnet
Cc: roland@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20041130202730.6ceab259.akpm@osdl.org>
References: <5.1.0.14.2.20041130225221.009d1340@pop.mindspring.com>
 <5.1.0.14.2.20041130225221.009d1340@pop.mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:27 PM 11/30/04 -0800, Andrew Morton wrote:
>Joe Korty <kortyads@mindspring.com> wrote:
> >
> > [ 2nd send, this one from my home email account...]
> >
> > telnet no longer works:
> >
> >      # chkconfig telnet on
> >      # telnet localhost
> >      Trying 127.0.0.1...
> >      Connected to localhost (127.0.0.1).
> >      Escape character is '^]'.
> >      Red Hat Enterprise Linux WS release 3 (Taroon Update 2)
> >      Kernel 2.6.10-rc2 on an i686
> >      Connection closed by foreign host.
> >
> > A bsearch placed the bug between 2.6.9-rc1-bk[78], another
> > bsearch on the changesets showed the problem is caused
> > by this patch:
> >
> >      roland@redhat.com[torvalds]|ChangeSet|20040831173525|30767
> >      [PATCH] waitid system call
> >
> > My guess is, something about the new wait4(2) wrapper
> > is causing the telnet daemon to declare success before
> > its child, /bin/login, exits.
>
>I can reproduce this on 2.6.10-rc2, but it seems to have been fixed in more
>recent kernels.  However I cannot think of anything which we did which
>would have fixed this.

I was able to reproduce it with the day-before-yesterday''s bitkeeper tree.

My boss sees broken kernels work once in a while.  I myself have
never been able to get a broken kernel to work.  The problem may
be a race.

Joe


