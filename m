Return-Path: <linux-kernel-owner+w=401wt.eu-S964847AbWLMLFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWLMLFG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 06:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWLMLFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 06:05:05 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60973 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932662AbWLMLFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 06:05:04 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/12] tty layer and misc struct pid conversions
CC: Linux Containers <containers@lists.osdl.org>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>
Date: Wed, 13 Dec 2006 04:03:39 -0700
Message-ID: <m1y7pcoy5w.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The aim of this patch set is to start wrapping up the struct pid
conversions.  As such this patchset culminates with the removal
of kill_pg, kill_pg_info, __kill_pg_info, do_each_task_pid, and
while_each_task_pid.

kill_proc, daemonize, and kernel_thread are still in my sights but
there is still work to get to them.


The first three are basic cleanups around disassociate_ctty,
while working on converting it I found several issues.  tty_old_pgrp
can be a tricky concept to wrap your head around.

 1 tty: Make __proc_set_tty static.
 2 tty: Clarify disassociate_ctty
 3 tty: Fix the locking for signal->session in disassociate_ctty

These just stop using the old helper functions.

 4 signal: Use kill_pgrp not kill_pg in the sunos compatibility code.
 5 signal: Rewrite kill_something_info so it uses newer helpers.

Then the grind to convert the tty layer and all of it's helper
functions to struct pid.

 6 pid: Make session_of_pgrp use struct pid instead of pid_t.
 7 pid: Use struct pid for talking about process groups in exit.c
 8 pid: Replace is_orphaned_pgrp with is_current_pgrp_orphaned
 9 tty: Update the tty layer to work with struct pid.

A final helper function update.

10 pid: Replace do/while_each_task_pid with do/while_each_pid_task

And the removal of the functions that are now unused.
11 pid: Remove now unused do_each_task_pid and while_each_task_pid
12 pid: Remove the now unused kill_pg kill_pg_info and __kill_pg_info

All of these should be fairly simple and to the point.

Eric
