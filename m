Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270385AbTGWTRU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 15:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271199AbTGWTPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 15:15:34 -0400
Received: from H-135-207-24-32.research.att.com ([135.207.24.32]:37004 "EHLO
	mailman.research.att.com") by vger.kernel.org with ESMTP
	id S270385AbTGWTN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 15:13:58 -0400
Date: Wed, 23 Jul 2003 15:28:52 -0400 (EDT)
From: David Korn <dgk@research.att.com>
Message-Id: <200307231928.PAA75996@raptor.research.att.com>
X-Mailer: mailx (AT&T/BSD) 9.9 2003-01-17
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: davem@redhat.com, dgk@research.att.com, gsf@research.att.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Re: kernel bug in socketpair()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cc:  gsf@research.att.com  dgk@research.att.com  linux-kernel@vger.kernel.org     netdev@oss.sgi.com
Subject: Re: Re: kernel bug in socketpair()
--------

> I missed the reason why you can't use pipes and bash
> is able to, what is it?
> 
> If it's the fchown() thing, why doesn't bash have this issue?
> 
> 

The reason is that we want to be able to peek ahead at data in
the pipe before advancing.  You can do this with recv() but
this doesn't work wtih pipes.   On some systems you can use
an ioctl() for this with pipes by Linux doesn't support this
so ksh configures to use socketpair() instead of pipe()
on Linux.  Without the ability to peek ahead on pipes, a command
like
	cat file | { head -6 > /dev/null; cat ;}
to remove the first 6 lines of a file would be hard to implement
unless head reads one byte at a time from the pipe.
(OK, you could read 6 bytes at first if you want to optimize head.)

David Korn
dgk@research.att.com
