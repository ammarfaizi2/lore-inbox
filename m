Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUHULs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUHULs3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 07:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUHULs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 07:48:29 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:10771 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261610AbUHULs1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 07:48:27 -0400
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] notify_parent and ptrace cleanup
References: <200408210109.i7L19Kjf006151@magilla.sf.frob.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 21 Aug 2004 20:47:55 +0900
In-Reply-To: <200408210109.i7L19Kjf006151@magilla.sf.frob.com>
Message-ID: <87n00o3e6s.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> writes:

> +	spin_unlock_irq(&current->sighand->siglock);

This unlock is odd. lock is missing?

> +	read_lock(&tasklist_lock);
> +	do_notify_parent_cldstop(current, current->parent);
> +	read_unlock(&tasklist_lock);
> +	schedule();
> +
> +	/* We are back.  */
> +	current->last_siginfo = NULL;
> +}

->last_siginfo is racy. Please, really please don't extend it until
the race condition is fixed.

SIGCONT restart the stopped task. Any lock doesn't prevent it.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
