Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271185AbTGWSBQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 14:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271193AbTGWSAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 14:00:20 -0400
Received: from H-135-207-24-16.research.att.com ([135.207.24.16]:7821 "EHLO
	linux.research.att.com") by vger.kernel.org with ESMTP
	id S271185AbTGWSAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:00:05 -0400
Date: Wed, 23 Jul 2003 14:14:57 -0400 (EDT)
From: Glenn Fowler <gsf@research.att.com>
Message-Id: <200307231814.OAA74344@raptor.research.att.com>
Organization: AT&T Labs Research
X-Mailer: mailx (AT&T/BSD) 9.9 2003-01-17
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
References: <200307231428.KAA15254@raptor.research.att.com>  <20030723074615.25eea776.davem@redhat.com>  <200307231656.MAA69129@raptor.research.att.com>  <20030723100043.18d5b025.davem@redhat.com>  <200307231724.NAA90957@raptor.research.att.com> <20030723103135.3eac4cd2.davem@redhat.com>
To: davem@redhat.com, gsf@research.att.com
Subject: Re: kernel bug in socketpair()
Cc: dgk@research.att.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Jul 2003 10:31:35 -0700 David S. Miller wrote:
> Interesting.

> I looked at the bash code, and it uses pipes with /dev/fd/N, and for
> /dev/fd/N which are pipes the open should work under Linux.

> This is what David Korn said in his original report.

> I guess the part that is left is the fchmod() issue which exists
> because one inode is used to implement both sides of the pipe under
> Linux.

> Was the idea to, since fchmod() on pipes modified both sides,
> to use UNIX domain sockets to implement this?  And that's how
> you discovered the /dev/fd/N failure for sockets?

fchmod() came into play with socketpair() to get the fd modes to match
pipe(); its not needed with pipe()

we use socketpair() to allow efficient peeking on pipe input (via recv()),
where peek means "read some data but don't advance the read/seek offset"
btw, this is on systems that don't allow ioctl(I_PEEK) on pipe() fds;
if there is a way to peek pipe() data on linux then we can switch back
to pipe() and be on our way

> Another idea is to use named unix sockets.  Can that be
> sufficient to solve your dilemma?

named sockets seem a little heavyweight for this application

