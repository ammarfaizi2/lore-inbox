Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWBELSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWBELSd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 06:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWBELSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 06:18:32 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51350 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750743AbWBELSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 06:18:32 -0500
Date: Sun, 5 Feb 2006 12:18:15 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, nigel@suspend2.net
Subject: Re: [PATCH -mm] swsusp: freeze user space processes first
Message-ID: <20060205111815.GG1790@elf.ucw.cz>
References: <200602051014.43938.rjw@sisk.pl> <200602051134.19490.rjw@sisk.pl> <20060205105037.GA26222@elte.hu> <200602051211.07103.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602051211.07103.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 05-02-06 12:11:06, Rafael J. Wysocki wrote:
> On Sunday 05 February 2006 11:50, Ingo Molnar wrote:
> > 
> > * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > 
> > > > The logic in that loop makes my brain burst.
> > > > 
> > > > What happens if a process does vfork();sleep(100000000)?
> > > 
> > > The freezing of processes will fail due to the timeout.
> > > 
> > > Without the if (!p->vfork_done) it would fail too, because the child 
> > > would be frozen and the parent would wait for the vfork completion in 
> > > the TASK_UNINTERRUPTIBLE state (ie. unfreezeable).  But in that case 
> > > we have a race between the "freezer" and the child process (ie. if the 
> > > child gets frozen before it completes the vfork completion, the paret 
> > > will be unfreezeable) which sometimes leads to a failure when it 
> > > should not.  [We have a test case showing this.]
> > 
> > then i'd suggest to change the vfork implementation to make this code 
> > freezable.
> 
> I think you are right, but I don't know how to do this.
> 
> > Nothing that userspace does should cause freezing to fail.   If it does,
> > we've designed things incorrectly on the kernel side. 
> 
> I tend to agree.
> 
> Generally, the problem is due to the use of completions where userland
> processes are waited for.  The two places I know of are the vfork
> implementation and the usermode helper code.

Can you produce userland testcase? If we have uninterruptible process for
days... that's a bug in kernel, suspend or not.
								Pavel
-- 
Thanks, Sharp!
