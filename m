Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVDBThK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVDBThK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 14:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVDBThK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 14:37:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48873 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261221AbVDBThG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 14:37:06 -0500
Date: Sat, 2 Apr 2005 20:37:04 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: ooyama eiichi <ooyama@tritech.co.jp>, cw@f00f.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: kernel stack size
Message-ID: <20050402193704.GU8859@parcelfarce.linux.theplanet.co.uk>
References: <20050402175345.GA28710@taniwha.stupidest.org> <20050403.031542.23015132.ooyama@tritech.co.jp> <20050402182438.GA29095@taniwha.stupidest.org> <20050403.034858.70218818.ooyama@tritech.co.jp> <1112468651.27149.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112468651.27149.4.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2005 at 02:04:11PM -0500, Steven Rostedt wrote:
> You can also use globally static variables too. But this makes for
> non-reentry code.
> 
> Sometimes I don't feel that a kmalloc is worth it, and if the function
> in question for the driver would seldom have problems with reentry, I
> use a statically defined global, and protect it with spin_locks. If
> these can also be used in interrupt context, you need to use the
> spin_lock_irqsave variants.  But don't do this if the critical section
> has long latencies.

... and the first time copy_from_user() blocks under your spinlock
you will get a nice shiny deadlock.
