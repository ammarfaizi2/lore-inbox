Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWBEKwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWBEKwL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 05:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWBEKwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 05:52:11 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:16581 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750744AbWBEKwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 05:52:10 -0500
Date: Sun, 5 Feb 2006 11:50:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, pavel@suse.cz,
       nigel@suspend2.net
Subject: Re: [PATCH -mm] swsusp: freeze user space processes first
Message-ID: <20060205105037.GA26222@elte.hu>
References: <200602051014.43938.rjw@sisk.pl> <20060205013859.60a6e5ab.akpm@osdl.org> <200602051134.19490.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602051134.19490.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> > The logic in that loop makes my brain burst.
> > 
> > What happens if a process does vfork();sleep(100000000)?
> 
> The freezing of processes will fail due to the timeout.
> 
> Without the if (!p->vfork_done) it would fail too, because the child 
> would be frozen and the parent would wait for the vfork completion in 
> the TASK_UNINTERRUPTIBLE state (ie. unfreezeable).  But in that case 
> we have a race between the "freezer" and the child process (ie. if the 
> child gets frozen before it completes the vfork completion, the paret 
> will be unfreezeable) which sometimes leads to a failure when it 
> should not.  [We have a test case showing this.]

then i'd suggest to change the vfork implementation to make this code 
freezable. Nothing that userspace does should cause freezing to fail.  
If it does, we've designed things incorrectly on the kernel side.

	Ingo
