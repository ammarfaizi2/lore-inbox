Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVBXJkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVBXJkJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 04:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbVBXJjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 04:39:35 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:33681 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262129AbVBXJdb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 04:33:31 -0500
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] CKRM: 7/10 CKRM: Resource controller for number of tasks 
In-reply-to: Your message of Mon, 29 Nov 2004 15:01:48 PST.
             <20041129230148.GA20828@kroah.com> 
Date: Thu, 24 Feb 2005 01:33:29 -0800
Message-Id: <E1D4FNB-0006vK-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Nov 2004 15:01:48 PST, Greg KH wrote:
> On Mon, Nov 29, 2004 at 10:50:39AM -0800, Gerrit Huizenga wrote:
> > +static spinlock_t stub_lock = SPIN_LOCK_UNLOCKED;
> > +
> > +static get_ref_t real_get_ref = NULL;
> > +static put_ref_t real_put_ref = NULL;
> > +
> > +void ckrm_numtasks_register(get_ref_t gr, put_ref_t pr)
> > +{
> > +	spin_lock(&stub_lock);
> > +	real_get_ref = gr;
> > +	real_put_ref = pr;
> > +	spin_unlock(&stub_lock);
> > +}
> > +
> > +int numtasks_get_ref(void *arg, int force)
> > +{
> > +	int ret = 1;
> > +	spin_lock(&stub_lock);
> > +	if (real_get_ref) {
> > +		ret = (*real_get_ref) (arg, force);
> > +	}
> > +	spin_unlock(&stub_lock);
> > +	return ret;
> > +}
> > +
> > +void numtasks_put_ref(void *arg)
> > +{
> > +	spin_lock(&stub_lock);
> > +	if (real_put_ref) {
> > +		(*real_put_ref) (arg);
> > +	}
> > +	spin_unlock(&stub_lock);
> > +}
> > +
> > +EXPORT_SYMBOL(ckrm_numtasks_register);
> > +EXPORT_SYMBOL(numtasks_get_ref);
> > +EXPORT_SYMBOL(numtasks_put_ref);
> 
> Why are these functions used instead of calling the real functions?
> They are only ever used to register a single set of functions anyway.
 
The real functions are dummy's by default and can be loaded by
a module.  

> Oh, and void * is to be avoided at all costs...
 
Fixed.

thanks,

gerrit
