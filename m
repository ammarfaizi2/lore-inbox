Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbTLQB3h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 20:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTLQB3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 20:29:37 -0500
Received: from codeblau.walledcity.de ([212.84.209.34]:25866 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S263125AbTLQB3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 20:29:35 -0500
Date: Wed, 17 Dec 2003 02:30:08 +0100
From: Felix von Leitner <felix-kernel@fefe.de>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: request: capabilities that allow users to drop privileges further
Message-ID: <20031217013008.GA8571@codeblau.de>
References: <20031215213912.GA29281@codeblau.de> <20031215144809.A14552@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031215144809.A14552@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Chris Wright (chrisw@osdl.org):
> > I would like to be able to drop capabilities that every normal user has,
> > so that network servers can limit the impact of possible future security
> > problems further.  For example, I want my non-cgi web server to be able
> > to drop the capabilities to
> Using existing capabilities system you can limit many of these.

No.  The administrator can limit many of these.  I want the software to
be able to limit itself.

> Just dropping privs from uid = 0 to anything else is a good start.

If you give administrators tools to limit privileges, some well-educated
admins may do it, but the bulk will not.

If you give software authors the tools to drop privileges they don't
need, and you help everyone.

> >   * execve
> mount fs noexec

Not an option for a web server or smtpd.

> >   * ptrace
> drop CAP_SYS_PTRACE

That will still allow the process to ptrace other processes of the same
uid.

> >   * write to the file system
> mount fs r/o.

Again, not an option.

I hope I made myself more clear this time.

I would be happy with a well documented and fine grained capabilities
system, and maybe a new syscall:

  abstain(__NR_execve);

I would also like a way to say that I want to never access the network
except through sockets that are already open (and presumably passed to
me at process creation).  Dan Bernstein has a good rationale on what I
think is needed: http://cr.yp.to/unix/disablenetwork.html, however I
think if we do this, we might as well opt for more flexibility.

Imagine being able to call "gzip -dc" in a pipe and denying it write
access to the file system, network I/O and other harmful operations.
If programs can restrict themselves, we could write email client
software that uses external untrusted plugins without fear of buffer
overflows or catching yourself a root kit.

Felix
