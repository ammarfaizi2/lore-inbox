Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751585AbWCBQfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbWCBQfK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 11:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbWCBQfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 11:35:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29581 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751585AbWCBQfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 11:35:08 -0500
To: Paul Jackson <pj@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Proc: move proc fs hooks from cpuset.c to
 proc/fs/base.c
References: <20060302070812.15674.50176.sendpatchset@jackhammer.engr.sgi.com>
	<20060302084739.GC21902@infradead.org>
	<20060302062359.5940ff7f.pj@sgi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 02 Mar 2006 09:32:45 -0700
In-Reply-To: <20060302062359.5940ff7f.pj@sgi.com> (Paul Jackson's message of
 "Thu, 2 Mar 2006 06:23:59 -0800")
Message-ID: <m1y7zskdsi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:

>> Seems pointless.  This just increases #ifdef churn for no gain.
>
> Take a look at fs/proc/base.c.  That's how pretty much all the
> other proc hooks are done, with ifdef's around their proc hooks.
>
> ifdef minimization is a good goal, yes.
>
> But uniformity of practice is another good goal.

Agreed.  However the direction I am gradually moving fs/proc/base.c
is the opposite.  Moving things out of it as much as is reasonably
possible.

I already moved out all of the /proc/<pid>/?maps code into
fs/proc/task_mmu.c

I think the more important piece of uniform practice is to put all of
the operations structures and methods together in one file so that it
is easier to look between them, when making modifications especially
since cpuset_open and proc_cpuset_show are interdependent.

Eric
