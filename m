Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVEKHhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVEKHhj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 03:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVEKHhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 03:37:36 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:18345 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261916AbVEKHha
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 03:37:30 -0400
Subject: Re: [PATCH] sync_sb_inodes cleanup
From: Vladimir Saveliev <vs@namesys.com>
To: Robert Love <rml@novell.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "reiserfs-dev@namesys.com" <reiserfs-dev@namesys.com>
In-Reply-To: <1115739301.6810.15.camel@betsy>
References: <1115737238.4456.320.camel@tribesman.namesys.com>
	 <1115739301.6810.15.camel@betsy>
Content-Type: text/plain
Message-Id: <1115797036.29007.359.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 11 May 2005 11:37:17 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Tue, 2005-05-10 at 19:35, Robert Love wrote:
> On Tue, 2005-05-10 at 19:00 +0400, Vladimir Saveliev wrote:
> 
> > This patch makes generic_sync_sb_inodes to spin lock itself.
> > Please, apply this patch. It helps reiser4 to get rid of some oddities.
> >
> > [snip]
> >
> >  {
> >         const unsigned long start = jiffies;    /* livelock avoidance */
> >  
> > +       spin_lock(&inode_lock);
> 
> Looking at what jiffies is used for, it is probably is not a big deal,
> but you should move the assignment of start to after acquiring the lock,
> as that could take quite some time.
> 

I did not want to un-const start. It would be required for the
assignment move, wouldn't it?

> 	Robert Love
> 
> 
> 

