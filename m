Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbWFST2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbWFST2y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 15:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWFST2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 15:28:54 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:35514 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932540AbWFST2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 15:28:54 -0400
Date: Tue, 20 Jun 2006 03:28:56 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm_timer: remove a racy and obsolete PF_EXITING check
Message-ID: <20060619232856.GA88@oleg>
References: <20060615161202.GA21463@oleg> <20060619080656.42097180049@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619080656.42097180049@magilla.sf.frob.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19, Roland McGrath wrote:
> 
> > However, for some reason it does so only for CPUCLOCK_PERTHREAD
> > case (which is imho wrong).
> 
> For a process CPU clock timer, ->it.cpu.task is the thread group leader.
> The group leader can exit and will be a lingering zombie for as long as
> other threads in the group live.  The process timers need to keep getting
> armed and working both during and after the group leader's exit processing.

Ah, yes. Also, I missed the fact that process_timer_rebalance() checks
PF_EXITING anyway (For a process CPU clock timer), so I was wrong twice.

Thanks!

Oleg.

