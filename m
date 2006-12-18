Return-Path: <linux-kernel-owner+w=401wt.eu-S1753232AbWLRFxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbWLRFxk (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 00:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753257AbWLRFxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 00:53:40 -0500
Received: from mga05.intel.com ([192.55.52.89]:10260 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753232AbWLRFxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 00:53:39 -0500
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 00:53:39 EST
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,181,1165219200"; 
   d="scan'208"; a="178727215:sNHT67252178"
Subject: Re: Task watchers v2
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, Christoph Hellwig <hch@lst.de>,
       Al Viro <viro@zeniv.linux.org.uk>, Steve Grubb <sgrubb@redhat.com>,
       linux-audit@redhat.com, Paul Jackson <pj@sgi.com>,
       systemtap@sources.redhat.com
In-Reply-To: <20061215000817.771088000@us.ibm.com>
References: <20061215000754.764718000@us.ibm.com>
	 <20061215000817.771088000@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Date: Mon, 18 Dec 2006 13:44:01 +0800
Message-Id: <1166420641.15989.117.camel@ymzhang>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.2 (2.9.2-2.fc7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-14 at 16:07 -0800, Matt Helsley wrote:
> plain text document attachment (task-watchers-v2)
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
> 
> Subsequent patches will make use of task watchers to simplify fork, exit,
> and many of the system calls that set [er][ug]ids.
It's easier to get such watch capabilities by kprobe/systemtap. Why to
add new codes to kernel?
