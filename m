Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265462AbUFSKKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265462AbUFSKKA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 06:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265478AbUFSKJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 06:09:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:22201 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265462AbUFSKJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 06:09:34 -0400
Date: Sat, 19 Jun 2004 03:08:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: kaos@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.7] bug_smp_call_function
Message-Id: <20040619030834.3582d2bd.akpm@osdl.org>
In-Reply-To: <20040619095910.GQ1863@holomorphy.com>
References: <5328.1087637808@kao2.melbourne.sgi.com>
	<20040619024416.065f4026.akpm@osdl.org>
	<20040619095910.GQ1863@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> Keith Owens <kaos@sgi.com> wrote:
> >>  sg.c has been fixed to no longer call vfree() with interrupts disabled.
> >>  Change smp_call_function() from WARN_ON to BUG_ON when interrupts are
> >>  disabled.  It was only set to WARN_ON because of sg.c.
> 
> On Sat, Jun 19, 2004 at 02:44:16AM -0700, Andrew Morton wrote:
> > I prefer the WARN_ON.  It is exceedingly unlikely that the bug will cause
> > lockups or memory/data corruption or anything else, so why nuke the user's
> > box when we can trivially continue?
> > We'll be sent the bug report either way.
> 
> Calls to smp_call_function() with interrupts off or spinlocks held
> typically causes deadlocks on SMP systems.

No, this doesn't "typically" deadlock.  It will deadlock on every ten
millionth call.  The preceding 9,999,999 warnings should have imparted
sufficient clue?

