Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266505AbUHaEWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUHaEWS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 00:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUHaEWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 00:22:18 -0400
Received: from nevyn.them.org ([66.93.172.17]:37310 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S266505AbUHaEWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 00:22:17 -0400
Date: Tue, 31 Aug 2004 00:22:06 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cleanup ptrace stops and remove notify_parent
Message-ID: <20040831042206.GA10577@nevyn.them.org>
Mail-Followup-To: Roland McGrath <roland@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200408310325.i7V3Pklo020920@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408310325.i7V3Pklo020920@magilla.sf.frob.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 08:25:46PM -0700, Roland McGrath wrote:
> This patch is against Linus's current tree.
> 
> This adds a new state TASK_TRACED that is used in place of TASK_STOPPED
> when a thread stops because it is ptraced.  Now ptrace operations are only
> permitted when the target is in TASK_TRACED state, not in TASK_STOPPED.
> This means that if a process is stopped normally by a job control signal
> and then you PTRACE_ATTACH to it, you will have to send it a SIGCONT before
> you can do any ptrace operations on it.  (The SIGCONT will be reported to
> ptrace and then you can discard it instead of passing it through when you
> call PTRACE_CONT et al.)
> 
> If a traced child gets orphaned while in TASK_TRACED state, it morphs into
> TASK_STOPPED state.  This makes it again possible to resume or destroy the
> process with SIGCONT or SIGKILL.

Nice.

Unless it's been changed since I last pulled, you should also fix up
has_stopped_jobs.  I think it's broken by the introduction of
TASK_TRACED.

-- 
Daniel Jacobowitz
