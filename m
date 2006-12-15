Return-Path: <linux-kernel-owner+w=401wt.eu-S965187AbWLOWRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbWLOWRM (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 17:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965284AbWLOWRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 17:17:11 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:55744 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965187AbWLOWRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 17:17:10 -0500
Subject: Re: Task watchers v2
From: Matt Helsley <matthltc@us.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, Al Viro <viro@zeniv.linux.org.uk>,
       Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
       Paul Jackson <pj@sgi.com>
In-Reply-To: <20061215083414.GA13884@lst.de>
References: <20061215000754.764718000@us.ibm.com>
	 <20061215000817.771088000@us.ibm.com>  <20061215083414.GA13884@lst.de>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Fri, 15 Dec 2006 14:17:06 -0800
Message-Id: <1166221027.27070.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-15 at 09:34 +0100, Christoph Hellwig wrote:
> On Thu, Dec 14, 2006 at 04:07:55PM -0800, Matt Helsley wrote:
> > Associate function calls with significant events in a task's lifetime much like
> > we handle kernel and module init/exit functions. This creates a table for each
> > of the following events in the task_watchers_table ELF section:
> >
> > WATCH_TASK_INIT at the beginning of a fork/clone system call when the
> > new task struct first becomes available.
> >
> > WATCH_TASK_CLONE just before returning successfully from a fork/clone.
> >
> > WATCH_TASK_EXEC just before successfully returning from the exec
> > system call.
> >
> > WATCH_TASK_UID every time a task's real or effective user id changes.
> >
> > WATCH_TASK_GID every time a task's real or effective group id changes.
> >
> > WATCH_TASK_EXIT at the beginning of do_exit when a task is exiting
> > for any reason.
> >
> > WATCH_TASK_FREE is called before critical task structures like
> > the mm_struct become inaccessible and the task is subsequently freed.
> >
> > The next patch will add a debugfs interface for measuring fork and exit rates
> > which can be used to calculate the overhead of the task watcher infrastructure.
> 
> What's the point of the ELF hackery? This code would be a lot simpler
> and more understandable if you simply had task_watcher_ops and a
> register / unregister function for it.

	Andrew asked me to avoid locking and added complexity in the code that
uses one or more task watchers. The ELF hackery helps me avoid locking
in the fork/exit/etc paths that call the "registered" function.

Cheers,
	-Matt Helsley

