Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262300AbSI1SW0>; Sat, 28 Sep 2002 14:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262306AbSI1SW0>; Sat, 28 Sep 2002 14:22:26 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:17419
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262300AbSI1SWZ>; Sat, 28 Sep 2002 14:22:25 -0400
Subject: Re: Sleeping function called from illegal context...
From: Robert Love <rml@tech9.net>
To: John Levon <movement@marcelothewonderpenguin.com>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
In-Reply-To: <20020928172449.GA54680@compsoc.man.ac.uk>
References: <20020927233044.GA14234@kroah.com>
	 <1033174290.23958.17.camel@phantasy>
	 <20020928145418.GB50842@compsoc.man.ac.uk> <3D95E14D.9134405C@digeo.com>
	 <20020928172449.GA54680@compsoc.man.ac.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1033237664.22582.167.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 28 Sep 2002 14:27:44 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-09-28 at 13:24, John Levon wrote:

> NMI interrupt handler cannot block so it trylocks against a spinlock
> instead. Buffer processing code needs to block against concurrent NMI
> interrupts so takes the spinlock for them. All actual blocks on the
> spinlock are beneath a down() on another semaphore, so a sleep whilst
> holding the spinlock won't actually cause deadlock.

If all accesses to the spinlock are taken under a semaphore, then the
spinlock is not needed (i.e. the down'ed semaphore provides the same
protection), or am I missing something?

If this is not the case - e.g. there are other accesses to these locks -
then you cannot sleep, no?

I really can think of no case in which it is safe to sleep while holding
a spinlock or otherwise atomic.  If it is, then the atomicity is not
needed, sort of by definition.

	Robert Love

