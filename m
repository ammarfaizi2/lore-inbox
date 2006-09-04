Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWIDWtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWIDWtd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 18:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWIDWtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 18:49:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29385 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932221AbWIDWtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 18:49:32 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       saito.tadashi@soft.fujitsu.com, ak@suse.de
Subject: Re: [RFC][PATCH] ps command race fix take 4 [1/4] callback subroutine
References: <20060825182505.5e9ddc8f.kamezawa.hiroyu@jp.fujitsu.com>
Date: Mon, 04 Sep 2006 16:48:43 -0600
In-Reply-To: <20060825182505.5e9ddc8f.kamezawa.hiroyu@jp.fujitsu.com>
	(KAMEZAWA Hiroyuki's message of "Fri, 25 Aug 2006 18:25:05 +0900")
Message-ID: <m17j0j5juc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:

> Updated some dirty codes. maybe easier to read than previous one.
>
> This ps command fix (proc_pid_readdir() fix) fixes the problem by
>
> - attach a callback for updating pointer from file descriptor to a task invoked
>   at release_task()
> - no additional global lock is required.
> - walk through all and only task structs which is thread group leader.
>
> *Bad* point is adding additonal (small) lock and callback in exit path.
With an unbounded callback chain length influenced by user space.

My gut feel is that you have just about reinvented struct pid.
All you need to do now is to move the task list or a version
of it into struct pid and you can reference count the existing
structure.

Eric
