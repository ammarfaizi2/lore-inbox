Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbUK2JmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbUK2JmN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 04:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbUK2JmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 04:42:12 -0500
Received: from mx2.elte.hu ([157.181.151.9]:58506 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261643AbUK2JmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 04:42:05 -0500
Date: Mon, 29 Nov 2004 10:41:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, roland@redhat.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use pid_alive in proc_pid_status
Message-ID: <20041129094152.GB7868@elte.hu>
References: <41A9B589.1090005@colorfullife.com> <20041128222151.4d53fd14.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041128222151.4d53fd14.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> >  +int pid_alive(struct task_struct *p)
> >  +{
> >  +	return p->pids[PIDTYPE_PID].nr != 0;
> >  +}
> 
> Can we not simply test p->exit_state?  That's already done in quite a
> few places and making things consistent would be nice.

as long as it's accessed from under the tasklist_lock, it ought to be
fine to check for p->exit_state != EXIT_DEAD and dereference
p->group_leader afterwards.

	Ingo
