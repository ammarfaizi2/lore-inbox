Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270354AbTGWOd2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 10:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270367AbTGWOd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 10:33:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51346 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S270354AbTGWOdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 10:33:25 -0400
Date: Wed, 23 Jul 2003 07:46:15 -0700
From: "David S. Miller" <davem@redhat.com>
To: David Korn <dgk@research.att.com>
Cc: gsf@research.att.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: kernel bug in socketpair()
Message-Id: <20030723074615.25eea776.davem@redhat.com>
In-Reply-To: <200307231428.KAA15254@raptor.research.att.com>
References: <200307231428.KAA15254@raptor.research.att.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 10:28:22 -0400 (EDT)
David Korn <dgk@research.att.com> wrote:

> This make sense for INET sockets, but I don't understand the security
> considerations for UNIX domain sockets.  Could you please elaborate?
> Moreover, /dev/fd/n, (as opposed to /proc/$$/n) is restricted to
> the current process and its decendents if close-on-exec is not specified.
> Again, I don't understand why this would create a security problem
> either since the socket is already accesible via the original
> descriptor.

Someone else would have to comment, but I do know we've had
this behavior since day one.

And therefore I wouldn't be doing many people much of a favor
by changing the behavior today, what will people do who need
their things to work on the bazillion existing linux kernels
running out there? :-)

Also, see below for another reason why this behavior is unlikely
to change.

> Finally if this is a security problem, why is the errno is set to ENXIO 
> rather than EACCESS?

Look at the /proc file we put there for socket FD's.  It's a symbolic
link with a readable string of the form ("socket:[%d]", inode_nr)

So your program ends up doing a follow of a symbolic link with that
string name, which does not exist.

Thinking more about this, changing this behavior would probably break
more programs than it would help begin to function, so this is unlikely
to ever change.

