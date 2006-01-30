Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWA3NbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWA3NbO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 08:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWA3NbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 08:31:14 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:13779 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932266AbWA3NbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 08:31:13 -0500
Message-ID: <43DE2730.795468DC@tv-sign.ru>
Date: Mon, 30 Jan 2006 17:48:16 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Cleanup exec from a non thread group leader.
References: <43DDFDE3.58C01234@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> 
> Eric W. Biederman wrote:
> >
> > -     list_add_tail(&thread->tasks, &init_task.tasks);
> 
> The last deletion is wrong, I beleive.

Just to clarify, it looks like we can kill this line because
de_thread() also does list_add_tail(current, &init_task.tasks).

But please note that it (and probably __ptrace_link() above)
does list_del(current->task) first, and current->task may have
very stale values after old leader called dup_task_struct().
SET_LINKS() in copy_process() does nothing with ->tasks in a
CLONE_THREAD case.

Oleg.
