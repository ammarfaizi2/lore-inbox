Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbVLaG64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbVLaG64 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 01:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVLaG64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 01:58:56 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:1009 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751307AbVLaG64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 01:58:56 -0500
Date: Sat, 31 Dec 2005 01:58:45 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [PATCH] protect remove_proc_entry
In-Reply-To: <20051230154647.5a38227e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0512310154190.5977@gandalf.stny.rr.com>
References: <1135973075.6039.63.camel@localhost.localdomain>
 <1135978110.6039.81.camel@localhost.localdomain> <20051230154647.5a38227e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Dec 2005, Andrew Morton wrote:

> Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > +static DEFINE_SPINLOCK(remove_proc_lock);
> >
>
> I'll take a closer look at this next week.
>
> The official way of protecting the contents of a directory from concurrent
> lookup or modification is to take its i_sem.  But procfs is totally weird
> and that approach may well not be practical here.  We'd certainly prefer
> not to rely upon lock_kernel().
>

Yeah, I thought about using the sem (or mutex ;) but remove_proc_entry is
used so darn much around the kernel, I wasn't sure it's not used in irq
context.  So I'm not sure I like the idea of making a non-scheduling
function schedule.  But it may not be a problem and it could very well be
ok to schedule here.

Also as Mitchell Blank pointed out, this list should probably be protected
everywhere by the same protection used, and an analysis should be done to
see what replacing the BKL affects.

-- Steve

