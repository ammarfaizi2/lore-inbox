Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263185AbSJGUrr>; Mon, 7 Oct 2002 16:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263191AbSJGUrD>; Mon, 7 Oct 2002 16:47:03 -0400
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:60288 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S263185AbSJGUqV>; Mon, 7 Oct 2002 16:46:21 -0400
Date: Mon, 7 Oct 2002 14:51:52 -0600
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: Is this racy?
Message-ID: <20021007145152.A4065@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In fs/proc/array.c (2.4.20-pre9, 2.4.19 and likely many other
versions) in function 'proc_pid_stat()' there is a code like that:

	......
	read_lock(&tasklist_lock);
	ppid = task->pid ? task->p_opptr->pid : 0;
	read_unlock(&tasklist_lock);
	res = sprintf(buffer,"<long format string>",
		task->pid,
		......
		ppid,
		......

So assignment to ppid is locked but other reads from fiels of 'task'
structure are not guarded that way.  Is this ok or if not we do not
particularly care?  Function 'task_state()' in the same file seems
to be more careful about this.

  Michal

