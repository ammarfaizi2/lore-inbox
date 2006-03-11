Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWCKOK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWCKOK0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 09:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWCKOK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 09:10:26 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:1036 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1750724AbWCKOKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 09:10:25 -0500
Date: Sat, 11 Mar 2006 22:10:06 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] autofs4 - follow_link missing funtionality
In-Reply-To: <20060310145016.39b028be.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0603112209360.30816@eagle.themaw.net>
References: <Pine.LNX.4.64.0603102003110.3032@eagle.themaw.net>
 <20060310145016.39b028be.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-1.896,
	required 5, autolearn=not spam, BAYES_00 -2.60,
	DATE_IN_PAST_12_24 0.70)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2006, Andrew Morton wrote:

> Ian Kent <raven@themaw.net> wrote:
> >
> > @@ -337,10 +340,34 @@ static void *autofs4_follow_link(struct 
> >  	if (oz_mode || !lookup_type)
> >  		goto done;
> >  
> > +	/*
> > +	 * If the dentry contains directories then it is an
> > +	 * autofs multi-mount with no root offset. So don't
> > +	 * try to mount it again.
> > +	 */
> > +	spin_lock(&dcache_lock);
> > +	if (!list_empty(&dentry->d_subdirs)) {
> > +		spin_unlock(&dcache_lock);
> > +		goto done;
> > +	}
> > +	spin_unlock(&dcache_lock);
> > +
> 
> Can list_empty(&dentry->d_subdirs) become false right here, after the lock
> was dropped?  If so, what happens?

Yep. I think so.
Not what I want to happen.

> 
> 
> >  	status = try_to_fill_dentry(dentry, 0);
> 

