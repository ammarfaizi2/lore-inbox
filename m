Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933035AbWFWLGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933035AbWFWLGq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 07:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933036AbWFWLGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 07:06:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23257 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933035AbWFWLGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 07:06:45 -0400
Date: Fri, 23 Jun 2006 04:06:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 07/61] lock validator: better lock debugging
Message-Id: <20060623040625.827b2c7c.akpm@osdl.org>
In-Reply-To: <20060623102523.GN4889@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212337.GG3155@elte.hu>
	<20060529183334.d3e7bef9.akpm@osdl.org>
	<20060623102523.GN4889@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 12:25:23 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > +#define DEBUG_WARN_ON(c)						\
> > > +({									\
> > > +	int __ret = 0;							\
> > > +									\
> > > +	if (unlikely(c)) {						\
> > > +		if (debug_locks_off())					\
> > > +			WARN_ON(1);					\
> > > +		__ret = 1;						\
> > > +	}								\
> > > +	__ret;								\
> > > +})
> > 
> > Either the name of this thing is too generic, or we _make_ it generic, 
> > in which case it's in the wrong header file.
> 
> this op is only intended to be used only by the lock debugging 
> infrastructure. So it should be renamed - but i fail to find a good name 
> for it. (it's used quite frequently within the lock debugging code, at 
> 60+ places) Maybe INTERNAL_WARN_ON()? [that makes it sound special 
> enough.] DEBUG_LOCKS_WARN_ON() might work too.

Well it has a debug_locks_off() in there, so DEBUG_LOCKS_WARN_ON() seems right.

