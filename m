Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUHYVuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUHYVuo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 17:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUHYVsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 17:48:22 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:16901 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S263962AbUHYVpw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 17:45:52 -0400
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] notify_parent and ptrace cleanup
References: <200408252107.i7PL7XWw017681@magilla.sf.frob.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 26 Aug 2004 06:45:35 +0900
In-Reply-To: <200408252107.i7PL7XWw017681@magilla.sf.frob.com>
Message-ID: <87hdqqlwn4.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > SIGKILL _already_ doesn't actually wake up a ptraced task. It just informs 
> > the tracer, last I looked.

I'm thinking the following issue here,

For example,

ptraced task stopping:

   in get_signal_to_deliver(),
	set_current_state(TASK_STOPPED);
	spin_unlock_irq(&current->sighand->siglock);
	notify_parent(current, SIGCHLD);
	schedule();

in here, root want to kill those tasks,

   kill -> ... -> specific_send_sig_info -> signal_wake_up(t, sig == SIGKILL)

   in signal_wake_up(),
	mask = TASK_INTERRUPTIBLE;
	if (resume)
		mask |= TASK_STOPPED;
	if (!wake_up_state(t, mask))


Hmm.. I may be missing something...?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
