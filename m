Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVDBTwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVDBTwc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 14:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVDBTwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 14:52:32 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:14796 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261237AbVDBTwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 14:52:30 -0500
Subject: Re: kernel stack size
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: ooyama eiichi <ooyama@tritech.co.jp>, cw@f00f.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050402193704.GU8859@parcelfarce.linux.theplanet.co.uk>
References: <20050402175345.GA28710@taniwha.stupidest.org>
	 <20050403.031542.23015132.ooyama@tritech.co.jp>
	 <20050402182438.GA29095@taniwha.stupidest.org>
	 <20050403.034858.70218818.ooyama@tritech.co.jp>
	 <1112468651.27149.4.camel@localhost.localdomain>
	 <20050402193704.GU8859@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sat, 02 Apr 2005 14:52:12 -0500
Message-Id: <1112471532.27149.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-02 at 20:37 +0100, Al Viro wrote:
> On Sat, Apr 02, 2005 at 02:04:11PM -0500, Steven Rostedt wrote:
> > You can also use globally static variables too. But this makes for
> > non-reentry code.
> > 
> > Sometimes I don't feel that a kmalloc is worth it, and if the function
> > in question for the driver would seldom have problems with reentry, I
> > use a statically defined global, and protect it with spin_locks. If
> > these can also be used in interrupt context, you need to use the
> > spin_lock_irqsave variants.  But don't do this if the critical section
> > has long latencies.
> 
> ... and the first time copy_from_user() blocks under your spinlock
> you will get a nice shiny deadlock.

I forgot that he mentioned that this was for ioctls. I then use
semaphores if I need to access userspace. But if it just needs to modify
data around areas that only the kernel uses, without access to
userspace, than I use spinlocks.

I admit you really need to know what you're doing to use this method. If
I believe that a kmalloc would be too expensive, then I use the locking
of static variables. But each situation is different and I try to use
the best method for the occasion.

-- Steve


