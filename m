Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbUK2GYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbUK2GYl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 01:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbUK2GYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 01:24:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:62383 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261151AbUK2GYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 01:24:40 -0500
Date: Sun, 28 Nov 2004 22:21:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: mingo@elte.hu, roland@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use pid_alive in proc_pid_status
Message-Id: <20041128222151.4d53fd14.akpm@osdl.org>
In-Reply-To: <41A9B589.1090005@colorfullife.com>
References: <41A9B589.1090005@colorfullife.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> wrote:
>
> +/**
>  + * pid_alive - check that a task structure is not stale
>  + * @p: Task structure to be checked.
>  + *
>  + * Test if a process is not yet dead (at most zombie state)
>  + * If pid_alive fails, then pointers within the task structure
>  + * can be stale and must not be dereferenced.
>  + */
>  +int pid_alive(struct task_struct *p)
>  +{
>  +	return p->pids[PIDTYPE_PID].nr != 0;
>  +}

Can we not simply test p->exit_state?  That's already done in quite a few
places and making things consistent would be nice.

