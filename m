Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270453AbTGWQr4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 12:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270454AbTGWQr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 12:47:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54419 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S270453AbTGWQrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 12:47:53 -0400
Date: Wed, 23 Jul 2003 10:00:43 -0700
From: "David S. Miller" <davem@redhat.com>
To: Glenn Fowler <gsf@research.att.com>
Cc: dgk@research.att.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: kernel bug in socketpair()
Message-Id: <20030723100043.18d5b025.davem@redhat.com>
In-Reply-To: <200307231656.MAA69129@raptor.research.att.com>
References: <200307231428.KAA15254@raptor.research.att.com>
	<20030723074615.25eea776.davem@redhat.com>
	<200307231656.MAA69129@raptor.research.att.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 12:56:12 -0400 (EDT)
Glenn Fowler <gsf@research.att.com> wrote:

> the problem is that linux took an implementation shortcut by symlinking
> 	/dev/fd/N -> /proc/self/fd/N
> and by the time the kernel sees /proc/self/fd/N the "self"-ness is apparently
> lost, and it is forced to do the security checks

None of this is true.  If you open /proc/self/fd/N directly the problem
is still there.

> if the /proc fd open code has access to the original /proc/PID/fd/N path
> then it can do dup(atoi(N)) when the PID is the current process without
> affecting security

If we're talking about the current process, there is no use in using
/proc/*/fd/N to open a file descriptor in the first place, you can
simply call open(N,...)

I've personally always viewed /proc/*/fd/N as a way to see who has
various files or sockets open, ie. a debugging tool, not as a generic
way for processes to get access to each other's FDs.

There is an existing mechanism, a portable non-Linux one, that you
can use to do that.

Pass the fd over a UNIX domain socket if you want that, truly.
That works on every system.
