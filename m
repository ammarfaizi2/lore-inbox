Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbVBXJdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVBXJdO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 04:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVBXJdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 04:33:14 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:64144 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262113AbVBXJdB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 04:33:01 -0500
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] CKRM 1/10: Base CKRM Events 
In-reply-to: Your message of Mon, 29 Nov 2004 13:33:10 PST.
             <20041129213310.GA19892@kroah.com> 
Date: Thu, 24 Feb 2005 01:32:59 -0800
Message-Id: <E1D4FMh-0006uP-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Nov 2004 13:33:10 PST, Greg KH wrote:
> On Mon, Nov 29, 2004 at 10:46:00AM -0800, Gerrit Huizenga wrote:
> > +++ linux-2.6.10-rc2/include/linux/ckrm_events.h	2004-11-19 20:40:52.517303823 -0800

[... snip ...]

> > +#ifdef CONFIG_CKRM
> 
> This ifdef is not needed.

Done - globally.

> > +enum ckrm_event {
> 
> Please use a __bitwise marker for your enum so that sparse will check
> for improper usage of it.
 

Added this to the todo list - we've played with sparse a bit but
I haven't figured out how to do it for enum's correctly yet.  But
will do so soon.

> > +#ifdef __KERNEL__
> 
> Not needed (see the recent thread on lkml for why).

Fixed globally (I think all of them were unnecessary in all of our
current patches - none of the header files are used by user level
apps today).

> > +typedef void (*ckrm_event_cb) (void *arg);
> > +
> > +struct ckrm_hook_cb {
> > +	ckrm_event_cb fct;
> > +	struct ckrm_hook_cb *next;
> 
> Why not use the kernel list structures here instead?
 
Good catch.  Added to TODO list.  This should be trivial but I didn't
get to it this round.

> > +#else /* !CONFIG_CKRM */
> 
> Why have 2 different sections in the same header file for this check?
> Please put them all together.

Yeah - this was stupid, fixed.

> > +#ifdef CONFIG_CKRM
> > +void ckrm_cb_newtask(struct task_struct *);
> > +void ckrm_cb_exit(struct task_struct *);
> > +#else
> > +#define ckrm_cb_newtask(x)	do { } while (0)
> > +#define ckrm_cb_exit(x)		do { } while (0)
> 
> Make these static inlines to get the compiler to check the arguments
> properly.
 
Yep - done.

> > +extern int get_exe_path_name(struct task_struct *, char *, int);
> 
> Should this really be here?
 
Nope.  Gone.

> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ linux-2.6.10-rc2/kernel/ckrm/ckrm_events.c	2004-11-19 20:40:52.526302397 -0800
> > @@ -0,0 +1,97 @@
> > +/* ckrm_events.c - Class-based Kernel Resource Management (CKRM)
> > + *               - event handling routines
> > + *
> > + * Copyright (C) Hubertus Franke, IBM Corp. 2003, 2004
> > + *           (C) Chandra Seetharaman,  IBM Corp. 2003
> > + * 
> > + * 
> > + * Provides API for event registration and handling for different
> > + * classtypes.
> > + *
> > + * Latest version, more details at http://ckrm.sf.net
> > + * 
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + */
> > +
> > +/* Changes
> > + *
> > + * 29 Sep 2004
> > + *        Separated from ckrm.c
> > + *  
> > + */
> 
> No changelogs in files please.
 
Fixed globally.

> > +#define ECC_PRINTK(fmt, args...) \
> > +// printk("%s: " fmt, __FUNCTION__ , ## args)
> 
> Looks like it's unused to me :)
> 
> Use pr_debug() if you want debugging stuff, don't make up your own...

Fixed globally.

gerrit
