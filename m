Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268010AbUHSE0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268010AbUHSE0o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 00:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268011AbUHSE0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 00:26:44 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:49933 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S268010AbUHSE0n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 00:26:43 -0400
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] notify_parent cleanup
References: <200408180040.i7I0eM4l011117@magilla.sf.frob.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 19 Aug 2004 13:26:26 +0900
In-Reply-To: <200408180040.i7I0eM4l011117@magilla.sf.frob.com>
Message-ID: <87oel7eost.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> writes:

>  void
>  notify_parent(struct task_struct *tsk, int sig)

[...]

> +	BUG_ON(tsk->state != TASK_STOPPED);

task->state is changed anytime, right?  Although the window is small,
I think we should remove it at least for right now.

> +	read_lock(&tasklist_lock);
> +	do_notify_parent_cldstop(tsk, tsk->parent);
> +	read_unlock(&tasklist_lock);
>  }
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
