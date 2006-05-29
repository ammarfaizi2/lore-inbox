Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWE2Jn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWE2Jn3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 05:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWE2Jn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 05:43:29 -0400
Received: from cantor2.suse.de ([195.135.220.15]:19923 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750816AbWE2Jn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 05:43:28 -0400
Date: Mon, 29 May 2006 11:43:26 +0200
From: Jan Blunck <jblunck@suse.de>
To: David Chinner <dgc@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@zeniv.linux.org.uk
Subject: Re: [patch 4/5] vfs: per superblock dentry stats
Message-ID: <20060529094326.GF21024@hasse.suse.de>
References: <20060526110655.197949000@suse.de>> <20060526110802.852609000@suse.de> <20060529022401.GT8069029@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529022401.GT8069029@melbourne.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, David Chinner wrote:

> > -struct dentry_stat_t {
> > +struct dentry_stat {
> >  	int nr_dentry;
> >  	int nr_unused;
> > -	int age_limit;          /* age in seconds */
> > -	int want_pages;         /* pages requested by system */
> > -	int dummy[2];
> > +	int age_limit;		/* age in seconds */
> >  };
> 
> that changes the size of the structure from 6*sizeof(int) to
> 3*sizeof(int)....
> 
> > Index: work-2.6/kernel/sysctl.c
> > ===================================================================
> > --- work-2.6.orig/kernel/sysctl.c
> > +++ work-2.6/kernel/sysctl.c
> > @@ -958,7 +958,7 @@ static ctl_table fs_table[] = {
> >  	{
> >  		.ctl_name	= FS_DENTRY,
> >  		.procname	= "dentry-state",
> > -		.data		= &dentry_stat,
> > +		.data		= &global_dentry_stat,
> >  		.maxlen		= 6*sizeof(int),
> 
> With the above change, maxlen = 3*sizeof(int).
> 
> Given that's a userspace visible change, should the above structure
> change use a "int dummy[3];" to keep the global structure and userspace
> export the same?

Hmm, probably you are right. I'll change this.

Jan
