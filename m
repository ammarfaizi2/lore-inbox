Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWA3UhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWA3UhS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWA3UhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:37:17 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45446 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932382AbWA3UhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:37:16 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@sw.ru>, Jeff Dike <jdike@addtoit.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/3] pidhash: don't use zero pids
References: <43DDF323.4517C349@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 30 Jan 2006 13:36:29 -0700
In-Reply-To: <43DDF323.4517C349@tv-sign.ru> (Oleg Nesterov's message of
 "Mon, 30 Jan 2006 14:06:11 +0300")
Message-ID: <m1r76p5u7m.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> daemonize() calls set_special_pids(1,1), while init and
> kernel threads spawned from init/main.c:init() run with
> 0,0 special pids. This patch changes INIT_SIGNALS() so
> that that they run with ->pgrp == ->session == 1 also.
>
> This patch relies on fact that swapper's pid == 1.
>
> Now we never use pid == 0 in kernel/pid.c.

This changes what is visible to user space, for the case
where we are not a member of a session of a process group.

By hashing the values these non-groups become available to
user space.  Which I find disturbing.  Before I can comment
further I need to see if there are any well defined semantics
for processes that are not part of a session or a process
group.  If there are well defined semantics we have just
broken user space.

Eric
