Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbVBXKN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVBXKN2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 05:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVBXKMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 05:12:24 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:27288 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262133AbVBXJdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 04:33:35 -0500
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] CKRM: 5/10 CKRM: Task based management for CPU, memory and Disk I/O. 
In-reply-to: Your message of Mon, 29 Nov 2004 14:23:23 PST.
             <20041129222323.GE19892@kroah.com> 
Date: Thu, 24 Feb 2005 01:33:23 -0800
Message-Id: <E1D4FN5-0006vB-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Nov 2004 14:23:23 PST, Greg KH wrote:
> On Mon, Nov 29, 2004 at 10:49:09AM -0800, Gerrit Huizenga wrote:
> > +#define TC_DEBUG(fmt, args...) do { \
> > +/* printk("%s: " fmt, __FUNCTION__ , ## args); */ } while (0)
> 
> Again with the new debug macro :(
> 
> > +static struct ckrm_task_class taskclass_dflt_class = {
> > +};
> 
> Empty structure?  Why?
 
Initialized definition, not declaration.  Although with no initializer
which was a bit odd.  struct ckrm_task_class is defined in ckrm_tc.h.

> > +// Hubertus .. following functions should move to ckrm_rc.h
> 
> Why haven't they moved :)

Because we aren't done yet.  ;-)

> > +static inline void ckrm_task_lock(struct task_struct *tsk)
> > +{
> > +	spin_lock(&tsk->ckrm_tsklock);
> > +}
> 
> Just lock (or unlock) the lock, don't wrap a lock in a function.
 
Yep.  Done.

> > +DECLARE_MUTEX(async_serializer);	// serialize all async functions
> 
> Should this really be global?  The code says otherwise :)
 
Not any more.

> > +	printk("...... Initializing ClassType<%s> ........\n",
> > +	       CT_taskclass.name);
> 
> What a pretty log message.  Unfortunately it's wrong (me hears the
> growing mumblings of the kernel janitor mob...)
 
Yep - fixed.

> > +#if 0
> > +
> > +/******************************************************************************
> > + * Debugging Task Classes:  Utility functions
> > + ******************************************************************************/
> 
> Then remove the code, if it's not needed.
 
Okay.  I can easily carry a debug patch later.  Should have done that
sooner...

> > +EXPORT_SYMBOL(tcp_v4_lookup_listener);
> 
> Not EXPORT_SYMBOL_GPL()?
 
Currently makes it just like all the others.  I'll let the networking
folks chime in on how they want that exported when this patch gets
cross posted to netdev.

thanks,

gerrit
