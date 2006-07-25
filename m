Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWGYCAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWGYCAh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 22:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWGYCAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 22:00:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44508 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932377AbWGYCAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 22:00:36 -0400
Date: Mon, 24 Jul 2006 19:00:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: kamezawa.hiroyu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com
Subject: Re: [RFC] ps command race fix
Message-Id: <20060724190030.34884a67.akpm@osdl.org>
In-Reply-To: <20060724184847.3ff6be7d.pj@sgi.com>
References: <20060714203939.ddbc4918.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724182000.2ab0364a.akpm@osdl.org>
	<20060724184847.3ff6be7d.pj@sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2006 18:48:47 -0700
Paul Jackson <pj@sgi.com> wrote:

> Another possibility (perhaps a really stupid idea ;) would be to
> snapshot the list of pids on the open, and let the readdir() just
> access that fixed array.

The patch under discussion does precisely this.  (Awkwardly.  Using
kmalloc-pre-object might be better).

> The kernel/cpuset.c cpuset_tasks_open() routine that displays the
> pids of tasks in a cpuset (the per-cpuset 'tasks' file) does this.

Your faith in large kmalloc()s is touching ;) I guess the number of pids
will be smaller for cpusets.

> Then the seek and read and such semantics are nice and stable and
> simple.
> 
> Throw out the snapshot on the last close.

The patch under discussion didn't do this, although it could.  But it still
permits rather a lot of kernel memory to be pinned.

