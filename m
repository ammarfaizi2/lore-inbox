Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVDBTEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVDBTEX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 14:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVDBTEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 14:04:22 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:53451 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261181AbVDBTET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 14:04:19 -0500
Subject: Re: kernel stack size
From: Steven Rostedt <rostedt@goodmis.org>
To: ooyama eiichi <ooyama@tritech.co.jp>
Cc: cw@f00f.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050403.034858.70218818.ooyama@tritech.co.jp>
References: <20050402175345.GA28710@taniwha.stupidest.org>
	 <20050403.031542.23015132.ooyama@tritech.co.jp>
	 <20050402182438.GA29095@taniwha.stupidest.org>
	 <20050403.034858.70218818.ooyama@tritech.co.jp>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sat, 02 Apr 2005 14:04:11 -0500
Message-Id: <1112468651.27149.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-03 at 03:48 +0900, ooyama eiichi wrote:

> > > because my driver hungs the machine by an certain ioctl.  and it
> > > seems to me there is no bad in the code correspond to the ioctl,
> > > except for that it is using large auto variables.  (some functions
> > > are useing ~1KB autos)
> > 
> > don't do that, even if you make it 'apparently' work for you it will
> > just end up being a problem mater on or for someone else
> > 
> 
> I changed these to using kmalloc().
> (but not yet confirmed for my driver to work properly)

You can also use globally static variables too. But this makes for
non-reentry code.

Sometimes I don't feel that a kmalloc is worth it, and if the function
in question for the driver would seldom have problems with reentry, I
use a statically defined global, and protect it with spin_locks. If
these can also be used in interrupt context, you need to use the
spin_lock_irqsave variants.  But don't do this if the critical section
has long latencies.

-- Steve


