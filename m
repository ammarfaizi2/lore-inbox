Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270462AbTGWRSr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 13:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270471AbTGWRSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 13:18:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3732 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S270462AbTGWRSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 13:18:46 -0400
Date: Wed, 23 Jul 2003 10:31:35 -0700
From: "David S. Miller" <davem@redhat.com>
To: Glenn Fowler <gsf@research.att.com>
Cc: gsf@research.att.com, dgk@research.att.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: kernel bug in socketpair()
Message-Id: <20030723103135.3eac4cd2.davem@redhat.com>
In-Reply-To: <200307231724.NAA90957@raptor.research.att.com>
References: <200307231428.KAA15254@raptor.research.att.com>
	<20030723074615.25eea776.davem@redhat.com>
	<200307231656.MAA69129@raptor.research.att.com>
	<20030723100043.18d5b025.davem@redhat.com>
	<200307231724.NAA90957@raptor.research.att.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 13:24:36 -0400 (EDT)
Glenn Fowler <gsf@research.att.com> wrote:

> /dev/fd/N is the underlying mechanism for implementing the bash and ksh
> 
> 	cmd-1 <(cmd-2 ...) ... <(cmd-n ...)
> 

Interesting.

I looked at the bash code, and it uses pipes with /dev/fd/N, and for
/dev/fd/N which are pipes the open should work under Linux.

This is what David Korn said in his original report.

I guess the part that is left is the fchmod() issue which exists
because one inode is used to implement both sides of the pipe under
Linux.

Was the idea to, since fchmod() on pipes modified both sides,
to use UNIX domain sockets to implement this?  And that's how
you discovered the /dev/fd/N failure for sockets?

Another idea is to use named unix sockets.  Can that be
sufficient to solve your dilemma?
