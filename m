Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWE3VAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWE3VAw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWE3VAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:00:51 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:46289 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932371AbWE3VAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:00:51 -0400
Date: Tue, 30 May 2006 23:01:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [patch 37/61] lock validator: special locking: dcache
Message-ID: <20060530210101.GA28618@elte.hu>
References: <20060529212109.GA2058@elte.hu> <20060529212608.GK3155@elte.hu> <20060529183539.08d3463c.akpm@osdl.org> <1149022268.21827.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149022268.21827.4.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > > +enum dentry_d_lock_type
> > > +{
> > > +	DENTRY_D_LOCK_NORMAL,
> > > +	DENTRY_D_LOCK_NESTED
> > > +};
> > > +
> > >  struct dentry_operations {
> > >  	int (*d_revalidate)(struct dentry *, struct nameidata *);
> > >  	int (*d_hash) (struct dentry *, struct qstr *);
> > 
> > DENTRY_D_LOCK_NORMAL isn't used anywhere.
> 
> I guess it is implied with the normal spin_lock.  Since 
>   spin_lock(&target->d_lock) and
>   spin_lock_nested(&target->d_lock, DENTRY_D_LOCK_NORMAL)
> are equivalent. (DENTRY_D_LOCK_NORMAL == 0)

correct. This is the case for all the subtype enum definitions: 0 means 
normal spinlock [rwlock, rwsem, mutex] API use.

	Ingo
