Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263139AbTEMBts (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 21:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbTEMBtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 21:49:03 -0400
Received: from siaag2ad.compuserve.com ([149.174.40.134]:46256 "EHLO
	siaag2ad.compuserve.com") by vger.kernel.org with ESMTP
	id S263139AbTEMBsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 21:48:12 -0400
Date: Mon, 12 May 2003 21:57:30 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] Fix -EPERM returned by kernel_thead() if traced...
To: Bernhard Kaindl <bk@suse.de>, Jeff Dike <jdike@karaya.com>,
       Matthew Grant <grantma@anathoth.gen.nz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305122200_MC3-1-3890-B10A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Kaindl wrote:

> -     task_lock(task);
> -     if (task->ptrace) {
> -             task_unlock(task);
> -             return -EPERM;
> -     }
> -
>       old_task_dumpable = task->task_dumpable;
> +     /* prevent ptrace_attach() on the new task: */
>       task->task_dumpable = 0;
> -     task_unlock(task);

  Is it safe to remove the task_lock()?


>  So I really have to assume that CLONE_PTRACE is never passed
>  to create a kernel thread. If you are paranoid, you could just
>  unmask it in kernel_thread() if you want.

  I would mask it if it's a possible problem.  Someone might
try to pass that option in future code...


