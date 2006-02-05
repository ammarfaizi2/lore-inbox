Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751710AbWBELMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbWBELMA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 06:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbWBELMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 06:12:00 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56207 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751718AbWBELL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 06:11:59 -0500
Date: Sun, 5 Feb 2006 12:11:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, nigel@suspend2.net
Subject: Re: [PATCH -mm] swsusp: freeze user space processes first
Message-ID: <20060205111145.GE1790@elf.ucw.cz>
References: <200602051014.43938.rjw@sisk.pl> <20060205013859.60a6e5ab.akpm@osdl.org> <200602051134.19490.rjw@sisk.pl> <20060205105037.GA26222@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060205105037.GA26222@elte.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 05-02-06 11:50:37, Ingo Molnar wrote:
> 
> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > > The logic in that loop makes my brain burst.
> > > 
> > > What happens if a process does vfork();sleep(100000000)?
> > 
> > The freezing of processes will fail due to the timeout.
> > 
> > Without the if (!p->vfork_done) it would fail too, because the child 
> > would be frozen and the parent would wait for the vfork completion in 
> > the TASK_UNINTERRUPTIBLE state (ie. unfreezeable).  But in that case 
> > we have a race between the "freezer" and the child process (ie. if the 
> > child gets frozen before it completes the vfork completion, the paret 
> > will be unfreezeable) which sometimes leads to a failure when it 
> > should not.  [We have a test case showing this.]
> 
> then i'd suggest to change the vfork implementation to make this code 
> freezable. Nothing that userspace does should cause freezing to fail.  
> If it does, we've designed things incorrectly on the kernel side.

Does that also mean we have bugs with signal delivery? If vfork();
sleep(100000); causes process to be uninterruptible for few days, it
will not be killable and increase load average...
								Pavel
-- 
Thanks, Sharp!
