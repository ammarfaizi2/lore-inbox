Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWFUChu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWFUChu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 22:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWFUCht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 22:37:49 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:29580 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750800AbWFUChs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 22:37:48 -0400
Subject: Re: [Lse-tech] [PATCH 09/11] Task watchers: Add support for
	per-task watchers
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: pwil3058@bigpond.net.au, Shailabh Nagar <nagar@watson.ibm.com>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       "John T. Kohl" <jtk@us.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Jes Sorensen <jes@sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       LSE <lse-tech@lists.sourceforge.net>
In-Reply-To: <20060620184617.7dbefed8.akpm@osdl.org>
References: <20060613235122.130021000@localhost.localdomain>
	 <1150242901.21787.149.camel@stark> <44978793.8070109@bigpond.net.au>
	 <1150844177.21787.774.camel@stark> <20060620161524.7c132eea.akpm@osdl.org>
	 <1150852848.21787.828.camel@stark>  <20060620184617.7dbefed8.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 19:28:55 -0700
Message-Id: <1150856935.21787.875.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 18:46 -0700, Andrew Morton wrote:
> On Tue, 20 Jun 2006 18:20:48 -0700
> Matt Helsley <matthltc@us.ibm.com> wrote:
> 
> > > > > > +static inline int notify_per_task_watchers(unsigned int val,
> > > > > > +					   struct task_struct *task)
> > > > > > +{
> > > > > > +	if (get_watch_event(val) != WATCH_TASK_INIT)
> > > > > > +		return raw_notifier_call_chain(&task->notify, val, task);
> > > > > > +	RAW_INIT_NOTIFIER_HEAD(&task->notify);
> > > > > > +	if (task->real_parent)
> > > > > > +		return raw_notifier_call_chain(&task->real_parent->notify,
> > > > > > +		   			       val, task);
> > > > > > +}
> > > > > 
> > > > > It's possible for this task to exit without returning a result.
> > > > 
> > > > Assuming you meant s/task/function/:
> > > > 
> > > > 	In the common case this will return a result because most tasks have a
> > > > real parent. The only exception should be the init task. However, the
> > > > init task does not "fork" from another task so this function will never
> > > > get called with WATCH_TASK_INIT and the init task.
> > > > 
> > > > 	This means that if one wants to use per-task watchers to associate data
> > > > and a function call with *every* task, special care will need to be
> > > > taken to register with the init task.
> > > 
> > > no......
> > 
> > 	I've been looking through the source and, from what I can see, the end
> > of the function is not reachable. I think I need to add:
> > 
> > notify_watchers(WATCH_TASK_INIT, &init_task);
> > 
> > to make this into an applicable warning.
> 
> If the end of the function isn't reachable then the
> `if (task->real_parent)' can simply be removed.

You're right -- good point.

Cheers,
	-Matt Helsley

