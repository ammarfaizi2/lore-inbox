Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWABNCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWABNCL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 08:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWABNCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 08:02:11 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:42492 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750712AbWABNCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 08:02:10 -0500
Subject: Re: [PATCH] protect remove_proc_entry
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <20051230154647.5a38227e.akpm@osdl.org>
References: <1135973075.6039.63.camel@localhost.localdomain>
	 <1135978110.6039.81.camel@localhost.localdomain>
	 <20051230154647.5a38227e.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 02 Jan 2006 08:02:01 -0500
Message-Id: <1136206921.6039.159.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 15:46 -0800, Andrew Morton wrote:
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

FWIW,

My test that would crash within two days has been running for three days
now with the lock_kernel patch.  So, at least this fixes the problem,
whether we use another locking or not, it's good to know what to fix.

-- Steve


