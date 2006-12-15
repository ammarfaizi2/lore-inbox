Return-Path: <linux-kernel-owner+w=401wt.eu-S1750841AbWLOI7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWLOI7o (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 03:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWLOI7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 03:59:44 -0500
Received: from verein.lst.de ([213.95.11.210]:53276 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750841AbWLOI7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 03:59:43 -0500
X-Greylist: delayed 1504 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 03:59:42 EST
Date: Fri, 15 Dec 2006 09:34:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, Christoph Hellwig <hch@lst.de>,
       Al Viro <viro@zeniv.linux.org.uk>, Steve Grubb <sgrubb@redhat.com>,
       linux-audit@redhat.com, Paul Jackson <pj@sgi.com>
Subject: Re: Task watchers v2
Message-ID: <20061215083414.GA13884@lst.de>
References: <20061215000754.764718000@us.ibm.com> <20061215000817.771088000@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061215000817.771088000@us.ibm.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 04:07:55PM -0800, Matt Helsley wrote:
> Associate function calls with significant events in a task's lifetime much like
> we handle kernel and module init/exit functions. This creates a table for each
> of the following events in the task_watchers_table ELF section:
> 
> WATCH_TASK_INIT at the beginning of a fork/clone system call when the
> new task struct first becomes available.
> 
> WATCH_TASK_CLONE just before returning successfully from a fork/clone.
> 
> WATCH_TASK_EXEC just before successfully returning from the exec
> system call.
> 
> WATCH_TASK_UID every time a task's real or effective user id changes.
> 
> WATCH_TASK_GID every time a task's real or effective group id changes.
> 
> WATCH_TASK_EXIT at the beginning of do_exit when a task is exiting
> for any reason. 
> 
> WATCH_TASK_FREE is called before critical task structures like
> the mm_struct become inaccessible and the task is subsequently freed.
> 
> The next patch will add a debugfs interface for measuring fork and exit rates
> which can be used to calculate the overhead of the task watcher infrastructure.

What's the point of the ELF hackery? This code would be a lot simpler
and more understandable if you simply had task_watcher_ops and a
register / unregister function for it.

