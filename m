Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbUENQ6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUENQ6c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 12:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUENQ6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 12:58:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:18587 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261745AbUENQ6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 12:58:31 -0400
Date: Fri, 14 May 2004 09:58:30 -0700
From: Chris Wright <chrisw@osdl.org>
To: Martijn Sipkema <m.j.w.sipkema@student.tudelft.nl>
Cc: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: POSIX message queues should not allocate memory on send
Message-ID: <20040514095830.F22989@build.pdx.osdl.net>
References: <000701c4399e$88a3aae0$161b14ac@boromir> <20040514095145.GC30909@devserv.devel.redhat.com> <000601c439a3$f793af40$161b14ac@boromir>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000601c439a3$f793af40$161b14ac@boromir>; from m.j.w.sipkema@student.tudelft.nl on Fri, May 14, 2004 at 12:09:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martijn Sipkema (m.j.w.sipkema@student.tudelft.nl) wrote:
> You are correct; defaults are indeed needed. The current default value
> for mq_msgsize seems rather large considering that mq_msgsize*mq_maxmsg
> bytes will have to be allocated on queue creation. If variable sized large
> payload messages are needed one might consider using shared memory in
> combination with a message queue.

The defaults have been reduced in -mm tree which should make it to
mainline in relative near future.

#define DFLT_MSGMAX	10	/* max number of messages in each queue */
#define DFLT_MSGSIZEMAX	8192	/* max message size */

> My main point was that mq_send()/mq_timedsend() may not return ENOMEM
> and I am positive I did not misread the standard on that.

I'm not sure it's that clear, however, we somewhat adhered to this
principle when adding rlimits to mqueues, so rlimit checks are enforced
on mq_open() as if whole thing was pre-allocated.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
