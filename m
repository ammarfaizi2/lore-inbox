Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265252AbTFMQsm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 12:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265326AbTFMQsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 12:48:41 -0400
Received: from web40601.mail.yahoo.com ([66.218.78.138]:41108 "HELO
	web40601.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265252AbTFMQsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 12:48:32 -0400
Message-ID: <20030613170220.17400.qmail@web40601.mail.yahoo.com>
Date: Fri, 13 Jun 2003 10:02:20 -0700 (PDT)
From: Muthian Sivathanu <muthian_s@yahoo.com>
Subject: RE: limit resident memory size
To: David Schwartz <davids@webmaster.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMECFDKAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Because increasing the amount of swapping and
> paging will slow the system
> down overall. Other processes will be interrupted
> more frequently and cache
> effectiveness will decline. If the disks are shared,
> the additional disk
> access will slow down other processes on the system
> as well.

the goals of resource isolation and optimal overall
performance are often in conflict, and there are
definitely cases when one really needs performance
isolation across processes inspite of the slight
performance hit this may entail.

> 	It's also not clear how shared pages should be
> handled. If this process
> causes large chunks of a shared library to be
> resident that wouldn't be
> otherwise, should this be charged against the
> process or not? If you exempt
> all shared memory, you not only create a whole a
> malicious process could
> drive a truck through but you don't measure
> accurately.
> 

I agree thats an issue -- how to treat shared pages is
a policy decision which may vary with the exact
requirements, but the general mechanism to be able to
monitor resident sets on a per process basis seems to
be useful.  How to treat shared pages could be a
user-specified parameter.

> 	If the process has a limited amount of work to do,
> it's much more sensible
> to just let it get done using the memory it needs to
> run quickly so it can
> get out of the way of other processes. If the
> process has an unlimited
> amonut of work to do, it makes more sense to control
> its use of processor
> resources, which will inherently limit its resident
> set size.
> 

I am concerned about reasonably long running processes
-- in those cases, limiting cpu usage need not
necessarily lead to bounds on resident set size --
what about a process that reads in a large file abt
the size of main memory ? it doesnt need much cpu, but
can fill up your memory.

> 	Basically, which pages should be resident is just
> one of those things the
> system knows better than you. Trying to make things
> better for one process
> may wind up making them worse as the system as a
> whole bogs down.
> 

again, I disagree.  Though it may be true in certain
cases, there are situations when a user knows better
about the relative importance of the processes he
runs. Wherever one desires performance isolation,
having per-process control over resource usage is
definitely a useful mechanism.

Muthian.


__________________________________
Do you Yahoo!?
Yahoo! Calendar - Free online calendar with sync to Outlook(TM).
http://calendar.yahoo.com
